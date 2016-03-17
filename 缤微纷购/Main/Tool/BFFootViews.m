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

@implementation BFFootViews

- (instancetype)initWithFrame:(CGRect)frame money:(NSString *)money home:(NSString *)home name:(NSString *)name{
    if ([super initWithFrame:frame]) {
        self.money = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth/2, frame.size.height)];
        _money.text = money;
        _money.textColor = [UIColor orangeColor];
        _money.font = [UIFont systemFontOfSize:CGFloatX(18)];
        
        self.homeButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, kScreenWidth/3, frame.size.height-20)];
        
        self.homeButton.layer.cornerRadius = 15;
        self.homeButton.layer.masksToBounds = YES;
        self.homeButton.layer.borderColor = [UIColor orangeColor].CGColor;
        self.homeButton.layer.borderWidth = 1;
        [self.homeButton setTitle:home forState:UIControlStateNormal];
        [self.homeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];;
        self.homeButton.backgroundColor = [UIColor whiteColor];
        self.homeButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(18)];
        
        self.buyButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-(kScreenWidth/3)-20, 10, kScreenWidth/3, frame.size.height-20)];
        
        self.buyButton.layer.cornerRadius = 15;
        self.buyButton.layer.masksToBounds = YES;
        [self.buyButton setTitle:name forState:UIControlStateNormal];
        self.buyButton.backgroundColor = [UIColor orangeColor];
        self.buyButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(18)];
        
        if (money == nil) {
            [self addSubview:self.homeButton];
        }else{
        [self addSubview:_money];
        }
        [self addSubview:self.buyButton];
    }
    return self;
}


@end
