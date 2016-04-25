//
//  Model.h
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WIDTH       [[UIScreen mainScreen] bounds].size.width/4

#define HEIGHT      60


@class Model;

//typedef void(^DeleteBlock)(Model *aModel);
//typedef void(^LongPressBeginBlock)(Model *aModel, UILongPressGestureRecognizer *gesture);
//typedef void(^LongPressChangeBlock)(Model *aModel, UILongPressGestureRecognizer *gesture);
//typedef void(^LongPressEndBlock)(Model *aModel, UILongPressGestureRecognizer *gesture);
//typedef void(^LongPressCancelBlock)(Model *aModel, UILongPressGestureRecognizer *gesture);


@interface Model : UIButton
{
    BOOL _isCheck;
}



@property (nonatomic, weak) id delegate;

@property (nonatomic, strong) UIButton *deleteBtn;

//@property (nonatomic, copy) DeleteBlock minusBlock;
//@property (nonatomic, copy) LongPressBeginBlock beginBlock;
//@property (nonatomic, copy) LongPressChangeBlock changeBlock;
//@property (nonatomic, copy) LongPressCancelBlock cancelBlock;
//@property (nonatomic, copy) LongPressEndBlock endBlock;


- (id)initWithFrame:(CGRect)frame 
            withTag:(NSInteger)aTag 
      withIsChecker:(BOOL)isCheck
         withIsPlus:(BOOL)isPlus
   withHasMoreModel:(BOOL)isHas;

- (void)setIsCheck:(BOOL)isCheck;
- (BOOL)isCheck;

- (void)resetModelFrame;

@end



@protocol ModelDelegate <NSObject>

- (void)deleteWith:(Model *)aModel;
- (void)longPressBeginWith:(Model *)aModel withGesture:(UILongPressGestureRecognizer *)aGesture;
- (void)longPressChangeWith:(Model *)aModel withGesture:(UILongPressGestureRecognizer *)aGesture;
- (void)longPressEndWith:(Model *)aModel withGesture:(UILongPressGestureRecognizer *)aGesture;


@end


