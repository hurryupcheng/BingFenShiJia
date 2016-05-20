//
//  BFBindPhoneNumberView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/16.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define Margin  BF_ScaleWidth(50)
#define TXWidth   BF_ScaleWidth(220)
#import "BFBindPhoneNumberView.h"
#import "HZQRegexTestter.h"
@interface BFBindPhoneNumberView(){
    __block int         sendLeftTime;
    __block NSTimer     *sendTimer;
}
/**注册按钮*/
@property (nonatomic, strong) UIButton *sureButton;
/**验证码按钮*/
@property (nonatomic, strong) UIButton *sendVerificationCodeButton;
@property (nonatomic, strong) UIView *passView;
@property (nonatomic, strong) UIView *lineFour;

@end

@implementation BFBindPhoneNumberView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self SetView];
    }
    return self;
}

- (void)SetView {
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
    
    self.passView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.verificationCodeTX.frame), ScreenWidth, 0)];
    self.passView.alpha = 0;
    self.passView.hidden = YES;
    //self.passView.backgroundColor = BFColor(0x4da800);
    [self addSubview:self.passView];
    
    UIView *lineTwo = [UIView drawLineWithFrame:CGRectMake(Margin, 0, TXWidth, 0.5)];
    [self.passView addSubview:lineTwo];

    self.firstPasswordTX = [UITextField textFieldWithFrame:CGRectMake(Margin, BF_ScaleHeight(10), TXWidth, BF_ScaleHeight(35)) image:@"password" placeholder:@"设置登录密码"];
    self.firstPasswordTX.secureTextEntry = YES;
    //self.firstPasswordTX.hidden = YES;
    self.firstPasswordTX.returnKeyType = UIReturnKeyNext;
    self.firstPasswordTX.delegate = self;
    [self.passView addSubview:self.firstPasswordTX];

    UIView *lineThree = [UIView drawLineWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.firstPasswordTX.frame), TXWidth, 0.5)];
    [self.passView addSubview:lineThree];

    self.secondPasswordTX = [UITextField textFieldWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.firstPasswordTX.frame)+BF_ScaleHeight(10), TXWidth, BF_ScaleHeight(35)) image:@"password" placeholder:@"确认登录密码"];
    self.secondPasswordTX.secureTextEntry = YES;
    //self.secondPasswordTX.hidden = YES;
    self.secondPasswordTX.returnKeyType = UIReturnKeyDone;
    self.secondPasswordTX.delegate = self;
    [self.passView addSubview:self.secondPasswordTX];
    
    self.lineFour = [UIView drawLineWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.passView.frame), TXWidth, 0.5)];

    [self addSubview:self.lineFour];
    
    self.sureButton = [UIButton buttonWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.lineFour.frame)+BF_ScaleHeight(20), TXWidth, BF_ScaleHeight(29)) title:@"确定" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xFD8727)];
    //sendVerificationCodeButton.backgroundColor = [UIColor orangeColor];
    self.sureButton.layer.cornerRadius = BF_ScaleHeight(10);
    self.sureButton.layer.masksToBounds = YES;
    self.sureButton.layer.borderColor = BFColor(0xFD8727).CGColor;
    self.sureButton.layer.borderWidth = BF_ScaleWidth(1);
    //sendVerificationCodeButton.backgroundColor = BFColor(0xffffff);
    [self.sureButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sureButton];
    [self layoutSubviews];

}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.lineFour.frame = CGRectMake(Margin, CGRectGetMaxY(self.passView.frame), TXWidth, 0.5);
//    self.sureButton.frame = CGRectMake(Margin, CGRectGetMaxY(self.lineFour.frame)+BF_ScaleHeight(20), TXWidth, BF_ScaleHeight(29));
}


