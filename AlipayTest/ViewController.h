//
//  ViewController.h
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface ViewController : UIViewController<ModelDelegate>



@property (nonatomic, strong) NSMutableArray *currentArr;

@end

