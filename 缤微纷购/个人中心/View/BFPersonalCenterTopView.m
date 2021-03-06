//
//  BFPersonalCenterTopView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#define ThreeButtonWidth (ScreenWidth/3)
#define ThreeButtonHeight ButtonViewHeight
#define ButtonViewHeight   (BF_ScaleHeight(20))
#define LabelHeight  (self.nickNameView.height - CGRectGetMaxY(self.threeButtonView.frame))
#import "BFPersonalCenterTopView.h"
#import "BFUserDefaluts.h"
#import "BFPersonViewButton.h"
@interface BFPersonalCenterTopView()
/** 用户头像*/
@property (nonatomic, strong) UIButton *headButton;
///** 积分*/
//@property (nonatomic, strong) UILabel *integralLabel;
///** 本月广告费*/
//@property (nonatomic, strong) UILabel *advertisingExpenseLabel;
///** 我的客户*/
//@property (nonatomic, strong) UILabel *myClientLabel;

@property (nonatomic, strong) UIView *threeButtonView;
/**未登录状态*/
@property (nonatomic, strong) UIView *buttonView;
/**登录状态*/
@property (nonatomic, strong) UIView *nickNameView;
/**id*/
@property (nonatomic, strong) UILabel *IDLabel;
/**确认推荐人*/
@property (nonatomic, strong) UIButton *referenceButton;
/**推荐人*/
@property (nonatomic, strong) UILabel *referenceLabel;
/**积分按钮*/
@property (nonatomic, strong) BFPersonViewButton *integralButton;
/**本月广告费*/
@property (nonatomic, strong) BFPersonViewButton *advertisingExpenseButton;
/**我的客户*/
@property (nonatomic, strong) BFPersonViewButton *myClientButton;
@end



@implementation BFPersonalCenterTopView

- (void)changeStatus {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (userInfo == nil) {
        BFLog(@"没登录");
        self.buttonView.hidden = NO;
        self.nickNameView.hidden = YES;
        
        [self.headButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"head_image"]];
        
    }else {
        self.buttonView.hidden = YES;
        self.nickNameView.hidden = NO;
        self.integralButton.bottomLabel.text = userInfo.score;
        self.advertisingExpenseButton.bottomLabel.text = [NSString stringWithFormat:@"¥%@",userInfo.proxy_order_money];
        self.myClientButton.bottomLabel.text = userInfo.proxy_num;
        
        
        if (userInfo.app_icon.length != 0) {
            [self.headButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userInfo.app_icon]] placeholderImage:[UIImage imageNamed:@"head_image"]];
        }else {
            [self.headButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userInfo.user_icon]] placeholderImage:[UIImage imageNamed:@"head_image"]];
        }
        
        
        self.IDLabel.text = [NSString stringWithFormat:@"ID:%@",userInfo.ID];
        if (userInfo.parent_proxy != nil && ![userInfo.parent_proxy isEqualToString:@"0"]) {
            self.referenceButton.hidden = YES;
            self.referenceLabel.hidden = NO;
            self.referenceLabel.text = [NSString stringWithFormat:@"推荐人:%@",userInfo.p_username.length != 0 ? userInfo.p_username : [NSString stringWithFormat:@"bingo_%@", userInfo.parent_proxy]];
        }else {
            self.referenceButton.hidden = NO;
            self.referenceLabel.hidden = YES;
        }
        BFLog(@"登录了,,%@,%@,%@,%@,",userInfo.p_username,userInfo.ID,userInfo.proxy_num,userInfo.proxy_order_money);
    }
}


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
    
    
    self.headButton = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - BF_ScaleHeight(75))/2, BF_ScaleHeight(55), BF_ScaleHeight(75), BF_ScaleHeight(75))];
    self.headButton.backgroundColor = BFColor(0xffffff);
    self.headButton.layer.borderColor = BFColor(0xffffff).CGColor;
    self.headButton.layer.borderWidth = 1;
    self.headButton.layer.cornerRadius = BF_ScaleHeight(75)/2;
    self.headButton.layer.masksToBounds = YES;
    [self.headButton addTarget:self action:@selector(clickHead:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.headButton];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headButton.frame)+BF_ScaleWidth(10), CGRectGetMinY(self.headButton.frame), BF_ScaleWidth(10), self.headButton.height)];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    arrowImageView.image = [UIImage imageNamed:@"select_right"];
    [self addSubview:arrowImageView];
    
