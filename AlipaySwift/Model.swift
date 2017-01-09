//
//  Model.swift
//  AlipaySwift
//
//  Created by FOODING on 17/1/41.
//  Copyright © 2017年 Noohle. All rights reserved.
//

import UIKit


class Model: UIButton {
    
    let width = Int(UIScreen.main.bounds.size.width / 4)
    
    let height = 80
    
    var _isCheck: Bool = false {
        didSet {
            
            self.isSelected = _isCheck
            
            self.handleBtn.isHidden = !_isCheck
            
            UIView.animate(withDuration: 0.2) { 
                self.transform = self._isCheck ? CGAffineTransform(scaleX: 1.2, y: 1.2) : CGAffineTransform.identity
            }
            
            self.superview?.bringSubview(toFront: self)
        }
    }
    
    var delegate: ModelDelegate? 
    
    var title: String!
    
    var handleBtn: UIButton!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    init(frame: CGRect, tag: Int, isNextPage: Bool, isMore: Bool) {
        
        super.init(frame: frame)
        
//        print("==========\(tag)")
        
        self.tag = tag
        
        self.layer.cornerRadius = 8.0
        
        self.layer.borderColor = UIColor.init(colorLiteralRed: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1).cgColor
        
        self.layer.masksToBounds = true
        
        self.setBackgroundImage(UIImage(named: "app_item_bg"), for: .normal)
        self.setBackgroundImage(UIImage(named: "app_item_pressed_bg"), for: .selected)
        self.setTitleColor(UIColor.darkGray, for: .normal)
        
        if !isMore  {
            handleBtn = UIButton(type: .custom)
            handleBtn.frame = CGRect(x: frame.size.width - 16, y: 2, width: 16, height: 16)
            
            handleBtn.setBackgroundImage(UIImage(named: "app_item_minus"), for: .normal)
            
            if isNextPage {
                
                handleBtn.setBackgroundImage(UIImage(named: "app_item_plus"), for: .normal)
                handleBtn.addTarget(self, action: #selector(plusBtnClick), for: .touchUpInside)
                
            } else {
                handleBtn.addTarget(self, action: #selector(minusBtnClick), for: .touchUpInside)
            }
            
            self.addSubview(handleBtn)
            
            handleBtn.isHidden = true
            
            let gesture = UILongPressGestureRecognizer(target: self, action: #selector(gestureLongPress))
            
            self.addGestureRecognizer(gesture)       
            
        }        
        
    }
    
    func resetModelFrame() {
        
        let index = self.tag - 100
        
        let i = index / 4
        let j = index % 4
        
        UIView.animate(withDuration: 0.2) { 
            self.frame = CGRect(x: j * self.width, y: i * self.height, width: self.width, height: self.height)
        }
        
        
        
        
    }
    func gestureLongPress(gesture: UILongPressGestureRecognizer) {
        
        
        switch gesture.state {
        case .began:
            
            
            self.delegate?.longPressBegin(model: self, gesture: gesture)
            
            break
            
        case .changed: 
            
            self.delegate?.longPressChange(model: self, gesture: gesture)
            
            break
        case .ended: 
            
            self.delegate?.longPressEnd(model: self, gesture: gesture)
            
            break
            
        default:
            print("default")
        }
        
        
    }
    
    func plusBtnClick() {
        
        self.delegate?.add(model: self)
    }
    
    func minusBtnClick(){
        
        self.delegate?.delete(model: self)
    }
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        
        
        self.title = title
    }

    
    
    

}
