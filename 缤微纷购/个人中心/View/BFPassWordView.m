//
//  BFPassWordView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPassWordView.h"

@interface BFPassWordView()

/**注册按钮*/
@property (nonatomic, strong) UIButton *registerButton;
@end

@implementation BFPassWordView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    self.verificationCodeTX = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(60), BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(35)) image:@"password" placeholder:@"请输入验证码"];
    //self.verificationCodeTX.secureTextEntry = YES;
    self.verificationCodeTX.delegate = self;
    self.verificationCodeTX.returnKeyType = UIReturnKeyNext;
    [self addSubview:self.verificationCodeTX];
    
    UIView *lineOne = [UIView drawLineWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.verificationCodeTX.frame), ScreenWidth-BF_ScaleWidth(120), 1)];
    [self addSubview:lineOne];
    
    self.firstPasswordTX = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.verificationCodeTX.frame)+BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(35)) image:@"password" placeholder:@"请输入密码"];
    self.firstPasswordTX.secureTextEntry = YES;
    self.firstPasswordTX.returnKeyType = UIReturnKeyNext;
    self.firstPasswordTX.delegate = self;
    [self addSubview:self.firstPasswordTX];
    
    UIView *lineTwo = [UIView drawLineWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.firstPasswordTX.frame), ScreenWidth-BF_ScaleWidth(120), 1)];
    [self addSubview:lineTwo];
    
    self.secondPasswordTX = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.firstPasswordTX.frame)+BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(35)) image:@"password" placeholder:@"请输入密码"];
    self.secondPasswordTX.secureTextEntry = YES;
    self.secondPasswordTX.returnKeyType = UIReturnKeyDone;
    self.secondPasswordTX.delegate = self;
    [self addSubview:self.secondPasswordTX];
    
    UIView *lineThree = [UIView drawLineWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.secondPasswordTX.frame), ScreenWidth-BF_ScaleWidth(120), 1)];
    [self addSubview:lineThree];
    
    self.registerButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(lineThree.frame)+BF_ScaleHeight(20), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(36)) title:@"注册" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xFD8727)];
       //sendVerificationCodeButton.backgroundColor = [UIColor orangeColor];
    self.registerButton.layer.cornerRadius = BF_ScaleHeight(18);
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.borderColor = BFColor(0xFD8727).CGColor;
    self.registerButton.layer.borderWidth = BF_ScaleWidth(1);
    //sendVerificationCodeButton.backgroundColor = BFColor(0xffffff);
    [self.registerButton addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.registerButton];
}

- (void)regist:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(userRigisterWithBFPassWordView:)]) {
        [self.delegate userRigisterWithBFPassWordView:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL lastValue = NO;
    if (textField == self.verificationCodeTX) {
        [self.firstPasswordTX becomeFirstResponder];
        lastValue = NO;
    }else if (textField == self.firstPasswordTX) {
        [self.secondPasswordTX becomeFirstResponder];
        lastValue = NO;
    }else {
        [self.secondPasswordTX resignFirstResponder];
    }
    return lastValue;
}

@end
