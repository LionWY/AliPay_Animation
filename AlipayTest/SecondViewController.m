//
//  SecondViewController.m
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import "SecondViewController.h"
#import "Model.h"

@interface SecondViewController ()<ModelDelegate>
{
    CGPoint _touchPoint;
}


@property (nonatomic, strong) NSMutableArray *currentArr;
@property (nonatomic, strong) NSMutableArray *addArr;
@property (nonatomic, strong) Model *currentModel;

@end

@implementation SecondViewController

- (void)pop
{
    if (self.popBlock) {
        self.popBlock(_addArr);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pop)];
    
    
    [self.navigationItem setLeftBarButtonItem:item];
    
    
    _currentArr = @[@"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20"].mutableCopy;
    
    _addArr = [[NSMutableArray alloc] init];
    [self loadBtnArr];
    
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

- (void)deleteWith:(Model *)aModel
{
    if ([_currentArr count] > 1) {
        
        [aModel removeFromSuperview];
        [_addArr addObject:[_currentArr objectAtIndex:aModel.tag - 100]];
        [_currentArr removeObjectAtIndex:aModel.tag - 100];
        
        [self revertToBack];
        
        for (NSInteger i = aModel.tag; i < 101 + [_currentArr count]; i ++) {
            Model * obj = (Model *)[self.view viewWithTag:i];
            obj.tag --;
            //                            [self resetModelFrameWithModel:obj];
            [obj resetModelFrame];
        }
    }
}
- (void)loadBtnArr
{
    for (NSInteger i = 0; i < 3; i ++) {
        for (NSInteger j = 0; j < 4; j ++) {
            NSInteger index = j + i * 4;
            
            if (index < [_currentArr count]) {
                
                Model *model = [[Model alloc] initWithFrame:CGRectMake(j * WIDTH, (i + 3) * HEIGHT, WIDTH, HEIGHT) withTag:100 + index withIsChecker:NO withIsPlus:YES withHasMoreModel:YES];
                [model addTarget:self action:@selector(modelClick:) forControlEvents:UIControlEventTouchUpInside];
                model.delegate = self;
                [model setTitle:[_currentArr objectAtIndex:index] forState:UIControlStateNormal];
                [self.view addSubview:model];

/****               
                model.minusBlock = ^(Model *aModel)
                {
                    
                    if ([_currentArr count] > 1) {
                        
                        [aModel removeFromSuperview];
                        [_addArr addObject:[_currentArr objectAtIndex:aModel.tag - 100]];
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
//            这句话跟下面那句话，要思考下为什么这么写，
            for (NSInteger i = aModel.tag - 1; i > destinationModel.tag - 1; i -- ) {
                Model *obj = (Model *)[self.view viewWithTag:i];
                obj.tag += 1;
                
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
    
}

- (void)longPressBeginWith:(Model *)aModel withGesture:(UILongPressGestureRecognizer *)aGesture
{
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
