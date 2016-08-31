//
//  AliView.h
//  TestView
//
//  Created by FOODING on 16/5/4.
//  Copyright © 2016年 FOODING. All rights reserved.
//

#import "Model.h"
#import <UIKit/UIKit.h>

typedef void (^MoreBlock)();

typedef void (^ModelClick)(Model *aModel);

@interface AliView : UIView <ModelDelegate>

@property (nonatomic, strong) NSMutableArray *currentArr;
@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, copy) MoreBlock moreBlock;

@property (nonatomic, copy) ModelClick clickBlock;

- (id)initWithFrame:(CGRect)frame withHasMore:(BOOL)hasMore;
- (void)loadBtnArrWithArr:(NSMutableArray *)aArr;
- (void)reloadBtnArrWithArr:(NSArray *)aArr;

@end
