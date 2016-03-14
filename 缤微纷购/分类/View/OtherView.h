//
//  OtherView.h
//  缤微纷购
//
//  Created by 郑洋 on 16/2/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "AddShopping.h"
#import <UIKit/UIKit.h>

@interface OtherView : UIView

@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *moneyLabel;
@property (nonatomic,retain)UIButton *arrBut;
@property (nonatomic,retain)UIButton *arrayBut;
@property (nonatomic,retain)UIButton *addBut;
@property (nonatomic,retain)UIButton *minBut;
@property (nonatomic,retain)AddShopping *addShopp;
@property (nonatomic,retain)NSString *hot;
@property (nonatomic,retain)NSString *img;

@property (nonatomic,retain)UILabel *red;
@property (nonatomic,retain)UILabel *reds;

- (instancetype)initWithFrame:(CGRect)frame img:(NSString *)img title:(NSString *)title money:(NSMutableArray *)money arr:(NSMutableArray *)arr set:(NSArray *)set num:(NSString *)num;;

@end

