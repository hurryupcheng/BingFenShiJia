//
//  BFAgreeButton.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAgreeButton.h"

@implementation BFAgreeButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.agreeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BF_ScaleWidth(15), self.height)];
        self.agreeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.agreeImageView.frame), 0, self.width-self.agreeImageView.width, self.height)];
        self.agreeTitleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        self.agreeTitleLabel.textColor = BFColor(0x373737);
        self.agreeTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.agreeImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.agreeTitleLabel];
        [self addSubview:self.agreeImageView];
    }
    return self;
}

@end
