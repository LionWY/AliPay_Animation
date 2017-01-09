//
//  Model.m
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import "Config.h"
#import "Model.h"

@interface Model () {


    struct {
        unsigned int didDelete              : 1;
        
        unsigned int didPlus                : 1;
        
        unsigned int didPressBegin          : 1;
        
        unsigned int didPressChange         : 1;
        
        unsigned int didPressEnd            : 1;
        
        
    } _delegateFlags;
}

@end

@implementation Model

- (void)setDelegate:(id)delegate
{
    _delegate = delegate;
    
    _delegateFlags.didDelete = [_delegate respondsToSelector:@selector(deleteWith:)];
    _delegateFlags.didPlus = [_delegate respondsToSelector:@selector(plusWith:)];
    _delegateFlags.didPressBegin = [_delegate respondsToSelector:@selector(longPressBeginWith:withGesture:)];
    _delegateFlags.didPressChange = [_delegate respondsToSelector:@selector(longPressChangeWith:withGesture:)];
    _delegateFlags.didPressEnd = [_delegate respondsToSelector:@selector(longPressEndWith:withGesture:)];
}

- (id)initWithFrame:(CGRect)frame
            withTag:(NSInteger)aTag
         withIsPlus:(BOOL)isPlus
         withIsMore:(BOOL)isMore

{
    if (self = [super initWithFrame:frame]) {

        [self.layer setBorderWidth:0.1f];

        [self.layer setBorderColor:BACKGROUND_COLOR.CGColor];
        [self.layer setMasksToBounds:YES];

        [self setBackgroundImage:[UIImage imageNamed:@"app_item_bg"]
                        forState:UIControlStateNormal];

        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"app_item_pressed_bg"]
                        forState:UIControlStateSelected];

        self.tag = aTag;

        if (!isMore) {
            _handleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _handleBtn.frame = CGRectMake(frame.size.width - 16, 2, 16, 16);
            [_handleBtn setBackgroundImage:[UIImage imageNamed:@"app_item_plus"]
                                  forState:UIControlStateNormal];
            if (isPlus) {
                [_handleBtn setBackgroundImage:[UIImage imageNamed:@"app_item_add"]
                                      forState:UIControlStateNormal];
                [_handleBtn addTarget:self
                               action:@selector(plusBtnClick)
                     forControlEvents:UIControlEventTouchUpInside];
            } else {
                [_handleBtn addTarget:self
                               action:@selector(minusBtnClick)
                     forControlEvents:UIControlEventTouchUpInside];
            }

            [self addSubview:_handleBtn];

            _handleBtn.hidden = YES;

            UILongPressGestureRecognizer *longPress =
                [[UILongPressGestureRecognizer alloc]
                    initWithTarget:self
                            action:@selector(modelLongPress:)];
            [self addGestureRecognizer:longPress];
        }

        _imgView = [[UIImageView alloc] init];
        _imgView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2 - 10);
        _imgView.bounds = CGRectMake(0, 0, 35, 35);
        [self addSubview:_imgView];
    }
    return self;
}

- (void)plusBtnClick {
    if (_delegateFlags.didPlus) {
        [self.delegate plusWith:self];
    }
}

- (void)minusBtnClick {

    if (_delegateFlags.didDelete) {
        [self.delegate deleteWith:self];
    }
}

- (void)modelLongPress:(UILongPressGestureRecognizer *)aLongPress {

    switch (aLongPress.state) {
        case UIGestureRecognizerStateBegan: {
            if (_delegateFlags.didPressBegin) {
                [self.delegate longPressBeginWith:self withGesture:aLongPress];
            }

        } break;
        case UIGestureRecognizerStateChanged: {

            if (_delegateFlags.didPressChange) {
                [self.delegate longPressChangeWith:self withGesture:aLongPress];
            }
        } break;
        case UIGestureRecognizerStateEnded: {

            if (_delegateFlags.didPressEnd) {
                [self.delegate longPressEndWith:self withGesture:aLongPress];
            }
        }

        default:
            break;
    }
}

- (void)setIsCheck:(BOOL)isCheck {
    _isCheck = isCheck;

    self.selected = isCheck;

    self.handleBtn.hidden = !isCheck;

    if (isCheck) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.transform = CGAffineTransformMakeScale(1.2, 1.2);
                         }];

        [self.superview bringSubviewToFront:self];
    } else {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.transform = CGAffineTransformIdentity;
                         }];
    }
}
- (BOOL)isCheck {
    return _isCheck;
}

/**
 *  根据这个model.tag确定它的位置
 *
 *  @param aModel 要更改位置的model
 */
- (void)resetModelFrame {

    NSInteger index = self.tag - 100;

    NSInteger i = index / 4;
    NSInteger j = index % 4;

    [UIView animateWithDuration:0.2
                     animations:^{
                         self.frame = CGRectMake(j * WIDTH, i * HEIGHT, WIDTH, HEIGHT);
                     }];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];

    [self setTitleEdgeInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16.f]];

    //    [self resetImgView];

    _title = title;
}
/***
- (void)resetImgView
{
    NSString *str = [self titleForState:UIControlStateNormal];
    NSString *imgName = @"home_add_n";
    if ([str isEqualToString:@"活动"]) {
        imgName = @"home_activity_n";
    }
    else if ([str isEqualToString:@"客户"])
    {
        imgName = @"home_customer_n";
    }
    else if ([str isEqualToString:@"产品"])
    {
        imgName = @"home_product_n";
    }
    else if ([str isEqualToString:@"供应商"])
    {
        imgName = @"home_supplier_n";
    }
    else if ([str isEqualToString:@"商机"])
    {
        imgName = @"home_business_n";
    }
    else if ([str isEqualToString:@"销售报价"])
    {
        imgName = @"home_Sales quotation_n";
    }
    else if ([str isEqualToString:@"销售订单"])
    {
        imgName = @"home_Sales order_n";
    }
    else if ([str isEqualToString:@"任务"])
    {
        imgName = @"home_task_n";
    }
//    else if ([str isEqualToString:@"客户"])
//    {
//        imgName = @"home_customer_n";
//    }
//    else if ([str isEqualToString:@"客户"])
//    {
//        imgName = @"home_customer_n";
//    }
//    else if ([str isEqualToString:@"客户"])
//    {
//        imgName = @"home_customer_n";
//    }
//    else if ([str isEqualToString:@"客户"])
//    {
//        imgName = @"home_customer_n";
//    }
//    else if ([str isEqualToString:@"客户"])
//    {
//        imgName = @"home_customer_n";
//    }
//    else if ([str isEqualToString:@"客户"])
//    {
//        imgName = @"home_customer_n";
//    }
//    else if ([str isEqualToString:@"客户"])
//    {
//        imgName = @"home_customer_n";
//    }

    UIImage *img = [UIImage imageNamed:imgName];
    _imgView.bounds = CGRectMake(0, 0, img.size.width, img.size.height);
    _imgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 10);
    [_imgView setImage:[UIImage imageNamed:imgName]];

    if ([imgName isEqualToString:@"home_add_n"]) {
        _imgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
}

*/

@end
