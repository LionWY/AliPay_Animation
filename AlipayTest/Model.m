//
//  Model.m
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import "Model.h"

@implementation Model


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (id)initWithFrame:(CGRect)frame 
            withTag:(NSInteger)aTag 
         withIsPlus:(BOOL)isPlus
    withIsMoreModel:(BOOL)isMore

{
    if (self = [super initWithFrame:frame]) {
        
        
        [self.layer setBorderWidth:0.5f];
        [self.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.layer setMasksToBounds:YES];
        //    [self.layer set];
        
        
        [self setBackgroundImage:[UIImage imageNamed:@"app_item_bg"] forState:UIControlStateNormal];
        
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"app_item_pressed_bg"] forState:UIControlStateSelected];
        
        
        
        self.tag = aTag;
        
        
        
        if (!isMore) {
            _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _deleteBtn.frame = CGRectMake(frame.size.width - 16, 2, 16, 16);
            [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"app_item_plus"] forState:UIControlStateNormal];
            if (isPlus) {
                [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"app_item_add"] forState:UIControlStateNormal];
            }
            [_deleteBtn addTarget:self action:@selector(minusBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_deleteBtn];
            
            _deleteBtn.hidden = YES;
        
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(modelLongPress:)];
            [self addGestureRecognizer:longPress];

        
        }
        
        
        
    
        
               
    }
    return self;
}

- (void)minusBtnClick
{
    
    if ([self.delegate respondsToSelector:@selector(deleteWith:)]) {
        [self.delegate deleteWith:self];
    }
//    if (self.minusBlock) {
//        self.minusBlock(self);
//    }
}

- (void)modelLongPress:(UILongPressGestureRecognizer *)aLongPress
{
    
    switch (aLongPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            if ([self.delegate respondsToSelector:@selector(longPressBeginWith:withGesture:)]) {
                [self.delegate longPressBeginWith:self withGesture:aLongPress];
            }
            
//            if (self.beginBlock) {
//                self.beginBlock(self, aLongPress);
//            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
//            if (self.changeBlock) {
//                self.changeBlock(self, aLongPress);
//            }
            if ([self.delegate respondsToSelector:@selector(longPressChangeWith:withGesture:)]) {
                [self.delegate longPressChangeWith:self withGesture:aLongPress];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
//            if (self.endBlock) {
//                self.endBlock(self, aLongPress);
//            }
            if ([self.delegate respondsToSelector:@selector(longPressEndWith:withGesture:)]) {
                [self.delegate longPressEndWith:self withGesture:aLongPress];
            }
        }
        
            
        default:
            break;
    }
    
}

- (void)setIsCheck:(BOOL)isCheck
{
    _isCheck = isCheck;
    
    self.selected = isCheck;
    
    self.deleteBtn.hidden = !isCheck;
    
    if (isCheck) {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }];
        
        [self.superview bringSubviewToFront:self];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }
    
    
    
}
- (BOOL)isCheck
{
    return _isCheck;
}

/**
 *  根据这个model.tag确定它的位置
 *
 *  @param aModel 要更改位置的model
 */
- (void)resetModelFrame
{
    
    
    
    NSLog(@"==========%@", self);
    NSInteger index = self.tag - 100;
    
    NSInteger i = index/4;
    NSInteger j = index%4;
    
    NSLog(@"当前位置%ld行, %ld列--%@", i, j, self.titleLabel.text);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(j * WIDTH, (i + 3) * HEIGHT, WIDTH, HEIGHT);
    }];
    
    
}






@end
