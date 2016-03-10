//
//  BFClassWebView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "LBView.h"
#import "Header.h"
#import "BFClassWebView.h"

@interface BFClassWebView ()

@property (nonatomic,retain)LBView *lbView;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *money;

@end

@implementation BFClassWebView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.lbView = [[LBView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lbView.frame), kScreenWidth/2, 30)];
        self.title.backgroundColor = [UIColor greenColor];
    
        self.money = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.title.frame), kScreenWidth/2, 30)];
        
        [self addSubview:self.title];
        
    }
    return self;
}

@end
