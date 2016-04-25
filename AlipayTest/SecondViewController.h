//
//  SecondViewController.h
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopBlock)(NSArray *addArr);


@interface SecondViewController : UIViewController


@property (nonatomic, copy) PopBlock popBlock;

@end
