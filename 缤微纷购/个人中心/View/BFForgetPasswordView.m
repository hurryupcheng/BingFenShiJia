//
//  BFForgetPasswordView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define Margin  BF_ScaleWidth(50)
#define TXWidth   BF_ScaleWidth(220)

#import "BFMobileNumber.h"
#import "MyMD5.h"
#import "BFForgetPasswordView.h"

@interface BFForgetPasswordView(){
    __block int         verificationTime;
    __block NSTimer     *verificationTimer;
    __block int         sureTime;
    __block NSTimer     *sureTimer;
}
/**注册按钮*/
@property (nonatomic, strong) UIButton *sureButton;
/**验证码按钮*/
@property (nonatomic, strong) UIButton *sendVerificationCodeButton;

@end

@implementation BFForgetPasswordView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

#pragma mark -- 创建控件
- (void)setView {
    self.phoneTX = [UITextField textFieldWithFrame:CGRectMake(Margin, BF_ScaleHeight(150), TXWidth, BF_ScaleHeight(35)) image:@"phone" placeholder:@"手机号"];
    self.phoneTX.delegate = self;
    self.phoneTX.returnKeyType = UIReturnKeyNext;
    [self addSubview:self.phoneTX];
    
    UIView *lineOne = [UIView drawLineWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.phoneTX.frame), TXWidth, 0.5)];
    [self addSubview:lineOne];
    
    self.verificationCodeTX = [UITextField textFieldWithFrame:CGRectMake(Margin, CGRectGetMaxY(lineOne.frame)+BF_ScaleHeight(10), TXWidth, BF_ScaleHeight(36)) image:@"yanzhengma" placeholder:@"短信验证码"];
    //self.verificationCodeTX.secureTextEntry = YES;
    self.verificationCodeTX.delegate = self;
    self.verificationCodeTX.returnKeyType = UIReturnKeyNext;
    [self addSubview:self.verificationCodeTX];
    
    self.sendVerificationCodeButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(210), CGRectGetMaxY(lineOne.frame)+BF_ScaleHeight(10), BF_ScaleWidth(60), BF_ScaleHeight(25)) title:@"验证码" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xFD8727)];
    self.sendVerificationCodeButton.tag = 100;
    self.sendVerificationCodeButton.layer.cornerRadius = BF_ScaleHeight(4);
    self.sendVerificationCodeButton.layer.masksToBounds = YES;
    self.sendVerificationCodeButton.layer.borderColor = BFColor(0xFD8727).CGColor;
    self.sendVerificationCodeButton.layer.borderWidth = BF_ScaleWidth(1);
    //sendVerificationCodeButton.backgroundColor = BFColor(0xffffff);
    [self.sendVerificationCodeButton addTarget:self action:@selector(sendVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sendVerificationCodeButton];
    
    UIView *lineTwo = [UIView drawLineWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.verificationCodeTX.frame), TXWidth, 0.5)];
    [self addSubview:lineTwo];
    
    self.firstPasswordTX = [UITextField textFieldWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.verificationCodeTX.frame)+BF_ScaleHeight(10), TXWidth, BF_ScaleHeight(35)) image:@"password" placeholder:@"设置登录密码"];
    self.firstPasswordTX.secureTextEntry = YES;
    self.firstPasswordTX.returnKeyType = UIReturnKeyNext;
    self.firstPasswordTX.delegate = self;
    [self addSubview:self.firstPasswordTX];
    
    UIView *lineThree = [UIView drawLineWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.firstPasswordTX.frame), TXWidth, 0.5)];
    [self addSubview:lineThree];
    
    self.secondPasswordTX = [UITextField textFieldWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.firstPasswordTX.frame)+BF_ScaleHeight(10), TXWidth, BF_ScaleHeight(35)) image:@"password" placeholder:@"确认登录密码"];
    self.secondPasswordTX.secureTextEntry = YES;
    self.secondPasswordTX.returnKeyType = UIReturnKeyDone;
    self.secondPasswordTX.delegate = self;
    [self addSubview:self.secondPasswordTX];
    
    UIView *lineFour = [UIView drawLineWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.secondPasswordTX.frame), TXWidth, 0.5)];
    [self addSubview:lineFour];
    
    self.sureButton = [UIButton buttonWithFrame:CGRectMake(Margin, CGRectGetMaxY(lineFour.frame)+BF_ScaleHeight(20), TXWidth, BF_ScaleHeight(29)) title:@"确定" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xFD8727)];
    //sendVerificationCodeButton.backgroundColor = [UIColor orangeColor];
    self.sureButton.layer.cornerRadius = BF_ScaleHeight(10);
    self.sureButton.layer.masksToBounds = YES;
    self.sureButton.layer.borderColor = BFColor(0xFD8727).CGColor;
    self.sureButton.layer.borderWidth = BF_ScaleWidth(1);
    //sendVerificationCodeButton.backgroundColor = BFColor(0xffffff);
    [self.sureButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sureButton];

}

