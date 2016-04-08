//
//  BFBindPhoneNumberController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFBindPhoneNumberController.h"
#import "HZQRegexTestter.h"

@interface BFBindPhoneNumberController ()<UITextFieldDelegate>{
    __block int         leftTime;
    __block NSTimer     *timer;
    __block int         sendLeftTime;
    __block NSTimer     *sendTimer;
}
/**手机号输入框*/
@property (nonatomic, strong) UITextField *phoneNumberTX;
/**验证码*/
@property (nonatomic, strong) UITextField *verificationCodeTX;
/**保存按钮*/
@property (nonatomic, strong) UIButton *saveButton;
/**发送验证码*/
@property (nonatomic, strong) UIButton *sendVerificationCodeButton;
@end

@implementation BFBindPhoneNumberController

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"绑定手机";
    //添加控件
    [self setUpView];
}

#pragma mark -- 创建控件
- (void)setUpView {
    
    self.phoneNumberTX = [UITextField textFieldWithFrame:CGRectMake(0, BF_ScaleHeight(20), BF_ScaleWidth(320), BF_ScaleHeight(30)) image:nil placeholder:@"请输入手机号"];
    self.phoneNumberTX.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberTX.delegate = self;
    self.phoneNumberTX.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.phoneNumberTX];
    
    UIView *firstLine = [UIView drawLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneNumberTX.frame), ScreenWidth, 0.5)];
    [self.view addSubview:firstLine];
    
    
    self.verificationCodeTX = [UITextField textFieldWithFrame:CGRectMake(0, CGRectGetMaxY(firstLine.frame)+BF_ScaleHeight(20), BF_ScaleWidth(185), BF_ScaleHeight(30)) image:nil placeholder:@"请输入验证码"];
    //self.verificationCodeTX.backgroundColor = [UIColor redColor];
    self.verificationCodeTX.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verificationCodeTX.delegate = self;
    self.verificationCodeTX.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.verificationCodeTX];
    
    self.sendVerificationCodeButton = [UIButton buttonWithType:0];
    self.sendVerificationCodeButton.frame = CGRectMake(BF_ScaleWidth(200), CGRectGetMaxY(firstLine.frame)+BF_ScaleHeight(20), BF_ScaleWidth(105), BF_ScaleHeight(30));
    self.sendVerificationCodeButton.backgroundColor = BFColor(0xFC940A);
    [self.sendVerificationCodeButton setTitle:@"验证码" forState:UIControlStateNormal];
    [self.sendVerificationCodeButton setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    self.sendVerificationCodeButton.layer.cornerRadius = 5;
    [self.sendVerificationCodeButton addTarget:self action:@selector(sendVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendVerificationCodeButton];

    
    UIView *secondLine = [UIView drawLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.verificationCodeTX.frame), BF_ScaleWidth(185), 0.5)];
    [self.view addSubview:secondLine];
    
    UIButton *saveButton = [UIButton buttonWithType:0];
    self.saveButton = saveButton;
    saveButton.frame = CGRectMake(BF_ScaleWidth(15), CGRectGetMaxY(secondLine.frame)+BF_ScaleHeight(20), BF_ScaleWidth(290), BF_ScaleHeight(30));
    saveButton.backgroundColor = BFColor(0xFC940A);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    saveButton.layer.cornerRadius = 5;
    [saveButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}

#pragma mark -- 发送验证吗按钮点击事件
- (void)sendVerificationCode:(UIButton *)sender {
    [self.view endEditing:YES];
    
    
    NSString *url  = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=send_code"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = self.phoneNumberTX.text;
    if (self.phoneNumberTX.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请输入手机号"];
    }else if (![HZQRegexTestter validatePhone:self.phoneNumberTX.text]) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请输入正确的手机号"];
    }else {
        
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"已注册"]) {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"该手机号已被使用,请更换手机号"];
            }else if ([responseObject[@"msg"] isEqualToString:@"信息发送中"]) {
                sendLeftTime = 120;
                [self.sendVerificationCodeButton setEnabled:NO];
                [self.sendVerificationCodeButton setBackgroundColor:BFColor(0xD5D8D1)];
                
                if(sendTimer)
                    [sendTimer invalidate];
                sendTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"信息发送成功,请查收"];
            }else {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"验证码发送失败,请稍后再试"];
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
        [self.sendVerificationCodeButton setBackgroundColor:BFColor(0xFC940A)];
        [self.sendVerificationCodeButton setTitle:@"验证码" forState:UIControlStateNormal];
    } else {
        
        [self.sendVerificationCodeButton setEnabled:NO];
        [self.sendVerificationCodeButton setBackgroundColor:BFColor(0xD5D8D1)];
        [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%ds",sendLeftTime] forState:UIControlStateNormal];
    }
}

#pragma mark -- 保存按钮点击事件
- (void)click:(UIButton *)sender {
    [self.view endEditing:YES];
    //点击按钮，2秒内不能点击
    leftTime = 2;
    [self.saveButton setEnabled:NO];
    [self.saveButton setBackgroundColor:BFColor(0xD5D8D1)];
    
    if(timer)
        [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=w_tel"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"tel"] = self.phoneNumberTX.text;
    parameter[@"code"] = self.verificationCodeTX.text;
    if (self.phoneNumberTX.text.length == 0 || self.verificationCodeTX.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请完善信息"];
    }else if (![HZQRegexTestter validatePhone:self.phoneNumberTX.text]) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请输入正确的手机号"];
    }else {
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"%@,,%@",responseObject,parameter);
            if (![responseObject[@"msg"] isEqualToString:@"绑定成功"]) {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"手机绑定失败,请重新绑定"];
            }else {
                [BFProgressHUD MBProgressFromView:self.view LabelText:@"手机绑定成功,正在跳转" dispatch_get_main_queue:^{
                    userInfo.tel = self.phoneNumberTX.text;
                    [BFUserDefaluts modifyUserInfo:userInfo];
                    _block(userInfo);
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        } failure:^(NSError *error) {
            BFLog(@"%@",error);
        }];

    }
}

#pragma mark --计时器方法
- (void)timerAction {
    leftTime--;
    if(leftTime<=0)
    {
        [self.saveButton setEnabled:YES];
        self.saveButton.backgroundColor = BFColor(0xFC940A);
    } else {
        
        [self.saveButton setEnabled:NO];
        [self.saveButton setBackgroundColor:BFColor(0xD5D8D1)];
    }
    
}

#pragma mark -- 点击屏幕收起键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -- textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.phoneNumberTX resignFirstResponder];
    return YES;
}

@end
