//
//  BFMyWalletTopView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define ThreeButtonWidth (ScreenWidth/3)
#define ThreeButtonHeight ButtonViewHeight
#define ButtonViewHeight   (ScreenHeight*0.035)
#define LabelHeight  (self.height - CGRectGetMaxY(self.threeButtonView.frame))
#import "BFMyWalletTopView.h"

@interface BFMyWalletTopView()
/** 用户头像*/
@property (nonatomic, strong) UIButton *headButton;
/**向右箭头*/
@property (nonatomic, strong) UIImageView *arrowImageView;
/**昵称*/
@property (nonatomic, strong) UILabel *nickName;
/** 积分*/
@property (nonatomic, strong) UILabel *integralLabel;
/** 本月广告费*/
@property (nonatomic, strong) UILabel *advertisingExpenseLabel;
/** 我的客户*/
@property (nonatomic, strong) UILabel *myClientLabel;

@property (nonatomic, strong) UIView *threeButtonView;

@end

@implementation BFMyWalletTopView


- (void)layoutSubviews {
    [super layoutSubviews];
    self.headButton.frame = CGRectMake(BF_ScaleWidth(126), ScreenHeight*0.11, BF_ScaleWidth(68), 68);
    self.arrowImageView.frame = CGRectMake(CGRectGetMaxX(self.headButton.frame)+BF_ScaleWidth(10), CGRectGetMinY(self.headButton.frame), BF_ScaleWidth(10), self.headButton.height);
    self.nickName.frame = CGRectMake(0, CGRectGetMaxY(self.headButton.frame)+BF_ScaleHeight(10), ScreenWidth, ButtonViewHeight);
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (UIButton *)headButton {
    if (!_headButton) {
        _headButton = [UIButton new];
        [_headButton addTarget:self action:@selector(clickHead) forControlEvents:UIControlEventTouchUpInside];
        [_headButton setImage:[UIImage imageNamed:@"touxiang1"] forState:UIControlStateNormal];
        [self addSubview:_headButton];
    }
    return _headButton;
}


- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImageView.image = [UIImage imageNamed:@"select_right"];
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
}


- (UILabel *)nickName {
    if (!_nickName) {
        _nickName = [UILabel new];
        _nickName.text = @"hahaha";
        _nickName.textAlignment = NSTextAlignmentCenter;
        //_nickName.font = [UIFont fontWithName:<#(nonnull NSString *)#> size:<#(CGFloat)#>]
        [self addSubview:_nickName];
    }
    return _nickName;
}

@end
