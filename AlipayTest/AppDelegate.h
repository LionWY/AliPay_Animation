//
//  AppDelegate.h
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//存储当前显示的数组和显示不下的数组
@property (nonatomic, strong) NSMutableArray *currentArray;
@property (nonatomic, strong) NSMutableArray *lastArray;
@property (nonatomic, strong) NSMutableArray *addArray;


@end

