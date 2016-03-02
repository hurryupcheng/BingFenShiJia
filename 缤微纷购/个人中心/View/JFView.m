//
//  JFView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/16.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "Header.h"
#import "JFView.h"

@implementation JFView

- (instancetype)initWithFrame:(CGRect)frame jifen:(NSString *)jf yuer:(NSString *)ye kehu:(NSString *)kh{
    
    NSArray *arr = @[@"积分",@"本月广告费",@"我的客户"];
    NSArray *array = @[jf,ye,kh];
    
    if ([super initWithFrame:frame]) {
        
        for (int i = 0; i < 3; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*(kScreenWidth/3), 0, kScreenWidth/3, 20)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = arr[i];
            label.font = [UIFont systemFontOfSize:CGFloatY(14)];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*(kScreenWidth/3), CGRectGetMaxY(label.frame)+5, kScreenWidth/3, 20);
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake((i+1)*(kScreenWidth/3), 0, 1, 40)];
            view.backgroundColor = [UIColor blackColor];
            
            [self addSubview:view];
            [self addSubview:button];
            [self addSubview:label];
            
        }
    }
    return self;
}


@end
