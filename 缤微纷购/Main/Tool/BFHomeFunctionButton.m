//
//  BFHomeFunctionButton.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFHomeFunctionButton.h"

@implementation BFHomeFunctionButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.functionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,BF_ScaleHeight(5), BF_ScaleWidth(75), BF_ScaleHeight(50))];
        self.functionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BF_ScaleHeight(65), BF_ScaleWidth(75), BF_ScaleHeight(10))];
//        self.functionTitleLabel.backgroundColor = [UIColor redColor];
//        self.functionImageView.backgroundColor = [UIColor blueColor];
        self.functionTitleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        self.functionTitleLabel.textColor = BFColor(0x2A2B2C);
        self.functionTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.functionImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.functionTitleLabel];
        [self addSubview:self.functionImageView];
    }
    return self;
}

@end