//    UIButton *settingButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(245), BF_ScaleHeight(30), BF_ScaleWidth(35), BF_ScaleWidth(35)) title:nil image:@"iconfont-setting" font:0 titleColor:nil];
//    [settingButton addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:settingButton];
    
    UIImageView *settingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(285), BF_ScaleHeight(30), BF_ScaleWidth(20), BF_ScaleWidth(20))];
    settingImageView.userInteractionEnabled = YES;
    settingImageView.image = [UIImage imageNamed:@"iconfont-setting"];
    [self addSubview:settingImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setting)];
    [settingImageView addGestureRecognizer:tap];
    
    
    
    //未登录前的页面
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(100), CGRectGetMaxY(self.headButton.frame)+BF_ScaleHeight(20), BF_ScaleWidth(120), BF_ScaleHeight(40))];
    self.buttonView.layer.borderWidth = 1;
    self.buttonView.layer.cornerRadius = ButtonViewHeight/2;
    self.buttonView.layer.borderColor = BFColor(0x5C5C5B).CGColor;
    //self.buttonView.backgroundColor = [UIColor redColor];
    [self addSubview:self.buttonView];
    
    
    UIButton *loginButton = [UIButton buttonWithFrame:CGRectMake(0, 0, self.buttonView.width/2, self.buttonView.height) title:@"登录" image:nil font:BF_ScaleFont(13) titleColor:BFColor(0x5C5C5B)];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:loginButton];
    
    UIButton *registerButton = [UIButton buttonWithFrame:CGRectMake(self.buttonView.width/2, 0, self.buttonView.width/2, self.buttonView.height) title:@"注册" image:nil font:BF_ScaleFont(13) titleColor:BFColor(0x5C5C5B)];
    [registerButton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:registerButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.buttonView.width/2-1, self.buttonView.height/4, 1, self.buttonView.height/2)];
    line.backgroundColor = BFColor(0x5C5C5B);
    [self.buttonView addSubview:line];
    
    
    //登录后的页面
    self.nickNameView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headButton.frame), ScreenWidth, BF_ScaleHeight(110))];
    //self.nickNameView.backgroundColor = [UIColor redColor];
    [self addSubview:self.nickNameView];
    
    self.IDLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(50), BF_ScaleHeight(15), BF_ScaleWidth(90), ButtonViewHeight)];
    //self.IDLabel.backgroundColor = [UIColor redColor];
    self.IDLabel.textAlignment = NSTextAlignmentRight;
    [self.nickNameView addSubview:self.IDLabel];
    
    self.referenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, BF_ScaleHeight(15), BF_ScaleWidth(150), ButtonViewHeight)];
    //self.referenceLabel.backgroundColor = [UIColor greenColor];
    [self.nickNameView addSubview:self.referenceLabel];
    
    self.referenceButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2, BF_ScaleHeight(10), BF_ScaleWidth(100), ButtonViewHeight+BF_ScaleHeight(10))];
    [self.referenceButton setTitle:@"添加推荐人" forState:UIControlStateNormal];
    self.referenceButton.backgroundColor = BFColor(0xD20000);
    [self.referenceButton addTarget:self action:@selector(identityRecommender) forControlEvents:UIControlEventTouchUpInside];
    [self.nickNameView addSubview:self.referenceButton];
    
    

//    self.threeButtonView = [[UIView alloc] initWithFrame:CGRectMake(0,BF_ScaleHeight(50), ScreenWidth, BF_ScaleHeight(60))];
//    //self.threeButtonView.backgroundColor = [UIColor blueColor];
//    [self.nickNameView addSubview:self.threeButtonView];
    
    
    self.integralButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeIntegral titleText:@"积分"];
    self.integralButton.frame = CGRectMake(0, BF_ScaleHeight(50), ScreenWidth/3, BF_ScaleHeight(60));
    
    
    self.advertisingExpenseButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeAdvertisingExpense titleText:@"当月广告费"];
    self.advertisingExpenseButton.frame = CGRectMake(ScreenWidth/3, BF_ScaleHeight(50), ScreenWidth/3, BF_ScaleHeight(60));
    
    self.myClientButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeMyClient titleText:@"我的客户"];
    self.myClientButton.frame = CGRectMake(ScreenWidth*2/3, BF_ScaleHeight(50), ScreenWidth/3, BF_ScaleHeight(60));
    
    
//    UIButton *integralButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeIntegral titleText:@"积分"];
//    [self.threeButtonView addSubview:integralButton];
//    UIButton *advertisingExpenseButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeAdvertisingExpense titleText:@"当月广告费"];
//    [self.threeButtonView addSubview:advertisingExpenseButton];
//    UIButton *myClientButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeMyClient titleText:@"我的客户"];
//    [self.threeButtonView addSubview:myClientButton];
    

    UIView *seperateLineOne = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/3-0.5, BF_ScaleHeight(60), 1, BF_ScaleHeight(40))];
    seperateLineOne.backgroundColor = BFColor(0xB4B4B1);
    [self.nickNameView addSubview:seperateLineOne];
    
    UIView *seperateLineTwo = [[UIView alloc] initWithFrame:CGRectMake((2*ScreenWidth/3)-0.5, BF_ScaleHeight(60), 1, BF_ScaleHeight(40))];
    seperateLineTwo.backgroundColor = BFColor(0xB4B4B1);
    [self.nickNameView addSubview:seperateLineTwo];
    
    