- (void)sendVerificationCode:(UIButton *)sender {

    [self endEditing:YES];
    NSString *url  = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=send_code"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = self.phoneTX.text;
    if (self.phoneTX.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入手机号"];
    }else if (![HZQRegexTestter validatePhone:self.phoneTX.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的手机号"];
    }else {
        
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"已注册"]) {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"该手机号已被使用,请更换手机号"];
            }else if ([responseObject[@"msg"] isEqualToString:@"信息发送中"]) {
                sendLeftTime = 120;
                [self.sendVerificationCodeButton setEnabled:NO];
                //[self.sendVerificationCodeButton setBackgroundColor:BFColor(0xD5D8D1)];

                sendTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"信息发送成功,请查收"];
                [UIView animateWithDuration:0.5 animations:^{
                    self.passView.height = BF_ScaleHeight(92);
                    self.lineFour.y = CGRectGetMaxY(self.passView.frame);
                    self.sureButton.y = CGRectGetMaxY(self.lineFour.frame)+BF_ScaleHeight(20);
                    self.passView.alpha = 1;
                    self.passView.hidden = NO;
                }];
            }else {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"验证码发送失败,请稍后再试"];
            }
            BFLog(@"%@", responseObject);
        } failure:^(NSError *error) {
            BFLog(@"%@", error);
        }];
    }
    
    
}
#pragma mark -- 发送验证吗按钮计时器事件
- (void)timer {
    sendLeftTime--;
    if(sendLeftTime<=0)
    {
        [self.sendVerificationCodeButton setEnabled:YES];
        //[self.sendVerificationCodeButton setBackgroundColor:BFColor(0xFC940A)];
        [self.sendVerificationCodeButton setTitle:@"验证码" forState:UIControlStateNormal];
        [sendTimer invalidate];
        sendTimer = nil;
    } else {
        
        [self.sendVerificationCodeButton setEnabled:NO];
        //[self.sendVerificationCodeButton setBackgroundColor:BFColor(0xD5D8D1)];
        [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%ds",sendLeftTime] forState:UIControlStateNormal];
    }
}


- (void)sure:(UIButton *)sender {
    [self endEditing:YES];
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=w_tel"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"tel"] = self.phoneTX.text;
    parameter[@"code"] = self.verificationCodeTX.text;
    if (self.phoneTX.text.length == 0 || self.verificationCodeTX.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请完善信息"];
    }else if (![HZQRegexTestter validatePhone:self.phoneTX.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的手机号"];
    }else {
        [BFProgressHUD MBProgressWithLabelText:@"正在绑定手机号" dispatch_get_main_queue:^(MBProgressHUD *hud) {
            [BFHttpTool POST:url params:parameter success:^(id responseObject) {
                BFLog(@"%@,,%@",responseObject,parameter);
                if ([responseObject[@"msg"] isEqualToString:@"已绑定手机号"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"手机号已经被绑定"];
                }else if ([responseObject[@"msg"] isEqualToString:@"绑定成功"]) {
                    [BFProgressHUD MBProgressFromView:self LabelText:@"手机绑定成功,正在跳转" dispatch_get_main_queue:^{
                        userInfo.tel = self.phoneTX.text;
                        [BFUserDefaluts modifyUserInfo:userInfo];
                        if (self.delegate && [self.delegate respondsToSelector:@selector(gotoLoginController:)]) {
                            [self.delegate gotoLoginController:userInfo];
                        }
                    }];
                }else {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"手机绑定失败,请重新绑定"];
                }
            } failure:^(NSError *error) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressOnlyWithLabelText:@"网络异常"];
                BFLog(@"%@",error);
            }];

        }];
    }
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.phoneTX) {
        [self.verificationCodeTX becomeFirstResponder];
    }else if (textField == self.verificationCodeTX) {
        [self.firstPasswordTX becomeFirstResponder];
    }else if (textField == self.firstPasswordTX) {
        [self.secondPasswordTX becomeFirstResponder];
    }else {
        [self.secondPasswordTX resignFirstResponder];
    }
    return YES;
}



@end
