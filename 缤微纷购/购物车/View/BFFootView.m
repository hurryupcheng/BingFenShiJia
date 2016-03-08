//
//  BFFootView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "BFFootView.h"

@interface BFFootView ()

@property (nonatomic,retain)UILabel *numLabel;

@end

@implementation BFFootView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.money = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth/2, frame.size.height)];
        _money.text = @"合计:¥ 0.00";
        _money.textColor = [UIColor orangeColor];
        
        self.buyButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_money.frame)+10, 10, kScreenWidth/3, frame.size.height-20)];
        
        self.buyButton.layer.cornerRadius = 15;
        self.buyButton.layer.masksToBounds = YES;
        [self.buyButton setTitle:@"马上结算" forState:UIControlStateNormal];
        self.buyButton.backgroundColor = [UIColor orangeColor];
        
        [self addSubview:_money];
        [self addSubview:self.buyButton];
    }
    return self;
}
@end
