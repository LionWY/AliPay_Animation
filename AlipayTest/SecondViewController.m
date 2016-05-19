//
//  SecondViewController.m
//  AlipayTest
//
//  Created by FOODING on 16/5/19.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import "SecondViewController.h"
#import "AliView.h"
#import "AppDelegate.h"

@interface SecondViewController ()
{
    AliView *_aliView;
}



@end

@implementation SecondViewController

- (void)pop
{
    AppDelegate *app = KAPPDELEGATE;
    if (self.popBlock) {
        self.popBlock(app.addArray);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(pop)];
    [self.navigationItem setLeftBarButtonItem:left];
    

    self.addArr = [[NSMutableArray alloc] init];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    AppDelegate *app = KAPPDELEGATE;
    
    
    
    _aliView = [[AliView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 200) withHasMore:NO];
    
    [_aliView loadBtnArrWithArr:app.lastArray];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
