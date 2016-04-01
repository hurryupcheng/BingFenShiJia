//
//  BFWebHeaderView.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "AddShopping.h"
#import "FXQModel.h"
#import <UIKit/UIKit.h>

@interface BFWebHeaderView : UIView

@property (nonatomic,assign)NSInteger headerHeight;
@property (nonatomic,retain)AddShopping *addShopp;

- (instancetype)initWithFrame:(CGRect)frame model:(FXQModel *)model;
@end