#pragma mark -- 确定修改按钮点击事件
- (void)sure:(UIButton *)sender {
    [self endEditing:YES];
    
    
    
    if (self.phoneTX.text.length == 0 || self.verificationCodeTX.text.length == 0 || self.firstPasswordTX.text.length == 0 || self.secondPasswordTX.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请完善信息"];
    } else if (![BFMobileNumber isMobileNumber:self.phoneTX.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入有效的手机号"];
    }else if (![self.firstPasswordTX.text isEqualToString:self.secondPasswordTX.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"两次输入的密码不匹配,请重新输入"];
    }else if ((self.firstPasswordTX.text.length < 6 || self.firstPasswordTX.text.length > 20) || (self.secondPasswordTX.text.length < 6 || self.secondPasswordTX.text.length > 20)) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入6~20位长度密码"];
    } else {
        
        sureTime = 5;
        [self.sureButton setEnabled:NO];
        self.sureButton.layer.borderColor = BFColor(0xD5D8D1).CGColor;
        [self.sureButton setTitleColor:BFColor(0xD5D8D1) forState:UIControlStateNormal];
        [self.sureButton setTitleColor:BFColor(0xD5D8D1) forState:UIControlStateDisabled];
        if(sureTimer)
            [sureTimer invalidate];
        sureTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sureAction) userInfo:nil repeats:YES];
        
        
        NSString *firstPW = [MyMD5 md5:self.firstPasswordTX.text];
        NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=reup_pass"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"tel"] = self.phoneTX.text;
        parameter[@"news_pass"] = firstPW;
        parameter[@"code"] = self.verificationCodeTX.text;
        // 1.创建请求管理者
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"responseObject%@,,,%@",responseObject, parameter);

            if ([responseObject[@"msg"] isEqualToString:@"验证码不对"]) {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"验证码不正确"];
            } else if ([responseObject[@"msg"] isEqualToString:@"验证码过期"]) {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"验证码过期"];
            }else if ([responseObject[@"msg"] isEqualToString:@"修改密码失败"]) {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"密码修改失败"];
            }else {
                [BFProgressHUD MBProgressFromWindowWithLabelText:@"密码修改成功，正在跳转..." dispatch_get_main_queue:^{
                    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoLoginVC)]) {
                        [self.delegate gotoLoginVC];
                    }
                }];
            }
        } failure:^(NSError *error) {
            BFLog(@"error%@",error);
        }];

    }
}


- (void)sureAction {
    sureTime--;
    if(sureTime <= 0)
    {
        [self.sureButton setEnabled:YES];
        self.sureButton.layer.borderColor = BFColor(0xFD8727).CGColor;
        [self.sureButton setTitleColor:BFColor(0xFD8727) forState:UIControlStateNormal];
        [self.sureButton setTitleColor:BFColor(0xFD8727) forState:UIControlStateDisabled];
        [sureTimer invalidate];
        sureTimer = nil;
    } else
    {
        [self.sureButton setEnabled:NO];
        self.sureButton.layer.borderColor = BFColor(0xD5D8D1).CGColor;
        [self.sureButton setTitleColor:BFColor(0xD5D8D1) forState:UIControlStateNormal];
        [self.sureButton setTitleColor:BFColor(0xD5D8D1) forState:UIControlStateDisabled];
    }

}


#pragma mark -- 验证码按钮点击事件
- (void)sendVerificationCode:(UIButton *)sender {
    [self endEditing:YES];
    if (![BFMobileNumber isMobileNumber:self.phoneTX.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入有效的手机号"];
    }else {
        
        NSString *url  = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=sendpass_code"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"phone"] = self.phoneTX.text;
        //BFLog(@"responseObject%@，，，%@",parameter,url);
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"用户不存在"]) {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"该手机号不是注册用户"];
            }else {
                verificationTime = 120;
                [self.sendVerificationCodeButton setEnabled:NO];
                [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%d秒",verificationTime] forState:UIControlStateNormal];
                [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%d秒",verificationTime] forState:UIControlStateDisabled];
                if(verificationTimer)
                [verificationTimer invalidate];
                verificationTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(verificationTimerAction) userInfo:nil repeats:YES];
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"信息发送中..."];
                
            }
            BFLog(@"responseObject%@，，，%@",responseObject,url);
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromWindowWithLabelText:@"网络异常，请检查"];
            BFLog(@"error%@",error);
        }];
    }
}

#pragma mark -- 发送验证码按钮倒计时事件
- (void)verificationTimerAction {
    verificationTime--;
    if(verificationTime <= 0)
    {

        [self.sendVerificationCodeButton setEnabled:YES];
        [self.sendVerificationCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.sendVerificationCodeButton setTitle:@"重新发送" forState:UIControlStateDisabled];
        [verificationTimer invalidate];
        verificationTimer = nil;
        
    }
    else
    {
        
        [self.sendVerificationCodeButton setEnabled:NO];
        [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%d秒",verificationTime] forState:UIControlStateNormal];
        [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%d秒",verificationTime] forState:UIControlStateDisabled];
        
    }

}

#pragma mark -- textfield代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL lastValue = NO;
    if (textField == self.phoneTX) {
        [self.verificationCodeTX becomeFirstResponder];
    }else if (textField == self.verificationCodeTX) {
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
