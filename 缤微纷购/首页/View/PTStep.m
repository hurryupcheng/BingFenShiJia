//
//  PTStep.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/1.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "PTStep.h"

@implementation PTStep

- (instancetype)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        UILabel *wan = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, 20)];
        wan.text = @"拼团玩法";
        wan.font = [UIFont systemFontOfSize:13];
        
        self.ptStep = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.bounds)-kScreenWidth/4, 0, kScreenWidth/4, 20)];
        [self.ptStep setTitle:@"查看详情" forState:UIControlStateNormal];
        self.ptStep.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.ptStep setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        NSArray *stepArr = @[@"选择心仪商品",@"支付开团或参团",@"等待好友参团支付",@"达到人数团购成功"];
        NSArray *imageArr = @[@"①",@"②",@"③",@"④"];
        for (int j = 0; j < 4; j++) {
            
            UILabel *step = [[UILabel alloc]initWithFrame:CGRectMake(10+(((kScreenWidth-50)/4)*j)+(j*10), CGRectGetMaxY(wan.frame), (kScreenWidth-50)/4, 35)];
            step.text = stepArr[j];
            step.numberOfLines = 2;
            step.font = [UIFont systemFontOfSize:13];
            
            [self addSubview:step];
        }
        [self addSubview:wan];
        [self addSubview:self.ptStep];
      
    }
    return self;
}

@end
