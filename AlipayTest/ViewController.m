//
//  ViewController.m
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import "ViewController.h"

#import "SecondViewController.h"

@interface ViewController ()
{

    CGPoint _touchPoint;

}
@property (nonatomic, strong) Model *currentModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _currentArr = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"100"].mutableCopy;
    
    
    
    [self loadBtnArr];
    
    
}

- (void)loadModelWithIsMore:(BOOL)flag WithIndex:(NSInteger)aIndex withTitle:(NSString *)aTitle
{
    Model *model = [[Model alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) withTag:aIndex withIsPlus:NO withIsMoreModel:flag];
    [model addTarget:self action:@selector(modelClick:) forControlEvents:UIControlEventTouchUpInside];
    model.delegate = self;
    [model setTitle:aTitle forState:UIControlStateNormal];
    
    [self.view addSubview:model];
    
    [model resetModelFrame];
}

/**
 *  回复原状
 */
- (void)revertToBack
{
    if (self.currentModel) {
        self.currentModel.isCheck = NO;
        self.currentModel = nil;
    }
}
/**
 *  加载页面btn
 */
- (void)loadBtnArr
{
    for (NSInteger i = 0; i < 3; i ++) {
        for (NSInteger j = 0; j < 4; j ++) {
            NSInteger index = j + i * 4;
            
            if (index < [_currentArr count]) {
                
//                Model *model;
                if (index == [_currentArr count] - 1) {
                    
                    [self loadModelWithIsMore:YES WithIndex:100 + index withTitle:[_currentArr objectAtIndex:index]];
                    
                }
                else
                {
                    
                    [self loadModelWithIsMore:NO WithIndex:100 + index withTitle:[_currentArr objectAtIndex:index]];
                    
                }
                
/*****              
                model.minusBlock = ^(Model *aModel)
                {
                    
                    if ([_currentArr count] > 1) {
                        
                        [aModel removeFromSuperview];
                        [_currentArr removeObjectAtIndex:aModel.tag - 100];
                        
                        [self revertToBack];
                        
                        for (NSInteger i = aModel.tag; i < 101 + [_currentArr count]; i ++) {
                            Model * obj = (Model *)[self.view viewWithTag:i];
                            obj.tag --;
//                            [self resetModelFrameWithModel:obj];
                            [obj resetModelFrame];
                        }
                    }
                    
                    
                    
                    
                    
                    
                };
                model.beginBlock = ^(Model *aModel, UILongPressGestureRecognizer *gesture)
                {
                    
                    if (aModel.tag == [_currentArr count] + 99) {
                        return ;
                    }
                    
                    if (self.currentModel == aModel) {
                        
                        self.currentModel.isCheck = YES;
                    }
                    else
                    {
                            
                        self.currentModel.isCheck = NO;
                        self.currentModel = aModel;
                        self.currentModel.isCheck = YES;

                    }
                    
                    _touchPoint = [gesture locationInView:gesture.view];
                    
//                    移动model块的初始center
//                    _startPoint = self.currentModel.center;
                    
                     
                    
                };
                model.changeBlock = ^(Model *aModel, UILongPressGestureRecognizer *gesture)
                {
                   
                    CGPoint newPoint = [gesture locationInView:gesture.view];
                    
                    CGFloat newX = newPoint.x - _touchPoint.x;
                    CGFloat newY = newPoint.y - _touchPoint.y;
                    
                    CGPoint endPoint = CGPointMake(aModel.center.x + newX, aModel.center.y + newY);
                    
                    //当前模块根据移动不断更改自身位置
                    aModel.center = endPoint;    
                    
                    
                    [self locationChangeWithModel:aModel withEndPoint:endPoint];
                    
                     
                };
                model.endBlock = ^(Model *aModel, UILongPressGestureRecognizer *gesture)
                {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.currentModel.transform = CGAffineTransformIdentity;
                    }];

                    
//                    [self resetModelFrameWithModel:aModel];
                    [aModel resetModelFrame];
                    
                    
                };
                model.cancelBlock = ^(Model *aModel, UILongPressGestureRecognizer *gesture)
                {
                    
                };
 ***/  
                
               
                
                
                
            }
            
        }
    }
}
/**
 *  根据模块移动，进行相关模块的位置变动
 *
 *  @param aModel 移动的模块
 *  @param aPoint 最终的位置
 */
