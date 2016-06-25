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
        self.allSeled = [[UIButton alloc]initWithFrame:CGRectMake(0, 8, 40, 25)];
//        self.allSeled.layer.cornerRadius = CGFloatY(15);
//        self.allSeled.layer.masksToBounds = YES;
//        self.allSeled.backgroundColor = [UIColor greenColor];
        [self.allSeled setImage:[UIImage imageNamed:@"gx02.png"] forState:UIControlStateNormal];
        [self.allSeled setImage:[UIImage imageNamed:@"gx01.png"] forState:UIControlStateSelected];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.allSeled.frame), 0, BF_ScaleWidth(40), 40)];
        label.text = @"全选";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:CGFloatX(18)];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(BF_ScaleWidth(100), 0, BF_ScaleWidth(120), 40)];
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
