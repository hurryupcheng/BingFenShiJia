//
//  BFPersonalCenterTopView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#define ThreeButtonWidth (ScreenWidth/3)
#define ThreeButtonHeight ButtonViewHeight
#define ButtonViewHeight   (ScreenHeight*0.035)
#define LabelHeight  (self.height - CGRectGetMaxY(self.threeButtonView.frame))
#import "BFPersonalCenterTopView.h"

@interface BFPersonalCenterTopView()
/** 用户头像*/
@property (nonatomic, strong) UIButton *headButton;
/** 积分*/
@property (nonatomic, strong) UILabel *integralLabel;
/** 本月广告费*/
@property (nonatomic, strong) UILabel *advertisingExpenseLabel;
/** 我的客户*/
@property (nonatomic, strong) UILabel *myClientLabel;

@property (nonatomic, strong) UIView *threeButtonView;

@end



@implementation BFPersonalCenterTopView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.backgroundColor = BFColor(0xDFE0DA);
    bgView.alpha = 0.5;
    [self addSubview:bgView];
    
    self.headButton = [[UIButton alloc] initWithFrame:CGRectMake(BF_ScaleWidth(126), ScreenHeight*0.11, BF_ScaleWidth(68), 68)];
    [self.headButton addTarget:self action:@selector(clickHead) forControlEvents:UIControlEventTouchUpInside];
    [self.headButton setImage:[UIImage imageNamed:@"touxiang1"] forState:UIControlStateNormal];
    [self addSubview:self.headButton];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headButton.frame)+BF_ScaleWidth(10), CGRectGetMinY(self.headButton.frame), BF_ScaleWidth(10), self.headButton.height)];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    arrowImageView.image = [UIImage imageNamed:@"select_right"];
    [self addSubview:arrowImageView];
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(115), CGRectGetMaxY(self.headButton.frame)+BF_ScaleHeight(10), BF_ScaleWidth(90), ButtonViewHeight)];
    buttonView.layer.borderWidth = 1;
    buttonView.layer.cornerRadius = ButtonViewHeight/2;
    buttonView.layer.borderColor = BFColor(0x5C5C5B).CGColor;
    //buttonView.backgroundColor = [UIColor redColor];
    [self addSubview:buttonView];
    
    UIButton *loginButton = [UIButton buttonWithFrame:CGRectMake(0, 0, buttonView.width/2, buttonView.height) title:@"登录" image:nil font:BF_ScaleFont(13) titleColor:BFColor(0x5C5C5B)];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:loginButton];
    
    UIButton *registerButton = [UIButton buttonWithFrame:CGRectMake(buttonView.width/2, 0, buttonView.width/2, buttonView.height) title:@"注册" image:nil font:BF_ScaleFont(13) titleColor:BFColor(0x5C5C5B)];
    [registerButton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:registerButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(buttonView.width/2-1, buttonView.height/4, 1, buttonView.height/2)];
    line.backgroundColor = BFColor(0x5C5C5B);
    [buttonView addSubview:line];
    
    
    UIButton *settingButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(285), BF_ScaleHeight(30), BF_ScaleWidth(25), BF_ScaleWidth(25)) title:nil image:@"iconfont-setting" font:0 titleColor:nil];
    [settingButton addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingButton];
    
    self.threeButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headButton.frame)+0.09*ScreenHeight, ScreenWidth, ButtonViewHeight)];
    //self.threeButtonView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.threeButtonView];
    
    UIButton *integralButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeIntegral titleText:@"积分"];
    [self.threeButtonView addSubview:integralButton];
    UIButton *advertisingExpenseButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeAdvertisingExpense titleText:@"当月广告费"];
    [self.threeButtonView addSubview:advertisingExpenseButton];
    UIButton *myClientButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeMyClient titleText:@"我的客户"];
    [self.threeButtonView addSubview:myClientButton];
    

    UIView *seperateLineOne = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/3-0.5, CGRectGetMidY(self.threeButtonView.frame), 1, BF_ScaleHeight(30))];
    seperateLineOne.backgroundColor = BFColor(0xB4B4B1);
    [self addSubview:seperateLineOne];
    
    UIView *seperateLineTwo = [[UIView alloc] initWithFrame:CGRectMake((2*ScreenWidth/3)-0.5, CGRectGetMidY(self.threeButtonView.frame), 1, BF_ScaleHeight(30))];
    seperateLineTwo.backgroundColor = BFColor(0xB4B4B1);
    [self addSubview:seperateLineTwo];
    
    
    self.integralLabel = [UILabel labelWithFrame:CGRectMake(0, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight) font:BF_ScaleFont(14) textColor:BFColor(0xEE3E00) text:@"1019"];
    self.integralLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.integralLabel];
    
    self.advertisingExpenseLabel = [UILabel labelWithFrame:CGRectMake(ScreenWidth/3, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight) font:BF_ScaleFont(14) textColor:BFColor(0xEE3E00) text:@"¥ 0.19"];
    self.advertisingExpenseLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.advertisingExpenseLabel];
    
    self.myClientLabel = [UILabel labelWithFrame:CGRectMake(ScreenWidth*2/3, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight) font:BF_ScaleFont(14) textColor:BFColor(0xEE3E00) text:@"999"];
    self.myClientLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.myClientLabel];
    
    
    
    
}
//创建button
- (UIButton *)setUpButtonWithType:(BFPersonalCenterTopButtonType)type titleText:(NSString *)titleText {
    UIButton *button = [UIButton buttonWithType:0];
    button.tag = type;
    //button.backgroundColor = [UIColor blueColor];
    [button setTitleColor:BFColor(0x303134) forState:UIControlStateNormal];
    [button setTitle:titleText forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    [button addTarget:self action:@selector(personalCenterTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/**设置按钮点击事件*/
- (void)setting {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToSettingInterface)]) {
        [self.delegate goToSettingInterface];
    }
}
/**头像按钮点击事件*/
- (void)clickHead {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToUserHeadInterface)]) {
        [self.delegate goToUserHeadInterface];
    }
}
/**登录按钮点击事件*/
- (void)login {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToLoginInterface)]) {
        [self.delegate goToLoginInterface];
    }
}
/**注册按钮点击事件*/
- (void)regist {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToRegisterInterface)]) {
        [self.delegate goToRegisterInterface];
    }
}

/**三个按钮点击事件*/
- (void)personalCenterTopButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToPersonalCenterTopButtoInterfaceWithType:)]) {
        [self.delegate goToPersonalCenterTopButtoInterfaceWithType:sender.tag];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = self.threeButtonView.subviews.count;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *button = self.threeButtonView.subviews[i];
        button.x = ThreeButtonWidth *i ;
        button.y = 0;
        button.width = ThreeButtonWidth;
        button.height = ThreeButtonHeight;
    }
    //BFLog(@"456%@",self.threeButtonView.subviews);
}

@end
