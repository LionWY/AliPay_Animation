//
//  Model.h
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

#define WIDTH       SCREEN_WIDTH / 4

#define HEIGHT      80









@class Model;




@interface Model : UIButton
{
    BOOL _isCheck;
    UIImageView *_imgView;
}



@property (nonatomic, weak) id delegate;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIButton *handleBtn;



- (id)initWithFrame:(CGRect)frame 
            withTag:(NSInteger)aTag 
         withIsPlus:(BOOL)isPlus
         withIsMore:(BOOL)isMore;

- (void)setIsCheck:(BOOL)isCheck;

- (BOOL)isCheck;

- (void)resetModelFrame;


@end



@protocol ModelDelegate <NSObject>

- (void)deleteWith:(Model *)aModel;
- (void)plusWith:(Model *)aModel;
- (void)longPressBeginWith:(Model *)aModel withGesture:(UILongPressGestureRecognizer *)aGesture;
- (void)longPressChangeWith:(Model *)aModel withGesture:(UILongPressGestureRecognizer *)aGesture;
- (void)longPressEndWith:(Model *)aModel withGesture:(UILongPressGestureRecognizer *)aGesture;


@end


