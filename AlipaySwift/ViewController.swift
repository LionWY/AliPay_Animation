//
//  ViewController.swift
//  AlipaySwift
//
//  Created by FOODING on 17/1/41.
//  Copyright © 2017年 Noohle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gestureView = UIView()
    
    var startPoint = CGPoint.zero
    
    let width = Int(UIScreen.main.bounds.size.width / 4)
    
    let height = 80
    
    var aliview = AliView() 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        aliview = AliView.init(frame: CGRect(x: 0, y: 100, width: width * 4, height: height * 3), hasMore: true)
        
        aliview.backgroundColor = UIColor.cyan
        aliview.loadModels(arr: Util.currentData)
        
        aliview.moreBlock = {
            self.goToNext()
        }
        
        aliview.modelBlock = {
            model in
            print(model.title)
        }
        
        self.view.addSubview(aliview)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToNext() {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let next = main.instantiateViewController(withIdentifier: "next") as! NextViewController
        
        next.popBlock = {
            data in 
            
            self.aliview.reloadModels(arr: data)
        }
        
        self.navigationController?.pushViewController(next, animated: true)

    }
    
    


}

