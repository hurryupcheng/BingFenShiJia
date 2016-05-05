//
//  BFEmptyView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/5/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "Header.h"
#import "BFEmptyView.h"

@implementation BFEmptyView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/2-CGFloatX(kScreenWidth/2/2)), 10, CGFloatX(kScreenWidth/2), CGFloatY(kScreenWidth/2))];
        img.image = [UIImage imageNamed:@"464.png"];
        
        UILabel *kong = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame)+20, kScreenWidth, 30)];
        kong.text = @"您的购物车空空如也～";
        kong.textColor = [UIColor grayColor];
        kong.textAlignment = NSTextAlignmentCenter;
        kong.font = [UIFont systemFontOfSize:CGFloatX(20)];
        
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(kong.frame)+10, kScreenWidth, 30)];
        [_button setTitle:@"去首页逛逛" forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(20)];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(gotoHomeController) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/2-CGFloatX(kScreenWidth/4)), CGRectGetMaxY(_button.frame), CGFloatX(kScreenWidth/2), CGFloatY(kScreenWidth/2))];
        image.image = [UIImage imageNamed:@"buys.png"];
        //        image.backgroundColor = [UIColor redColor];
        
        [self addSubview:img];
        [self addSubview:kong];
        [self addSubview:_button];

    }
    return self;
}

@end
