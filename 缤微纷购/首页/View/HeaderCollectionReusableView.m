//
//  HeaderCollectionReusableView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/16.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "HeaderCollectionReusableView.h"

@implementation HeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        self.sectionImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
        
        [self addSubview:self.sectionImage];
    }
    return self;
}

@end
