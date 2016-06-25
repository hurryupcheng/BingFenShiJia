//
//  BFPersonViewButton.m
//  缤微纷购
//
//  Created by 程召华 on 16/6/25.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPersonViewButton.h"

@implementation BFPersonViewButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, BF_ScaleHeight(20))];
        self.topLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        self.topLabel.textColor = BFColor(0x303134);
        //self.topLabel.backgroundColor = [UIColor greenColor];
        self.topLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BF_ScaleHeight(20), ScreenWidth/3, BF_ScaleHeight(40))];
        self.bottomLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
        self.bottomLabel.textColor = BFColor(0xEE3E00);
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        //self.bottomLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.topLabel];
        [self addSubview:self.bottomLabel];
    }
    return self;
}

@end
