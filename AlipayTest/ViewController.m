//
//  ViewController.m
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#import "SecondViewController.h"

@interface ViewController ()
{
    
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *app = KAPPDELEGATE;
    
     
    __weak ViewController *weakSelf = self;
    
    _aliView = [[AliView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 200) withHasMore:YES];
    
    [_aliView loadBtnArrWithArr:app.currentArray];
    
    
    
    _aliView.moreBlock = ^
    {
        SecondViewController *secondVC = [[SecondViewController alloc] init];
        
        [weakSelf.navigationController showViewController:secondVC sender:nil];
        
        secondVC.popBlock = ^(NSArray *arr)
        {
            [weakSelf.aliView reloadBtnArrWithArr:arr];
            
        };
        
    };
    
    _aliView.clickBlock = ^(Model *aModel)
    {
        NSLog(@"当前点击的是%@", aModel.title);
    };
    
    [self.view addSubview:_aliView];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
