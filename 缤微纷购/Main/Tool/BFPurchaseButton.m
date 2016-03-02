//
//  BFPurchaseButton.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/2.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPurchaseButton.h"

@implementation BFPurchaseButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height*0.6)];
        self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topLabel.frame), self.width, self.height*0.4)];
        self.topLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(16)];
        self.bottomLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
        self.topLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        self.topLabel.textColor = BFColor(0xffffff);
        self.bottomLabel.textColor = BFColor(0xffffff);
        self.bottomLabel.backgroundColor = BFColor(0x000000);
        [self addSubview:self.topLabel];
        [self addSubview:self.bottomLabel];
    }
    return self;
}

@end