//    self.integralLabel = [UILabel labelWithFrame:CGRectMake(0, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight) font:BF_ScaleFont(14) textColor:BFColor(0xEE3E00) text:@"123"];
//    self.integralLabel.textAlignment = NSTextAlignmentCenter;
//    [self.nickNameView addSubview:self.integralLabel];
//    
//    self.advertisingExpenseLabel = [UILabel labelWithFrame:CGRectMake(ScreenWidth/3, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight) font:BF_ScaleFont(14) textColor:BFColor(0xEE3E00) text:@"123"];
//    self.advertisingExpenseLabel.textAlignment = NSTextAlignmentCenter;
//    [self.nickNameView addSubview:self.advertisingExpenseLabel];
//    
//    self.myClientLabel = [UILabel labelWithFrame:CGRectMake(ScreenWidth*2/3, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight) font:BF_ScaleFont(14) textColor:BFColor(0xEE3E00) text:@"132"];
//    self.myClientLabel.textAlignment = NSTextAlignmentCenter;
//    [self.nickNameView addSubview:self.myClientLabel];
    
    
    
    
}

//- (void)layoutIfNeeded {
//    [super layoutSubviews];
//    BFLog(@"调用");
//    BFLog(@"调用");
//}

//- (void)layoutIfNeeded {
//    [super layoutIfNeeded];
//    BFLog(@"调用");
//     BFLog(@"调用");
//}

//创建buttton
- (BFPersonViewButton *)setUpButtonWithType:(BFPersonalCenterTopButtonType)type titleText:(NSString *)titleText {
    BFPersonViewButton *button = [BFPersonViewButton buttonWithType:0];
    button.tag = type;
    button.topLabel.text = titleText;
    [button addTarget:self action:@selector(personalCenterTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.nickNameView addSubview:button];
    return button;
}



////创建button
//- (UIButton *)setUpButtonWithType:(BFPersonalCenterTopButtonType)type titleText:(NSString *)titleText {
//    UIButton *button = [UIButton buttonWithType:0];
//    button.tag = type;
//    //button.backgroundColor = [UIColor blueColor];
//    [button setTitleColor:BFColor(0x303134) forState:UIControlStateNormal];
//    [button setTitle:titleText forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
//    [button addTarget:self action:@selector(personalCenterTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}

/**设置按钮点击事件*/
- (void)setting {
    //音效
    if ([[BFUserDefaluts getSwitchInfo] intValue] == 1 ) {
        [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToSettingInterface)]) {
        [self.delegate goToSettingInterface];
    }
}
/**头像按钮点击事件*/
- (void)clickHead:(UIButton *)sender {
    //音效
    if ([[BFUserDefaluts getSwitchInfo] intValue] == 1 ) {
        [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToUserHeadInterface)]) {
        [self.delegate goToUserHeadInterface];
    }

//    [UIView animateWithDuration:0.2 animations:^{
//        sender.frame = CGRectMake((ScreenWidth - BF_ScaleHeight(75))/2-BF_ScaleHeight(10), ScreenHeight*0.1-BF_ScaleHeight(10), BF_ScaleHeight(95), BF_ScaleHeight(95));
//        sender.layer.cornerRadius = BF_ScaleHeight(95)/2;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.2 animations:^{
//            sender.frame = CGRectMake((ScreenWidth - BF_ScaleHeight(75))/2, ScreenHeight*0.1, BF_ScaleHeight(75), BF_ScaleHeight(75));
//            sender.layer.cornerRadius = BF_ScaleHeight(75)/2;
//        } completion:^(BOOL finished) {
//        }];
//    }];
    
}
/**登录按钮点击事件*/
- (void)login {
    //音效
    if ([[BFUserDefaluts getSwitchInfo] intValue] == 1 ) {
        [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToLoginInterface)]) {
        [self.delegate goToLoginInterface];
    }
}
/**注册按钮点击事件*/
- (void)regist {
    //音效
    if ([[BFUserDefaluts getSwitchInfo] intValue] == 1 ) {
        [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToRegisterInterface)]) {
        [self.delegate goToRegisterInterface];
    }
}

/**三个按钮点击事件*/
- (void)personalCenterTopButtonClick:(BFPersonViewButton *)sender {
    //音效
    if ([[BFUserDefaluts getSwitchInfo] intValue] == 1 ) {
        [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToPersonalCenterTopButtoInterfaceWithType:)]) {
        [self.delegate goToPersonalCenterTopButtoInterfaceWithType:sender.tag];
    }
}

- (void)identityRecommender {
    if ([[BFUserDefaluts getSwitchInfo] intValue] == 1 ) {
        [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoAddRecommender)]) {
        [self.delegate gotoAddRecommender];
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
