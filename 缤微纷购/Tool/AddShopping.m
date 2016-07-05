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

@interface AddShopping ()
@property (nonatomic,assign)NSInteger number;
@end

@implementation AddShopping

- (instancetype)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        self.number = 1;
        [self initWithSubView];
    }
    return self;
}

- (void)initWithSubView{

    self.minBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.minBut.frame = CGRectMake(0, 0, BF_ScaleWidth(30), BF_ScaleHeight(30));
    
    [self.minBut setBackgroundImage:[[UIImage imageNamed:@"jian.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    self.textF = [[UILabel alloc]initWithFrame:CGRectMake(BF_ScaleWidth(30), 0, BF_ScaleWidth(30), BF_ScaleHeight(30))];
    
    self.textF.textAlignment = NSTextAlignmentCenter;
    self.textF.textColor = [UIColor blackColor];
    self.textF.text = @"1";
//    self.textF.userInteractionEnabled = NO;
    
    self.maxBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.maxBut.frame = CGRectMake(BF_ScaleWidth(60), 0, BF_ScaleWidth(30), BF_ScaleHeight(30));
    [self.maxBut setBackgroundImage:[UIImage imageNamed:@"jia1.png"] forState:UIControlStateNormal];
    
    [self addSubview:self.minBut];
    [self addSubview:self.maxBut];
    [self addSubview:self.textF];
    
}


@end
