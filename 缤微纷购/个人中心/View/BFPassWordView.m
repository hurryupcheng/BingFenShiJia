//
//  BFPassWordView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define Margin  BF_ScaleWidth(50)
#define TXWidth   BF_ScaleWidth(220)
#import "BFPassWordView.h"
#import "BFMobileNumber.h"
#import "MyMD5.h"

@interface BFPassWordView(){
    __block int         leftTime;
    __block NSTimer     *timer;
}

/**注册按钮*/
@property (nonatomic, strong) UIButton *registerButton;
/**验证码按钮*/
@property (nonatomic, strong) UIButton *sendVerificationCodeButton;
@end

@implementation BFPassWordView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

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
    
    self.registerButton = [UIButton buttonWithFrame:CGRectMake(Margin, CGRectGetMaxY(lineFour.frame)+BF_ScaleHeight(20), TXWidth, BF_ScaleHeight(29)) title:@"注册" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xFD8727)];
       //sendVerificationCodeButton.backgroundColor = [UIColor orangeColor];
    self.registerButton.layer.cornerRadius = BF_ScaleHeight(10);
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.borderColor = BFColor(0xFD8727).CGColor;
    self.registerButton.layer.borderWidth = BF_ScaleWidth(1);
    //sendVerificationCodeButton.backgroundColor = BFColor(0xffffff);
    [self.registerButton addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.registerButton];
}

- (void)regist:(UIButton *)sender {
    [self endEditing:YES];
    

    if ([self.phoneTX.text isEqualToString:@""] || [self.verificationCodeTX.text isEqualToString:@""] || [self.firstPasswordTX.text isEqualToString:@""] ||[self.secondPasswordTX.text isEqualToString:@""]) {

        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入完善注册信息"];
    }else if ((self.firstPasswordTX.text.length < 6 || self.firstPasswordTX.text.length > 20) || (self.secondPasswordTX.text.length < 6 || self.secondPasswordTX.text.length > 20)) {

        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入6~20位的密码"];
    }else if (![self.firstPasswordTX.text isEqualToString:self.secondPasswordTX.text]) {

        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"密码不一致，请核对"];
    }else {


        
        NSString *firstPW = [MyMD5 md5:self.firstPasswordTX.text];
        NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=add_user"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"type"] = @"3";
        parameter[@"openid"] = self.phoneTX.text;
        parameter[@"nickname"] = @"";
        parameter[@"ico"] = @"";
        parameter[@"tel"] = self.phoneTX.text;
        parameter[@"pass"] = firstPW;
        parameter[@"code"] = self.verificationCodeTX.text;
        // 1.创建请求管理者
        [BFProgressHUD MBProgressWithLabelText:@"正在注册..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"responseObject%@,,,%@",responseObject,parameter);
            //BFRegistModel *model = [BFRegistModel parse:responseObject];
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressWithLabelText:@"注册成功，正在跳转..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(userRigisterWithBFPassWordView: hud:)]) {
                        [self.delegate userRigisterWithBFPassWordView:self hud:hud];
                    }
                    
                }];
            }else if([responseObject[@"status"] isEqualToString:@"0"]){
                if ([responseObject[@"msg"] isEqualToString:@"验证码不对"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"验证码不正确"];
                } else if ([responseObject[@"msg"] isEqualToString:@"验证码过期"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"验证码过期"];
                }else if ([responseObject[@"msg"] isEqualToString:@"该帐号已注册"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressOnlyWithLabelText:@"该手机号已注册,请更换"];
                    self.verificationCodeTX.text = @"";
                }else if ([responseObject[@"msg"] isEqualToString:@"注册失败"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"注册失败"];
                }else {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"注册失败"];
                }

            }
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"网络异常"];
            BFLog(@"error%@",error);
        }];
            }];
    }
}


- (void)sendVerificationCode:(UIButton *)sender {
    [self endEditing:YES];
    if (![BFMobileNumber isMobileNumber:self.phoneTX.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入有效的手机号"];
    }else {
        
        NSString *url  = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=send_code"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"phone"] = self.phoneTX.text;
        //BFLog(@"responseObject%@，，，%@",parameter,url);
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"已注册"]) {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"该手机号已注册"];
            }else {
                leftTime = 120;
                [self.sendVerificationCodeButton setEnabled:NO];
                [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%d秒",leftTime] forState:UIControlStateNormal];
                [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%d秒",leftTime] forState:UIControlStateDisabled];
    
                timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"信息发送中..."];
                
                
//                if (self.delegate && [self.delegate respondsToSelector:@selector(sendVerificationCodeBFPassWordView:button:)]) {
//                    //[self.delegate sendVerificationCodeBFPassWordView:self button:sender];
//                }

            }
            BFLog(@"responseObject%@，，，%@",responseObject,url);
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromWindowWithLabelText:@"网络异常，请检查"];
            BFLog(@"error%@",error);
        }];
    }
}



- (void)timerAction
{

    leftTime--;
    if(leftTime<=0)
    {

        [self.sendVerificationCodeButton setEnabled:YES];
        [self.sendVerificationCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.sendVerificationCodeButton setTitle:@"重新发送" forState:UIControlStateDisabled];
        //倒计时完取消倒计时
        [timer invalidate];
        timer = nil;
    }
    else
    {
        
        [self.sendVerificationCodeButton setEnabled:NO];
        [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%d秒",leftTime] forState:UIControlStateNormal];
        [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%d秒",leftTime] forState:UIControlStateDisabled];
        
    }
}



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