- (void)locationChangeWithModel:(Model *)aModel withEndPoint:(CGPoint)aPoint
{
    
    Model *destinationModel = nil;
    
    for (NSInteger i = 100; i < 99 + [_currentArr count]; i ++) {
        
        Model *obj = (Model *)[self.view viewWithTag:i];
        
        if (obj != aModel) {
            if (CGRectContainsPoint(obj.frame, aPoint)) {
                
                destinationModel = obj;
                
            }
        }
        
    }
    
    
    if (!destinationModel) {
        
    }
    else
    {
        
        //从后往前移动模块
        if (aModel.tag > destinationModel.tag) {
            
            for (NSInteger i = aModel.tag - 1; i > destinationModel.tag - 1; i -- ) {
                Model *obj = (Model *)[self.view viewWithTag:i];
                obj.tag += 1;
//                [self resetModelFrameWithModel:obj];
                [obj resetModelFrame];
                
            }
            aModel.tag = destinationModel.tag - 1;
            
            
        }
        else if (aModel.tag < destinationModel.tag)//从前往后移动模块
        {
            
            for (NSInteger i = aModel.tag + 1; i < destinationModel.tag + 1; i ++ ) {
                Model *obj = (Model *)[self.view viewWithTag:i];
                obj.tag -= 1;
//                [self resetModelFrameWithModel:obj];
                [obj resetModelFrame];
                
            }
            aModel.tag = destinationModel.tag + 1;
        }
        
        
        
    }
}
- (void)modelClick:(Model *)aModel
{
    if (self.currentModel) {
        [self revertToBack];
    }
    
    if (aModel.tag == [_currentArr count] + 99) {
        SecondViewController * vc = [[SecondViewController alloc] init];
        vc.popBlock = ^(NSArray *arr)
        {
            
            if (arr && [arr count] >= 1) {
                Model *model = (Model *)[self.view viewWithTag:99 + [_currentArr count]];
                
                model.tag = 99 +  [_currentArr count] + [arr count];
                [model resetModelFrame];
                
                
                for (NSInteger i = [_currentArr count] + 100; i < [_currentArr count] + [arr count] + 100; i ++) {
                    
                    [self loadModelWithIsMore:NO WithIndex:i - 1 withTitle:[arr objectAtIndex:i - [_currentArr count] - 100]];
                    
                    
//                    Model *aModel = [[Model alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) withTag:i - 1 withIsChecker:NO withIsPlus:NO withIsMoreModel:NO];
//                    [aModel addTarget:self action:@selector(modelClick:) forControlEvents:UIControlEventTouchUpInside];
//                    aModel.delegate = self;
//                    [aModel setTitle:[arr objectAtIndex:i - [_currentArr count] - 100]forState:UIControlStateNormal];
//                    [aModel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//                    [self.view addSubview:aModel];
//                    [aModel resetModelFrame];
                }
                [_currentArr addObjectsFromArray:arr];
            }
           
            
        };
        [self.navigationController showViewController:vc sender:nil];
    }
    
}


#pragma mark - ModelDelegate
- (void)deleteWith:(Model *)aModel
{
    
    if ([_currentArr count] > 1) {
        
        [aModel removeFromSuperview];
        [_currentArr removeObjectAtIndex:aModel.tag - 100];
        
        [self revertToBack];
        
//        只对需要改变位置的model进行操作
        for (NSInteger i = aModel.tag; i < 101 + [_currentArr count]; i ++) {
            Model * obj = (Model *)[self.view viewWithTag:i];
            obj.tag --;
            
            [obj resetModelFrame];
        }
    }
    
    
    
    
    
    
}
- (void)longPressBeginWith:(Model *)aModel withGesture:(UILongPressGestureRecognizer *)aGesture
{
    
    if (aModel.tag == [_currentArr count] + 99) {
        return ;
    }
    
    if (self.currentModel == aModel) {
        
        self.currentModel.isCheck = YES;
    }
    else
    {
        
        self.currentModel.isCheck = NO;
        self.currentModel = aModel;
        self.currentModel.isCheck = YES;
        
    }
    
    _touchPoint = [aGesture locationInView:aGesture.view];
    
    
    
    
    
}
- (void)longPressChangeWith:(Model *)aModel withGesture:(UILongPressGestureRecognizer *)aGesture
{
    
    CGPoint newPoint = [aGesture locationInView:aGesture.view];
    
    CGFloat newX = newPoint.x - _touchPoint.x;
    CGFloat newY = newPoint.y - _touchPoint.y;
    
    CGPoint endPoint = CGPointMake(aModel.center.x + newX, aModel.center.y + newY);
    
    //当前模块根据移动不断更改自身位置
    aModel.center = endPoint;    
    
    
    [self locationChangeWithModel:aModel withEndPoint:endPoint];
    
    
}
- (void)longPressEndWith:(Model *)aModel withGesture:(UILongPressGestureRecognizer *)aGesture
{
    [UIView animateWithDuration:0.2 animations:^{
        self.currentModel.transform = CGAffineTransformIdentity;
    }];
    

    [aModel resetModelFrame];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
