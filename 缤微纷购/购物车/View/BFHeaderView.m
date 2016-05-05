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
        CGFloat x = frame.size.height-25;
        self.allSeled = [[UIButton alloc]initWithFrame:CGRectMake(15, 7, CGFloatY(25), CGFloatY(25))];
        self.allSeled.layer.cornerRadius = CGFloatY(25/2);
        self.allSeled.layer.masksToBounds = YES;
        [self.allSeled setBackgroundImage:[UIImage imageNamed:@"gx02.png"] forState:UIControlStateNormal];
        [self.allSeled setBackgroundImage:[UIImage imageNamed:@"gx01.png"] forState:UIControlStateSelected];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.allSeled.frame)+5, 5, 40, x)];
        label.text = @"全选";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:CGFloatX(17)];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-((kScreenWidth/3)/2), 5, kScreenWidth/3, x)];
        title.text = @"商品信息";
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:CGFloatX(17)];
        title.textColor = BFColor(0x818284);
    
        [self addSubview:self.allSeled];
        [self addSubview:label];
        [self addSubview:title];
    }
    return self;
}

@end
