//
//  AliView.swift
//  AlipaySwift
//
//  Created by FOODING on 17/1/41.
//  Copyright © 2017年 Noohle. All rights reserved.
//

import UIKit



typealias moreBlock = () -> Void

typealias modelBlock = (_ model: Model) -> Void



class AliView: UIView {
    
    var moreBlock: moreBlock?
    
    var modelBlock: modelBlock?
    
    var currentModel: Model?
    
    let width = Int(UIScreen.main.bounds.size.width / 4)
    
    let height = 80
    
    
    
    var currentArr: Array<String>?
    
    var touchPoint = CGPoint(x: 0, y: 0)

    var hasMore: Bool = true
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
   
    
    convenience init(frame: CGRect, hasMore: Bool) {
        
        
        
        self.init(frame: frame)
        
        self.hasMore = hasMore
        
        
        
        self.currentArr = hasMore ? Util.currentData : Util.nextData
       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addModel(index: Int, title: String, isMore: Bool) {
        
        let model = Model(frame: CGRect(x: 0, y: 0, width: width, height: height), tag: index, isNextPage: 
            !self.hasMore, isMore: isMore)
        
        model.delegate = self
        
        model.addTarget(self, action: #selector(modelClick(_:)), for: .touchUpInside)
        
        model.setTitle(title, for: .normal)
        
        model.resetModelFrame()
        
        self.addSubview(model)
        
    
    }
    
    func modelClick(_ model: Model) {
        
        
            
        if model.tag == (self.currentArr?.count)! + 100 {
            self.moreBlock!()
        } else {
            self.revertToBack()
            self.modelBlock!(model)
        }
            
        
        
    }
    
    // pop 返回时，更新第一页的布局
    func reloadModels(arr: [String]) {
        
        if arr.count > 0 {
            // more Btn
            let more = self.viewWithTag(100 + (self.currentArr?.count)!) as? Model
            
            more?.tag += arr.count
            
            more?.resetModelFrame()
            
            for (_, title) in arr.enumerated() {
                
                self.addModel(index: 100 + (self.currentArr?.count)!, title: title, isMore: false)
                
                self.currentArr?.append(title)
                Util.currentData.append(title)
            }
            
            
        }
        
    }
    
    func loadModels(arr: Array<String>) {
        
        self.currentArr = arr;
        
        if self.hasMore {
            for row in 0..<3 {
                for column in 0..<4 {
                    let index = row * 4 + column
                    
                    if index < (self.currentArr?.count)! + 1 {
                        
                        print("-----------\(index)")
                        
                        if index == self.currentArr?.count {
                            self.addModel(index: index + 100, title: "More", isMore: true)
                        } else {
                            self.addModel(index: index + 100, title: arr[index], isMore: false)
                        }
                        
                        
                    }
                }
            }
        } else {
            
            for (index, title) in (self.currentArr?.enumerated())! {
                
                self.addModel(index: index + 100, title: title, isMore: false)
                
            }
        }
        
    }
    
    
    func handleModels(model: Model) {
        if (self.currentArr?.count)! > 1 {
            
            model.removeFromSuperview()
            
            self.currentArr?.remove(at: model.tag - 100)
            
            self.revertToBack()
            
            for index in model.tag ... 101 + (self.currentArr?.count)! {
             
                let mo = self.viewWithTag(index) as? Model
                
                mo?.tag -= 1
                
                mo?.resetModelFrame()
            }
            
            
        }
    }
    
    func revertToBack() {
        if (self.currentModel != nil) {
            self.currentModel?._isCheck = false
            self.currentModel = nil
            
        }
    }
    
    

}

extension AliView: ModelDelegate {
    

//    var touchPoint: CGPoint {
//        get {
//            return self.touchPoint
//        }
//        set(newValue) {
//            self.touchPoint = newValue
//        }
//    }
    
    func changeLocation(model: Model) {
        
        var destinationModel: Model?
        
        for index in 0..<(self.currentArr?.count)! {
            let mo = self.viewWithTag(100 + index) as? Model
            
            
            
            if (mo != model) && (mo != nil) && (mo?.frame.contains(model.center))! {
                
                
                
                destinationModel = mo
                
                break
            }
            
        }
        
        guard destinationModel != nil else {
//            print("NO destinationModel")
            return
        }
        
        self.currentArr?.remove(at: model.tag - 100)
        
        self.currentArr?.insert(model.title, at: (destinationModel?.tag)! - 100)
        
        // 从后往前移动
        if (destinationModel?.tag)! < model.tag {
            
            
         
            for index in ((destinationModel?.tag)!..<model.tag).reversed() {
                
                let aModel = self.viewWithTag(index) as? Model
                
                aModel?.tag += 1
                
                aModel?.resetModelFrame()
                
            }
            
            model.tag = (destinationModel?.tag)! - 1
            
            
        } else {
            for index in model.tag + 1...(destinationModel?.tag)! {
                
                let aModel = self.viewWithTag(index) as! Model
                aModel.tag -= 1
                
                
                aModel.resetModelFrame()
                
            }
            
            model.tag = (destinationModel?.tag)! + 1
        }
        
        
    }
    
    
    func longPressBegin(model: Model, gesture: UILongPressGestureRecognizer) {
        
        guard model.tag != 100 + (self.currentArr?.count)! else {
            print("more")
            
            return
        }
        
        if self.currentModel == model {
            currentModel?._isCheck = true
        } else {
            currentModel?._isCheck = false
            
            currentModel = model
            
            currentModel?._isCheck = true
        }
        
        
       touchPoint = gesture.location(in: gesture.view)
        
        
    }
    
    func longPressChange(model: Model, gesture: UILongPressGestureRecognizer) {
        
        let newPoint = gesture.location(in: gesture.view)
        
        let newX = newPoint.x - touchPoint.x
        
        let newY = newPoint.y - touchPoint.y
        
        let endPoint = CGPoint(x: newX + model.center.x, y: newY + model.center.y)
        
        model.center = endPoint
        
        self.changeLocation(model: model)
        
    }
    
    func longPressEnd(model: Model, gesture: UILongPressGestureRecognizer) {
        
        UIView.animate(withDuration: 0.2) { 
            self.currentModel?.transform = CGAffineTransform.identity
        }
        
        model.resetModelFrame()
    }
    
    func delete(model: Model) {
        
        Util.currentData.remove(at: model.tag - 100)
        
        Util.nextData.append(model.title)
        
        self.handleModels(model: model)
        
       
        
    }
    
    func add(model: Model) {
        
        Util.nextData.remove(at: model.tag - 100)
        
        Util.addData.append(model.title)
        
        self.handleModels(model: model)
        
    }
}
