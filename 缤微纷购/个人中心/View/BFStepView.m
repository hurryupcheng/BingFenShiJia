//
//  BFStepView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFStepView.h"

@implementation BFStepView




- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.numberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleHeight(22), BF_ScaleHeight(22))];
        [self addSubview:self.numberImageView];
        
        self.upLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(35), 0, BF_ScaleWidth(40), BF_ScaleHeight(11))];
        self.upLabel.textColor = BFColor(0x747474);
        self.upLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(9)];
        [self addSubview:self.upLabel];
        
        self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(35), BF_ScaleHeight(11), BF_ScaleWidth(40), BF_ScaleHeight(11))];
        self.bottomLabel.textColor = BFColor(0x747474);
        self.bottomLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(9)];
        [self addSubview:self.bottomLabel];
    }
    return self;
}

@end
