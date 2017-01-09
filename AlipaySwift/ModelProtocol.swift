//
//  ModelProtocol.swift
//  AlipaySwift
//
//  Created by FOODING on 17/1/41.
//  Copyright © 2017年 Noohle. All rights reserved.
//

import Foundation
import UIKit

protocol ModelDelegate {
    
    var touchPoint: CGPoint { get set}
    
    func delete(model: Model) 
    
    func add(model: Model)
    
    func longPressBegin(model: Model, gesture: UILongPressGestureRecognizer)
    
    func longPressChange(model: Model, gesture: UILongPressGestureRecognizer)
    
    func longPressEnd(model: Model, gesture: UILongPressGestureRecognizer)
    
}
