//
//  BFHeaderView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "Header.h"
#import "BFHeaderView.h"

@implementation BFHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
//        CGFloat x = frame.size.height-30;
        self.allSeled = [[UIButton alloc]initWithFrame:CGRectMake(CGFloatX(15), CGFloatX(5), CGFloatY(30), CGFloatY(30))];
        self.allSeled.layer.cornerRadius = CGFloatY(15);
        self.allSeled.layer.masksToBounds = YES;
//        self.allSeled.backgroundColor = [UIColor greenColor];
        [self.allSeled setBackgroundImage:[UIImage imageNamed:@"gx02.png"] forState:UIControlStateNormal];
        [self.allSeled setBackgroundImage:[UIImage imageNamed:@"gx01.png"] forState:UIControlStateSelected];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.allSeled.frame)+5, CGFloatX(5), 40, CGFloatX(30))];
        label.text = @"全选";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:CGFloatX(18)];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-((kScreenWidth/3)/2), CGFloatX(5), kScreenWidth/3, CGFloatX(30))];
        title.text = @"商品信息";
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:CGFloatX(18)];
        title.textColor = BFColor(0x818284);
    
        [self addSubview:self.allSeled];
        [self addSubview:label];
        [self addSubview:title];
    }
    return self;
}

@end
