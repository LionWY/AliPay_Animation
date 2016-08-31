//
//  SecondViewController.h
//  AlipayTest
//
//  Created by FOODING on 16/5/19.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *addArr;
@property (nonatomic, copy) void (^popBlock)(NSArray *arr);

@end
