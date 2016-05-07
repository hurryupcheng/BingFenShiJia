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
/**用户信息*/
/** 用户头像*/
@property (nonatomic, strong) UIImageView *headButton;
/**向右箭头*/
@property (nonatomic, strong) UIImageView *arrowImageView;

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
    self.headButton.frame = CGRectMake((ScreenWidth-BF_ScaleHeight(75))/2, ScreenHeight*0.10, BF_ScaleHeight(75), BF_ScaleHeight(75));
    self.arrowImageView.frame = CGRectMake(CGRectGetMaxX(self.headButton.frame)+BF_ScaleWidth(10), CGRectGetMinY(self.headButton.frame), BF_ScaleWidth(10), self.headButton.height);
    self.nickName.frame = CGRectMake(0, CGRectGetMaxY(self.headButton.frame)+BF_ScaleHeight(10), ScreenWidth, (ScreenHeight*0.04));
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

- (void)setModel:(BFMyWalletModel *)model {
    _model = model;
    self.balanceLabel.text = [NSString stringWithFormat:@"¥%@", model.user_account];
    self.recordLabel.text = [NSString stringWithFormat:@"¥%@", model.withdraw_account];
    self.frozenLabel.text = [NSString stringWithFormat:@"¥%@", model.freeze_amount];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        _headButton = [UIImageView new];
        _headButton.layer.cornerRadius = BF_ScaleHeight(75)/2;
        _headButton.layer.masksToBounds = YES;
        _headButton.backgroundColor = BFColor(0xffffff);
        _headButton.layer.borderColor = BFColor(0xffffff).CGColor;
        _headButton.layer.borderWidth = 1;
        if (userInfo.app_icon.length != 0) {
            [self.headButton setImageWithURL:[NSURL URLWithString:userInfo.app_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
        }else {
            [self.headButton setImageWithURL:[NSURL URLWithString:userInfo.user_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
        }
        [self addSubview:_headButton];
        
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImageView.image = [UIImage imageNamed:@"select_right"];
        [self addSubview:_arrowImageView];
        
        _nickName = [UILabel new];
        _nickName.text = userInfo.nickname;
        BFLog(@"----%@",userInfo.nickname);
        _nickName.textAlignment = NSTextAlignmentCenter;
        _nickName.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(19)];
        [self addSubview:_nickName];
        
        _threeButtonView = [UIView new];
        [self addSubview:self.threeButtonView];
        
        _balanceButton = [self setUpButtonWithType:BFMyWalletTopButtonTypeBalance titleText:@"余额"];

        _recordButton = [self setUpButtonWithType:BFMyWalletTopButtonTypeRecord titleText:@"提现记录"];
        
        _frozenButton = [self setUpButtonWithType:BFMyWalletTopButtonTypeFrozen titleText:@"冻结金额"];
        self.seperateLineOne = [[UIView alloc] init];
        self.seperateLineOne.backgroundColor = BFColor(0xB4B4B1);
        [self addSubview:self.seperateLineOne];
        
        self.seperateLineTwo = [[UIView alloc] init];
        self.seperateLineTwo.backgroundColor = BFColor(0xB4B4B1);
        [self addSubview:self.seperateLineTwo];

        self.balanceLabel = [self setUpLabelWithText:@""];
        
        self.recordLabel = [self setUpLabelWithText:@""];
        
        self.frozenLabel = [self setUpLabelWithText:@""];
    }
    return self;
}






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




- (void)personalCenterTopButtonClick:(UIButton *)sender {
    BFLog(@"提现记录");
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToCheckWithdrawalRecordWithType:)]) {
        [self.delegate goToCheckWithdrawalRecordWithType:sender.tag];
    }
}



@end
