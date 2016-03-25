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
    self.minBut.frame = CGRectMake(0, 0, CGFloatX(35), CGFloatX(35));
    
    [self.minBut setBackgroundImage:[[UIImage imageNamed:@"jian.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

//    [self.minBut addTarget:self action:@selector(minButSelented) forControlEvents:UIControlEventTouchUpInside];
    
    self.textF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.minBut.frame), 0, CGFloatX(35), CGFloatX(35))];
    
    self.textF.textAlignment = NSTextAlignmentCenter;
    self.textF.textColor = [UIColor blackColor];
    self.textF.text = @"1";
    
//    if ([self.textF.text integerValue] <= 1) {
//        self.minBut.enabled = NO;
//    }
//    if ([self.textF.text integerValue] > 99) {
//        self.maxBut.enabled = NO;
//    }
    
    
    self.maxBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.maxBut.frame = CGRectMake(CGRectGetMaxX(self.textF.frame), 0, CGFloatX(35), CGFloatX(35));
    [self.maxBut setBackgroundImage:[UIImage imageNamed:@"jia1.png"] forState:UIControlStateNormal];
//    [self.maxBut addTarget:self action:@selector(maxButSelented) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.minBut];
    [self addSubview:self.maxBut];
    [self addSubview:self.textF];
    
}

//
//- (void)minButSelented{
//    self.maxBut.enabled = YES;
//    self.number--;
//    self.textF.text = [NSString stringWithFormat:@"%d",self.number];
//    
//    if ([self.textF.text integerValue] <= 1) {
//        self.textF.text = @"1";
//        self.minBut.enabled = NO;
//        
//    }
//}
//
//- (void)maxButSelented{
//    self.minBut.enabled = YES;
//    self.number++;
//    self.textF.text = [NSString stringWithFormat:@"%d",self.number];
//    
//    if ([self.textF.text integerValue] > 99) {
//        self.textF.text = @"99";
//        self.maxBut.enabled = NO;
//        
//    }
//}

@end
