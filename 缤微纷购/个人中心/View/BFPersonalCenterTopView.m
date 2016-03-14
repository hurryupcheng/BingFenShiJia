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
#define LabelHeight  (self.nickNameView.height - CGRectGetMaxY(self.threeButtonView.frame))
#import "BFPersonalCenterTopView.h"
#import "BFUserDefaluts.h"
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


@end



@implementation BFPersonalCenterTopView

- (void)changeStatus {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    BFLog(@"%@",userInfo);
    if (userInfo == nil) {
        BFLog(@"没登录");
        self.buttonView.hidden = NO;
        self.nickNameView.hidden = YES;
        [self.headButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@"http://bingo.luexue.com/Style/teambuy/images/avatar_4_64.png"] placeholderImage:[UIImage imageNamed:@"touxiang1"]];
        
    }else {
        self.buttonView.hidden = YES;
        self.nickNameView.hidden = NO;
        self.integralLabel.text = userInfo.score;
        self.advertisingExpenseLabel.text = [NSString stringWithFormat:@"¥%@",userInfo.proxy_order_money];
        self.myClientLabel.text = userInfo.proxy_num;
        

        [self.headButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:userInfo.user_icon] placeholderImage:nil];

        
        self.IDLabel.text = [NSString stringWithFormat:@"ID:%@",userInfo.ID];
        if (userInfo.p_username != nil) {
            self.referenceButton.hidden = YES;
            self.referenceLabel.hidden = NO;
            self.referenceLabel.text = [NSString stringWithFormat:@"推荐人:%@",userInfo.p_username];
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
    
    
    self.headButton = [[UIButton alloc] initWithFrame:CGRectMake(BF_ScaleWidth(126), ScreenHeight*0.11, BF_ScaleWidth(68), BF_ScaleHeight(68))];
    [self.headButton addTarget:self action:@selector(clickHead) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.headButton];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headButton.frame)+BF_ScaleWidth(10), CGRectGetMinY(self.headButton.frame), BF_ScaleWidth(10), self.headButton.height)];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    arrowImageView.image = [UIImage imageNamed:@"select_right"];
    [self addSubview:arrowImageView];
    
    UIButton *settingButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(285), BF_ScaleHeight(30), BF_ScaleWidth(25), BF_ScaleWidth(25)) title:nil image:@"iconfont-setting" font:0 titleColor:nil];
    [settingButton addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingButton];
    
    //未登录前的页面
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(100), CGRectGetMaxY(self.headButton.frame)+BF_ScaleHeight(20), BF_ScaleWidth(120), BF_ScaleHeight(40))];
    self.buttonView.layer.borderWidth = 1;
    self.buttonView.layer.cornerRadius = ButtonViewHeight/2;
    self.buttonView.layer.borderColor = BFColor(0x5C5C5B).CGColor;
    //buttonView.backgroundColor = [UIColor redColor];
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
    self.nickNameView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headButton.frame), ScreenWidth, 0.31*ScreenHeight-self.headButton.height)];
    //self.nickNameView.backgroundColor = [UIColor redColor];
    [self addSubview:self.nickNameView];
    
    self.IDLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(60), BF_ScaleHeight(15), BF_ScaleWidth(80), ButtonViewHeight)];
    //self.IDLabel.backgroundColor = [UIColor redColor];
    [self.nickNameView addSubview:self.IDLabel];
    
    self.referenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, BF_ScaleHeight(15), BF_ScaleWidth(150), ButtonViewHeight)];
    self.referenceLabel.backgroundColor = [UIColor greenColor];
    [self.nickNameView addSubview:self.referenceLabel];
    
    self.referenceButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2, BF_ScaleHeight(10), BF_ScaleWidth(100), ButtonViewHeight+BF_ScaleHeight(10))];
    [self.referenceButton setTitle:@"添加推荐人" forState:UIControlStateNormal];
    self.referenceButton.backgroundColor = BFColor(0xD20000);
    [self.referenceButton addTarget:self action:@selector(identityRecommender) forControlEvents:UIControlEventTouchUpInside];
    [self.nickNameView addSubview:self.referenceButton];
    
    

    self.threeButtonView = [[UIView alloc] initWithFrame:CGRectMake(0,0.09*ScreenHeight, ScreenWidth, ButtonViewHeight)];
    //self.threeButtonView.backgroundColor = [UIColor blueColor];
    [self.nickNameView addSubview:self.threeButtonView];
    
    UIButton *integralButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeIntegral titleText:@"积分"];
    [self.threeButtonView addSubview:integralButton];
    UIButton *advertisingExpenseButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeAdvertisingExpense titleText:@"当月广告费"];
    [self.threeButtonView addSubview:advertisingExpenseButton];
    UIButton *myClientButton = [self setUpButtonWithType:BFPersonalCenterTopButtonTypeMyClient titleText:@"我的客户"];
    [self.threeButtonView addSubview:myClientButton];
    

    UIView *seperateLineOne = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/3-0.5, CGRectGetMidY(self.threeButtonView.frame), 1, BF_ScaleHeight(30))];
    seperateLineOne.backgroundColor = BFColor(0xB4B4B1);
    [self.nickNameView addSubview:seperateLineOne];
    
    UIView *seperateLineTwo = [[UIView alloc] initWithFrame:CGRectMake((2*ScreenWidth/3)-0.5, CGRectGetMidY(self.threeButtonView.frame), 1, BF_ScaleHeight(30))];
    seperateLineTwo.backgroundColor = BFColor(0xB4B4B1);
    [self.nickNameView addSubview:seperateLineTwo];
    
    
    self.integralLabel = [UILabel labelWithFrame:CGRectMake(0, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight) font:BF_ScaleFont(14) textColor:BFColor(0xEE3E00) text:@"123"];
    self.integralLabel.textAlignment = NSTextAlignmentCenter;
    [self.nickNameView addSubview:self.integralLabel];
    
    self.advertisingExpenseLabel = [UILabel labelWithFrame:CGRectMake(ScreenWidth/3, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight) font:BF_ScaleFont(14) textColor:BFColor(0xEE3E00) text:@"123"];
    self.advertisingExpenseLabel.textAlignment = NSTextAlignmentCenter;
    [self.nickNameView addSubview:self.advertisingExpenseLabel];
    
    self.myClientLabel = [UILabel labelWithFrame:CGRectMake(ScreenWidth*2/3, CGRectGetMaxY(self.threeButtonView.frame), ScreenWidth/3, LabelHeight) font:BF_ScaleFont(14) textColor:BFColor(0xEE3E00) text:@"132"];
    self.myClientLabel.textAlignment = NSTextAlignmentCenter;
    [self.nickNameView addSubview:self.myClientLabel];
    
    
    
    
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

- (void)identityRecommender {
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
