//
//  BFGoGroupShoppingView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGoGroupShoppingView.h"



@implementation BFGoGroupShoppingView

+ (instancetype)createView {
    BFGoGroupShoppingView *createView = [[BFGoGroupShoppingView alloc] init];
    return createView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //self.frame = CGRectMake(0, 0, BF_ScaleWidth(130), BF_ScaleHeight(23));
        //self.layer.cornerRadius = BF_ScaleHeight(11.5);
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"f_01"]];
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.text = @"3人团 59.90";
    self.infoLabel.textColor = BFColor(0xffffff);
    self.infoLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(10)];
    self.infoLabel.backgroundColor = BFColor(0x4F4F4F);
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    
    self.goGroupLabel = [[UILabel alloc] init];
    self.goGroupLabel.text = @"   去开团 >";
    self.goGroupLabel.textColor = BFColor(0xffffff);
    self.goGroupLabel.backgroundColor = BFColor(0xFB0006);
    self.goGroupLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(10)];
    self.goGroupLabel.layer.cornerRadius = BF_ScaleHeight(12.5);
    self.goGroupLabel.layer.masksToBounds = YES;
    self.goGroupLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.goGroupLabel];
    [self addSubview:self.infoLabel];
    [self addSubview:self.iconImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.frame = CGRectMake(0, 0, BF_ScaleWidth(30), BF_ScaleHeight(30));
    
    self.infoLabel.frame = CGRectMake(CGRectGetMidX(self.iconImageView.frame), BF_ScaleHeight(2.5), BF_ScaleWidth(97.5), BF_ScaleHeight(25));
    
    self.goGroupLabel.frame = CGRectMake(self.width-BF_ScaleWidth(60), self.infoLabel.y, BF_ScaleWidth(60), self.infoLabel.height);
}


@end
