//
//  BFHotView.h
//  缤微纷购
//
//  Created by 郑洋 on 16/5/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFSosoModel.h"
#import <UIKit/UIKit.h>

@protocol BFHotViewButDelegate <NSObject>

- (void)selectedBut:(NSString *)text;
- (void)selectedButton:(NSInteger )index;

@end

@interface BFHotView : UIView
@property (nonatomic,assign)NSInteger cellHeight;
@property (nonatomic,assign)id<BFHotViewButDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame model:(BFSosoSubModel *)model other:(BFSosoModel *)otherModel;


@end
