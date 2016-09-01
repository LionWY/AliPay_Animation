//
//  AliView.m
//  TestView
//
//  Created by FOODING on 16/5/4.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import "AliView.h"
#import "AppDelegate.h"

@interface AliView () {

    Model *currentModel;

    CGPoint touchPoint;
}

@end

@implementation AliView

- (id)initWithFrame:(CGRect)frame withHasMore:(BOOL)hasMore {
    if (self = [super initWithFrame:frame]) {

        self.hasMore = hasMore;
    }
    return self;
}
- (void)loadModelWithIndex:(NSInteger)aIndex
                 withTitle:(NSString *)aTitle
                withIsMore:(BOOL)aMore {
    Model *model = [[Model alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)
                                        withTag:aIndex
                                     withIsPlus:!self.hasMore
                                     withIsMore:aMore];
    [model addTarget:self
                  action:@selector(modelClick:)
        forControlEvents:UIControlEventTouchUpInside];
    model.delegate = self;
    [model setTitle:aTitle forState:UIControlStateNormal];

    [self addSubview:model];

    [model resetModelFrame];
}

- (void)reloadBtnArrWithArr:(NSArray *)aArr {

    if (aArr && [aArr count] >= 1) {
        Model *model =
            (Model *) [self viewWithTag:100 + [_currentArr count] - [aArr count]];

        model.tag = 100 + [_currentArr count];
        [model resetModelFrame];

        for (NSInteger i = [_currentArr count] + 100 - [aArr count];
             i < [_currentArr count] + 100; i++) {

            [self loadModelWithIndex:i
                           withTitle:[_currentArr objectAtIndex:i - 100]
                          withIsMore:NO];
        }
    }

    AppDelegate *app = KAPPDELEGATE;
    [app.addArray removeAllObjects];
}

- (void)loadBtnArrWithArr:(NSMutableArray *)aArr {
    //    浅拷贝，
    _currentArr = aArr;
    
    //第一页，有更多的按钮
    if (self.hasMore) {
        
        for (NSInteger i = 0; i < 3; i++) {
            for (NSInteger j = 0; j < 4; j++) {
                NSInteger index = j + i * 4;
                
                if (index < [_currentArr count] + 1) {
                    
                    if (index == [_currentArr count]) {
                        
                        [self loadModelWithIndex:100 + index
                                       withTitle:@"More"
                                      withIsMore:YES];
                    } else {
                        
                        [self loadModelWithIndex:100 + index
                                       withTitle:[_currentArr objectAtIndex:index]
                                      withIsMore:NO];
                        
                    }
                }
            }
        }
        
    }
    else
    {
        for (NSInteger index = 0; index < [_currentArr count]; index++) {
            [self loadModelWithIndex:100 + index withTitle:[_currentArr objectAtIndex:index] withIsMore:NO];
        }
    }
    
    
    


}

/**
 *  根据模块移动，进行相关模块的位置变动
 *
 *  @param aModel 移动的模块
 *  @param aPoint 最终的位置
 */
- (void)locationChangeWithModel:(Model *)aModel withEndPoint:(CGPoint)aPoint {

    Model *destinationModel = nil;

    for (NSInteger i = 100; i < 100 + [_currentArr count]; i++) {

        Model *obj = (Model *) [self viewWithTag:i];

        if (obj != aModel) {
            if (CGRectContainsPoint(obj.frame, aPoint)) {

                destinationModel = obj;
            }
        }
    }

    if (!destinationModel) {

    } else {
        [_currentArr removeObjectAtIndex:aModel.tag - 100];
        [_currentArr insertObject:aModel.title atIndex:destinationModel.tag - 100];

        //从后往前移动模块
        if (aModel.tag > destinationModel.tag) {

            for (NSInteger i = aModel.tag - 1; i > destinationModel.tag - 1; i--) {
                Model *obj = (Model *) [self viewWithTag:i];
                obj.tag += 1;

                [obj resetModelFrame];
            }
            aModel.tag = destinationModel.tag - 1;

        } else if (aModel.tag < destinationModel.tag) //从前往后移动模块
        {

            for (NSInteger i = aModel.tag + 1; i < destinationModel.tag + 1; i++) {
                Model *obj = (Model *) [self viewWithTag:i];
                obj.tag -= 1;

                [obj resetModelFrame];
            }
            aModel.tag = destinationModel.tag + 1;
        }
    }
}
/**
 *  回复原状
 */
- (void)revertToBack {
    if (currentModel) {
        currentModel.isCheck = NO;
        currentModel = nil;
    }
}

- (void)modelClick:(Model *)aModel {
    if (currentModel) {
        [self revertToBack];

        return;
    }

    if (aModel.tag == [_currentArr count] + 100) {

        if (self.moreBlock) {
            self.moreBlock();
        }
    } else {
        if (self.clickBlock) {
            self.clickBlock(aModel);
        }
    }
}

#pragma mark - ModelDelegate

- (void)handleWithModel:(Model *)aModel {
    if ([_currentArr count] > 1) {

        [aModel removeFromSuperview];
        [_currentArr removeObjectAtIndex:aModel.tag - 100];

        [self revertToBack];

        //        只对需要改变位置的model进行操作
        for (NSInteger i = aModel.tag; i < 102 + [_currentArr count]; i++) {
            Model *obj = (Model *) [self viewWithTag:i];
            obj.tag--;

            [obj resetModelFrame];
        }
    }
}

- (void)plusWith:(Model *)aModel {
    AppDelegate *app = KAPPDELEGATE;

    if ([app.currentArray count] < 11) {
        [self handleWithModel:aModel];
        [app.addArray addObject:aModel.title];
        [app.currentArray addObject:aModel.title];
        //        [app.lastArray removeObject:aModel.title];
    }

    else {

        NSLog(@"==前面已满==");
    }
}
- (void)deleteWith:(Model *)aModel {

    if ([_currentArr count] > 1) {
        [self handleWithModel:aModel];

        AppDelegate *app = KAPPDELEGATE;

        [app.lastArray addObject:aModel.title];

    } else {
        //        [self makeToast:@""];
        NSLog(@"留一个呗！");
    }
}
- (void)longPressBeginWith:(Model *)aModel
               withGesture:(UILongPressGestureRecognizer *)aGesture {

    if (aModel.tag == [_currentArr count] + 100) {
        return;
    }

    if (currentModel == aModel) {

        currentModel.isCheck = YES;
    } else {

        currentModel.isCheck = NO;
        currentModel = aModel;
        currentModel.isCheck = YES;
    }

    touchPoint = [aGesture locationInView:aGesture.view];
}
- (void)longPressChangeWith:(Model *)aModel
                withGesture:(UILongPressGestureRecognizer *)aGesture {

    CGPoint newPoint = [aGesture locationInView:aGesture.view];

    CGFloat newX = newPoint.x - touchPoint.x;
    CGFloat newY = newPoint.y - touchPoint.y;

    CGPoint endPoint = CGPointMake(aModel.center.x + newX, aModel.center.y + newY);

    //当前模块根据移动不断更改自身位置
    aModel.center = endPoint;

    [self locationChangeWithModel:aModel withEndPoint:endPoint];
}
- (void)longPressEndWith:(Model *)aModel
             withGesture:(UILongPressGestureRecognizer *)aGesture {
    [UIView animateWithDuration:0.2
                     animations:^{
                         currentModel.transform = CGAffineTransformIdentity;
                     }];

    [aModel resetModelFrame];
}

@end
