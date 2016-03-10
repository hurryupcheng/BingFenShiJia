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
/**余额按钮*/
@property (nonatomic, strong) UIButton *balanceButton;
/**提现记录按钮*/
@property (nonatomic, strong) UIButton *recordButton;
/**冻结金额按钮*/
@property (nonatomic, strong) UIButton *frozenButton;
/** 余额label*/
@property (nonatomic, strong) UILabel *balanceLabel;
/** 提现记录label*/
@property (nonatomic, strong) UILabel *recordLabel;
/** 冻结金额label*/
@property (nonatomic, strong) UILabel *frozenLabel;

@property (nonatomic, strong) UIView *threeButtonView;
/**分割线1*/
@property (nonatomic, strong) UIView *seperateLineOne;
/**分割线2*/
@property (nonatomic, strong) UIView *seperateLineTwo;
@end

@implementation BFMyWalletTopView


- (void)layoutSubviews {
    [super layoutSubviews];
    self.headButton.frame = CGRectMake(BF_ScaleWidth(126), ScreenHeight*0.11, BF_ScaleWidth(68), BF_ScaleHeight(68));
    self.arrowImageView.frame = CGRectMake(CGRectGetMaxX(self.headButton.frame)+BF_ScaleWidth(10), CGRectGetMinY(self.headButton.frame), BF_ScaleWidth(10), self.headButton.height);
    self.nickName.frame = CGRectMake(0, CGRectGetMaxY(self.headButton.frame)+BF_ScaleHeight(10), ScreenWidth, ButtonViewHeight);
    self.threeButtonView.frame = CGRectMake(0, CGRectGetMaxY(self.headButton.frame)+0.09*ScreenHeight, ScreenWidth, ButtonViewHeight);
    NSUInteger count = self.threeButtonView.subviews.count;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *button = self.threeButtonView.subviews[i];
        button.x = ThreeButtonWidth *i ;
        button.y = 0;
        button.width = ThreeButtonWidth;
        button.height = ThreeButtonHeight;
    }
    self.balanceLabel.frame = CGRectMake(0, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight);
    self.recordLabel.frame = CGRectMake(ScreenWidth/3, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight);
    self.frozenLabel.frame = CGRectMake(ScreenWidth*2/3, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight);
    self.seperateLineOne.frame = CGRectMake(ScreenWidth/3-0.5, CGRectGetMidY(self.threeButtonView.frame), 1, BF_ScaleHeight(30));
    
    self.seperateLineTwo.frame = CGRectMake((2*ScreenWidth/3)-0.5, CGRectGetMidY(self.threeButtonView.frame), 1, BF_ScaleHeight(30));
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _balanceButton = [self setUpButtonWithType:BFMyWalletTopButtonTypeBalance titleText:@"余额"];

        _recordButton = [self setUpButtonWithType:BFMyWalletTopButtonTypeRecord titleText:@"提现记录"];
        
        _frozenButton = [self setUpButtonWithType:BFMyWalletTopButtonTypeFrozen titleText:@"冻结金额"];
        self.seperateLineOne = [[UIView alloc] init];
        self.seperateLineOne.backgroundColor = BFColor(0xB4B4B1);
        [self addSubview:self.seperateLineOne];
        
        self.seperateLineTwo = [[UIView alloc] init];
        self.seperateLineTwo.backgroundColor = BFColor(0xB4B4B1);
        [self addSubview:self.seperateLineTwo];

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
        _nickName.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(19)];
        [self addSubview:_nickName];
    }
    return _nickName;
}


- (UIView *)threeButtonView {
    if (!_threeButtonView) {
        _threeButtonView = [UIView new];
        [self addSubview:self.threeButtonView];
    }
    return _threeButtonView;
}


- (UILabel *)balanceLabel {
    if (!_balanceLabel) {
//        _balanceLabel = [UILabel new];
//        _balanceLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
//        _balanceLabel.textColor = BFColor(0xEE3E00);
//        _balanceLabel.textAlignment = NSTextAlignmentCenter;
//        _balanceLabel.text = @"¥155.94";
//        [self addSubview:_balanceLabel];
        _balanceLabel = [self setUpLabelWithText:@"¥155.94"];
    }
    return _balanceLabel;
}

- (UILabel *)recordLabel {
    if (!_recordLabel) {
//        _recordLabel = [UILabel new];
//        _recordLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
//        _recordLabel.textColor = BFColor(0xEE3E00);
//        _recordLabel.textAlignment = NSTextAlignmentCenter;
//        _recordLabel.text = @"¥155.94";
//        [self addSubview:_balanceLabel];
        _recordLabel = [self setUpLabelWithText:@"¥1292.00"];
    }
    return _recordLabel;
}

- (UILabel *)frozenLabel {
    if (!_frozenLabel) {
//        _frozenLabel = [UILabel new];
//        _frozenLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
//        _frozenLabel.textColor = BFColor(0xEE3E00);
//        _frozenLabel.textAlignment = NSTextAlignmentCenter;
//        _frozenLabel.text = @"¥155.94";
//        [self addSubview:_frozenLabel];
        _frozenLabel = [self setUpLabelWithText:@"¥1.00"];
    }
    return _frozenLabel;
}

//- (UIButton *)balanceButton {
//    if (!_balanceButton) {
//        _balanceButton = [self setUpButtonWithType:BFMyWalletTopButtonTypeBalance titleText:@"余额"];
//        [self.threeButtonView addSubview:_balanceButton];
//        
//    }
//    return _balanceButton;
//}
//
//- (UIButton *)recordButton {
//    if (!_recordButton) {
//        _recordButton = [self setUpButtonWithType:BFMyWalletTopButtonTypeRecord titleText:@"提现记录"];
//        [self.threeButtonView addSubview:_recordButton];
//        
//    }
//    return _balanceButton;
//}
//
//- (UIButton *)frozenButton {
//    if (!_frozenButton) {
//        _frozenButton = [self setUpButtonWithType:BFMyWalletTopButtonTypeFrozen titleText:@"冻结金额"];
//        [self.threeButtonView addSubview:_frozenButton];
//        
//    }
//    return _balanceButton;
//}


- (UILabel *)setUpLabelWithText:(NSString *)text {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    label.textColor = BFColor(0xEE3E00);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    [self addSubview:label];
    return label;
}

//创建button
- (UIButton *)setUpButtonWithType:(BFMyWalletTopButtonType)type titleText:(NSString *)titleText {
    UIButton *button = [UIButton buttonWithType:0];
    button.tag = type;
    //button.backgroundColor = [UIColor blueColor];
    [button setTitleColor:BFColor(0x303134) forState:UIControlStateNormal];
    [button setTitle:titleText forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(14)];
    [button addTarget:self action:@selector(personalCenterTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.threeButtonView addSubview:button];
    return button;
}

- (void)clickHead {
    BFLog(@"点击头像");
}


- (void)personalCenterTopButtonClick:(UIButton *)sender {
    BFLog(@"提现记录");
}



@end
