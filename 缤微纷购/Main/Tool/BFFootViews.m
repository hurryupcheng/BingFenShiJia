//
//  BFFootViews.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "Header.h"
#import "BFFootViews.h"

@interface BFFootViews ()

@property (nonatomic,retain)UILabel *numLabel;

@end

@implementation BFFootViews

- (instancetype)initWithFrame:(CGRect)frame money:(NSString *)money name:(NSString *)name{
    if ([super initWithFrame:frame]) {
        self.money = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth/2, frame.size.height)];
        _money.text = money;
        _money.textColor = [UIColor orangeColor];
        _money.font = [UIFont systemFontOfSize:CGFloatX(18)];
        
        self.buyButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_money.frame)+10, 10, kScreenWidth/3, frame.size.height-20)];
        
        self.buyButton.layer.cornerRadius = 15;
        self.buyButton.layer.masksToBounds = YES;
        [self.buyButton setTitle:name forState:UIControlStateNormal];
        self.buyButton.backgroundColor = [UIColor orangeColor];
        self.buyButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(18)];
        
        [self addSubview:_money];
        [self addSubview:self.buyButton];
    }
    return self;
}


@end
