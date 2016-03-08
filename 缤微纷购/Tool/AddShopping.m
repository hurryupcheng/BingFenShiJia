//
//  AddShopping.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/24.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "Header.h"
#import "AddShopping.h"

@implementation AddShopping

- (instancetype)initWithFrame:(CGRect)frame num:(NSInteger)numCount sum:(NSInteger)sumCount{

    if ([super initWithFrame:frame]) {
        self.numCount = numCount;
        self.sumCount = sumCount;
        [self initWithSubView];
    }
    return self;
}

- (void)initWithSubView{

    self.minBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.minBut.frame = CGRectMake(0, 0, 35, 35);
    
    [self.minBut setBackgroundImage:[[UIImage imageNamed:@"jian.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    if (self.numCount <= 1) {
        self.minBut.enabled = NO;
    }else{
        self.minBut.enabled = YES;
    }
    
    self.textF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.minBut.frame), 0, 35, 35)];
    
    self.textF.textAlignment = NSTextAlignmentCenter;
    self.textF.textColor = [UIColor blackColor];
    self.textF.text = [NSString stringWithFormat:@"%d",self.sumCount];
    
    self.maxBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.maxBut.frame = CGRectMake(CGRectGetMaxX(self.textF.frame), 0, 35, 35);
    [self.maxBut setBackgroundImage:[UIImage imageNamed:@"jia1.png"] forState:UIControlStateNormal];
    
    if (self.numCount >= self.sumCount) {
        self.maxBut.enabled = NO;
    }else{
        self.maxBut.enabled = YES;
    }
    
    [self addSubview:self.minBut];
    [self addSubview:self.maxBut];
    [self addSubview:self.textF];
}

@end
