//
//  BFOtherView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "BFOtherView.h"

@implementation BFOtherView

- (instancetype)initWithFrame:(CGRect)frame img:(NSMutableArray *)imgs count:(NSInteger)count{
    if ([super initWithFrame:frame]) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, kScreenWidth/3-20, 1)];
        lab.backgroundColor = [UIColor grayColor];
        
        UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 0, kScreenWidth/3, 30)];
        labe.text = @"你可能还要买";
        labe.textAlignment = NSTextAlignmentCenter;
        labe.textColor = [UIColor grayColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labe.frame)+5, 15, kScreenWidth/3-20, 1)];
        label.backgroundColor = [UIColor grayColor];
        
        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(labe.frame)+10, kScreenWidth-60, kScreenWidth/4)];
        
        scroll.contentSize = CGSizeMake(scroll.width*(count/3), 0);
        scroll.shouldGroupAccessibilityChildren = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.pagingEnabled = YES;
        
        for (int i = 0; i < count; i++) {
            self.imgButton = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/4*i)+(i*10), 0, kScreenWidth/4, kScreenWidth/4)];
            _imgButton.layer.borderColor = [UIColor grayColor].CGColor;
            _imgButton.layer.borderWidth = 1;
            _imgButton.tag = i;
            _imgButton.userInteractionEnabled = YES;
            
            [_imgButton sd_setImageWithURL:[NSURL URLWithString:imgs[i]] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImg:)];
            [self.imgButton addGestureRecognizer:tap];
   
            [scroll addSubview:_imgButton];
        }
        
        [self addSubview:scroll];
        [self addSubview:lab];
        [self addSubview:labe];
        [self addSubview:label];

    }
    return self;
}

- (void)tapImg:(UITapGestureRecognizer *)tap{
    if (self.otherDelegate != nil && [self.otherDelegate respondsToSelector:@selector(BFOtherViewDelegate:index:)]) {
        [self.otherDelegate BFOtherViewDelegate:self index:_imgButton.tag];
        NSLog(@"======%d",_imgButton.tag);
    }
}

@end
