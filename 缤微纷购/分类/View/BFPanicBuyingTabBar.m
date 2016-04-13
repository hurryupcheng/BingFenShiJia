//
//  BFPanicBuyingTabBar.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPanicBuyingTabBar.h"

@implementation BFPanicBuyingTabBar

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    
    UIButton *panic = [UIButton buttonWithType:0];
    panic.frame = CGRectMake(BF_ScaleWidth(100), BF_ScaleHeight(10), BF_ScaleWidth(120), BF_ScaleHeight(30));
    panic.backgroundColor = BFColor(0xF56B0A);
    [panic setTitle:@"立即抢购" forState:UIControlStateNormal];
    panic.layer.cornerRadius = BF_ScaleHeight(15);
    [panic setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    [panic addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:panic];
    
}

- (void)click:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToPanic)]) {
        [self.delegate clickToPanic];
    }
}

@end
