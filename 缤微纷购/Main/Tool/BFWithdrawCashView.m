//
//  BFWithdrawCashView.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#define LabalH     BF_ScaleHeight(15)
#define Margin     BF_ScaleWidth(20)
#define ButtonW    BF_ScaleWidth(100)
#define ButtonH     BF_ScaleHeight(40)

#import "BFWithdrawCashView.h"

@interface BFWithdrawCashView()

@end


@implementation BFWithdrawCashView

#pragma mark -- 实例方法
+ (instancetype)creatWithdrawCashView {
    BFWithdrawCashView *withdrawCash = [[BFWithdrawCashView alloc] init];
    [withdrawCash showView];
    return withdrawCash;
}

#pragma mark -- init
- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self setUpView];
        [self addTapGestureRecognizerToSelf];
    }
    return self;
}
#pragma mark -- 添加手势
- (void)addTapGestureRecognizerToSelf {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToHide)];
    [self addGestureRecognizer:tap];
}

#pragma mark -- 创建页面
- (void)setUpView {
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    UILabel *firstLabel = [self setUpLabelWithFrame:CGRectMake(0, BF_ScaleHeight(120), ScreenWidth, LabalH) text:@"亲~提现时间为次月的15~20号,"];
    [self addSubview:firstLabel];
    
    UILabel *secondLabel = [self setUpLabelWithFrame:CGRectMake(0, CGRectGetMaxY(firstLabel.frame)+LabalH, ScreenWidth, LabalH) text:@"商家会直接打到您的银行卡号,"];
    [self addSubview:secondLabel];
    
    UILabel *thirdLabel = [self setUpLabelWithFrame:CGRectMake(0, CGRectGetMaxY(secondLabel.frame)+LabalH, ScreenWidth, LabalH) text:@"请确认以下信息无误"];
    [self addSubview:thirdLabel];
    
    UIView *line  = [UIView drawLineWithFrame:CGRectMake(Margin, CGRectGetMaxY(thirdLabel.frame)+LabalH, BF_ScaleWidth(280), 1)];
    line.backgroundColor = BFColor(0xffffff);
    [self addSubview:line];
    
    UILabel *nameLabel = [self setUpLabelWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame)+LabalH, ScreenWidth, LabalH) text:[NSString stringWithFormat:@"开户人：%@", userInfo.true_name]];
    [self addSubview:nameLabel];
    
    UILabel *bankLabel = [self setUpLabelWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame)+LabalH, ScreenWidth, LabalH) text:[NSString stringWithFormat:@"开户银行：%@", userInfo.bank_name]];
    [self addSubview:bankLabel];
    
    UILabel *branchLabel = [self setUpLabelWithFrame:CGRectMake(0, CGRectGetMaxY(bankLabel.frame)+LabalH, ScreenWidth, LabalH) text:[NSString stringWithFormat:@"开户网点：%@", userInfo.card_address]];
    [self addSubview:branchLabel];
    
    
    UILabel *bankCardLabel = [self setUpLabelWithFrame:CGRectMake(0, CGRectGetMaxY(branchLabel.frame)+LabalH, ScreenWidth, LabalH) text:[NSString stringWithFormat:@"银行账号：%@", userInfo.card_id]];
    [self addSubview:bankCardLabel];
    
    
    UIButton *correct = [UIButton buttonWithType:0];
    correct.frame = CGRectMake(Margin, CGRectGetMaxY(bankCardLabel.frame)+LabalH, ButtonW, ButtonH);
    correct.backgroundColor = BFColor(0x298B26);
    [correct setTitle:@"正确啦" forState:UIControlStateNormal];
    correct.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(17)];
    [correct setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    correct.layer.cornerRadius = 5;
    [correct addTarget:self action:@selector(tapToHide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:correct];
    
    UIButton *modify = [UIButton buttonWithType:0];
    modify.frame = CGRectMake(BF_ScaleWidth(200), CGRectGetMaxY(bankCardLabel.frame)+LabalH, ButtonW, ButtonH);
    modify.backgroundColor = BFColor(0xC2C2C2);
    [modify setTitle:@"去修改" forState:UIControlStateNormal];
    modify.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(17)];
    [modify setTitleColor:BFColor(0x434343) forState:UIControlStateNormal];
    modify.layer.cornerRadius = 5;
    [modify addTarget:self action:@selector(gotoModify) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:modify];
    
}


#pragma mark -- 展示view
- (void)showView {
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = BFColor(0x000000);
        self.alpha = 0.8;
    }];
}


#pragma mark -- 手势方法
- (void)tapToHide {
    [UIView animateWithDuration:0.5 animations:^{
        //self.backgroundColor = BFColor(0x000000);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark --去修改按钮点击事件
- (void)gotoModify {
    [UIView animateWithDuration:0.5 animations:^{
        //self.backgroundColor = BFColor(0x000000);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    // 延迟2秒执行：
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [BFNotificationCenter postNotificationName:@"gotoModify" object:nil];
    });
}



#pragma mark -- 创建label
- (UILabel *)setUpLabelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.textColor = BFColor(0xffffff);
    return label;
}


@end
