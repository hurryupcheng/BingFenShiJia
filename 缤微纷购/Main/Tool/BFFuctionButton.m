//
//  BFFuctionButton.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFFuctionButton.h"

@implementation BFFuctionButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.functionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, BF_ScaleHeight(25), self.width, self.height-BF_ScaleHeight(80))];
        self.functionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.functionImageView.frame), self.width, BF_ScaleHeight(40))];
        //self.functionTitleLabel.backgroundColor = [UIColor redColor];
        //self.functionImageView.backgroundColor = [UIColor blueColor];
        self.functionTitleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        self.functionTitleLabel.textColor = BFColor(0x454647);
        self.functionTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.functionImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.functionTitleLabel];
        [self addSubview:self.functionImageView];
    }
    return self;
}

@end
