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

- (instancetype)initWithFrame:(CGRect)frame num:(float)num{
    if ([super initWithFrame:frame]) {
        UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth/2, frame.size.height)];
        money.text = [NSString stringWithFormat:@"合计:¥ %.2f",num];
        money.textColor = [UIColor orangeColor];
        
        self.buyButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(money.frame)+10, 10, kScreenWidth/3, frame.size.height-20)];
        
        self.buyButton.layer.cornerRadius = 15;
        self.buyButton.layer.masksToBounds = YES;
        [self.buyButton setTitle:@"马上结算" forState:UIControlStateNormal];
        self.buyButton.backgroundColor = [UIColor orangeColor];
        
        [self addSubview:money];
        [self addSubview:self.buyButton];
    }
    return self;
}
@end
