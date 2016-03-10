//
//  BFClassminView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "ViewController.h"
#import "BFClassminView.h"

@implementation BFClassminView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    if ([super initWithFrame:frame]) {
 
            UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, 20)];
            name.text = title;
            name.font = [UIFont systemFontOfSize:CGFloatY(15)];
            
            UIView *black = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(name.frame)+5, kScreenWidth-10, 1)];
            black.backgroundColor = [UIColor blackColor];
            
            [self addSubview:name];
            [self addSubview:black];
    }
    return self;
}

@end
