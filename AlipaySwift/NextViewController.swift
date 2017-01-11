//
//  NextViewController.swift
//  AlipaySwift
//
//  Created by FOODING on 17/1/41.
//  Copyright © 2017年 Noohle. All rights reserved.
//

import UIKit

typealias backBlock = (_ arr: Array<String>) -> Void

class NextViewController: UIViewController {
    
    let width = Int(UIScreen.main.bounds.size.width / 4)
    
    let height = 80
    
    var popBlock: backBlock?
    
    
    
    
    

    @IBAction func back(_ sender: Any) {
        
        
        if Util.addData.count > 0 {
            self.popBlock!(Util.addData)
        }
        
        
        
        
        self.navigationController!.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Util.addData = []

        // Do any additional setup after loading the view.
        
        
        
        let aliview = AliView.init(frame: CGRect(x: 0, y: 100, width: width * 4, height: height * 3), hasMore: false)
        
        aliview.backgroundColor = UIColor.cyan
        
        
        aliview.loadModels(arr: Util.nextData)
        
        
        aliview.modelBlock = {
            model in
            print(model.tag)
            
        }
        
        self.view.addSubview(aliview)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
