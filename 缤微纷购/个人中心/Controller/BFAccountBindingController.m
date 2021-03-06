//
//  BFAccountBindingController.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define Margin  BF_ScaleWidth(50)
#define TXWidth   BF_ScaleWidth(220)
#import "BFAccountBindingController.h"
#import "HZQRegexTestter.h"

@interface BFAccountBindingController ()<UITextFieldDelegate>{
    __block int         sendLeftTime;
    __block NSTimer     *sendTimer;
}
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**头像*/
@property (nonatomic, strong) UIImageView *headIcon;
/**手机号*/
@property (nonatomic, strong) UITextField *phoneTX;
/**验证码*/
@property (nonatomic, strong) UITextField *verificationCodeTX;
/**发送验证码按钮*/
@property (nonatomic ,strong) UIButton *sendVerificationCodeButton;
/**立即绑定登录*/
@property (nonatomic, strong) UIButton *sureButton;
@end

@implementation BFAccountBindingController


#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"账号绑定";
    /**添加导航栏*/
    [self setUpNavigationBar];
    /**添加view*/
    [self setUpView];
    
    [BFProgressHUD MBProgressOnlyWithLabelText:@"还未绑定手机号,请绑定"];

}

- (void)setUpView {
    self.headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(100), BF_ScaleWidth(60), BF_ScaleHeight(60))];
    self.headIcon.layer.cornerRadius = BF_ScaleWidth(30);
    self.headIcon.layer.masksToBounds = YES;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:self.parameter[@"ico"]] placeholderImage:[UIImage imageNamed:@"head_image"]];
    [self.view addSubview:self.headIcon];
    
    UILabel *nickName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame) + BF_ScaleWidth(10), self.headIcon.y+BF_ScaleHeight(5), BF_ScaleWidth(200), BF_ScaleHeight(25))];
    nickName.textColor = BFColor(0x2D2D2D);
    nickName.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    nickName.text = [NSString stringWithFormat:@"亲爱的%@", self.parameter[@"nickname"]];
    [self.view addSubview:nickName];
    
    
    UILabel *remind = [[UILabel alloc] initWithFrame:CGRectMake(nickName.x, CGRectGetMaxY(nickName.frame)+BF_ScaleHeight(5), BF_ScaleWidth(200), BF_ScaleHeight(20))];
    remind.textColor = BFColor(0x303030);
    remind.font = [UIFont systemFontOfSize:BF_ScaleHeight(12)];
    remind.text = @"为了您的账户安全,请关联您的手机号";
    [self.view addSubview:remind];
    
    self.phoneTX = [UITextField textFieldWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.headIcon.frame)+BF_ScaleHeight(30), TXWidth, BF_ScaleHeight(35)) image:@"phone" placeholder:@"手机号"];
    self.phoneTX.delegate = self;
    self.phoneTX.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.phoneTX];
    
    UIView *lineOne = [UIView drawLineWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.phoneTX.frame), TXWidth, 0.5)];
    [self.view addSubview:lineOne];
    
    self.verificationCodeTX = [UITextField textFieldWithFrame:CGRectMake(Margin, CGRectGetMaxY(lineOne.frame)+BF_ScaleHeight(10), TXWidth, BF_ScaleHeight(36)) image:@"yanzhengma" placeholder:@"短信验证码"];
    //self.verificationCodeTX.secureTextEntry = YES;
    self.verificationCodeTX.delegate = self;
    self.verificationCodeTX.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.verificationCodeTX];
    
    self.sendVerificationCodeButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(210), CGRectGetMaxY(lineOne.frame)+BF_ScaleHeight(10), BF_ScaleWidth(60), BF_ScaleHeight(25)) title:@"验证码" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xFD8727)];
    self.sendVerificationCodeButton.tag = 100;
    self.sendVerificationCodeButton.layer.cornerRadius = BF_ScaleHeight(4);
    self.sendVerificationCodeButton.layer.masksToBounds = YES;
    self.sendVerificationCodeButton.layer.borderColor = BFColor(0xFD8727).CGColor;
    self.sendVerificationCodeButton.layer.borderWidth = BF_ScaleWidth(1);
    //sendVerificationCodeButton.backgroundColor = BFColor(0xffffff);
    [self.sendVerificationCodeButton addTarget:self action:@selector(sendVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendVerificationCodeButton];
    
    UIView *lineSecond = [UIView drawLineWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.verificationCodeTX.frame), TXWidth, 0.5)];
    [self.view addSubview:lineSecond];
    
    
    self.sureButton = [UIButton buttonWithFrame:CGRectMake(Margin, CGRectGetMaxY(lineSecond.frame)+BF_ScaleHeight(20), TXWidth, BF_ScaleHeight(29)) title:@"立即绑定登录" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xFD8727)];
    //sendVerificationCodeButton.backgroundColor = [UIColor orangeColor];
    self.sureButton.layer.cornerRadius = BF_ScaleHeight(10);
    self.sureButton.layer.masksToBounds = YES;
    self.sureButton.layer.borderColor = BFColor(0xFD8727).CGColor;
    self.sureButton.layer.borderWidth = BF_ScaleWidth(1);
    //sendVerificationCodeButton.backgroundColor = BFColor(0xffffff);
    [self.sureButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureButton];
    
    
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin, CGRectGetMaxY(self.sureButton.frame)+BF_ScaleHeight(30), TXWidth, BF_ScaleHeight(200))];
    warningLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(15)];
    warningLabel.numberOfLines = 0;
    warningLabel.text = WarningText;
    NSMutableAttributedString *detailAttributedString = [[NSMutableAttributedString alloc] initWithString:warningLabel.text];
    NSMutableParagraphStyle *detailParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [detailParagraphStyle setLineSpacing:BF_ScaleHeight(6)];//调整行间距
    [detailAttributedString addAttribute:NSParagraphStyleAttributeName value:detailParagraphStyle range:NSMakeRange(0, [warningLabel.text length])];
    warningLabel.attributedText = detailAttributedString;

    //warningLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:warningLabel];
    [warningLabel sizeToFit];
}


- (void)sure:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.phoneTX.text.length == 0 || self.verificationCodeTX.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请完善信息"];
    }else if (![HZQRegexTestter validatePhone:self.phoneTX.text]) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请输入正确的手机号"];
    }else {
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"友情提醒" message:WarningText preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"先去微信商城确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"点击");
        }];
        
        UIAlertAction *newAction = [UIAlertAction actionWithTitle:@"新用户注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self registAndBunding];
        }];
        
        UIAlertAction *oldAction = [UIAlertAction actionWithTitle:@"微信商城老客户绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self registAndBunding];
        }];
        
        
        [alertC addAction:cancleAction];
        [alertC addAction:newAction];
        [alertC addAction:oldAction];
        
        
        //    UIAlertController *warningAC = [UIAlertController alertWithControllerTitle:@"友情提醒" controllerMessage:WarningText preferredStyle:UIAlertControllerStyleAlert cancleTitle:@"先去微信商城看看绑定没有" actionTitle:@"微信商城已经绑定手机号" style:UIAlertActionStyleDefault handler:^{
        //            }];
        [self presentViewController:alertC animated:YES completion:nil];
        
//        UIAlertController *warningAC = [UIAlertController alertWithControllerTitle:@"友情提醒" controllerMessage:WarningText preferredStyle:UIAlertControllerStyleAlert cancleTitle:@"先去微信商城看看绑定没有" actionTitle:@"微信商城已经绑定手机号" style:UIAlertActionStyleDefault handler:^{
//                    }];
//        [self presentViewController:warningAC animated:YES completion:nil];
        
    }
}


- (void)registAndBunding {
    [BFProgressHUD MBProgressWithLabelText:@"正在绑定手机号" dispatch_get_main_queue:^(MBProgressHUD *hud) {
        NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=add_user"];
        self.parameter[@"tel"] = self.phoneTX.text;
        self.parameter[@"code"] = self.verificationCodeTX.text;
        self.parameter[@"pass"] = @"";
        [BFHttpTool POST:url params:self.parameter success:^(id responseObject) {
            BFLog(@"%@,,,%@", responseObject,self.parameter);
            if ([responseObject[@"msg"] isEqualToString:@"绑定登录成功"]) {
                [hud hideAnimated:YES];
                BFUserInfo *userInfo = [BFUserInfo parse:responseObject];
                //userInfo.loginType = self.parameter[@"type"];
                _block(userInfo);
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else if ([responseObject[@"msg"] isEqualToString:@"验证码不对"]) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressOnlyWithLabelText:@"验证码不正确,请重新输入"];
                self.verificationCodeTX.text = @"";
            }else if ([responseObject[@"msg"] isEqualToString:@"验证码超时"]) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressOnlyWithLabelText:@"验证码超时,请重新发送"];
                self.verificationCodeTX.text = @"";
            }else if ([responseObject[@"msg"] isEqualToString:@"该帐号已注册"]) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressOnlyWithLabelText:@"该手机号已注册,请更换"];
                self.verificationCodeTX.text = @"";
            }else {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressOnlyWithLabelText:@"手机号绑定失败"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressOnlyWithLabelText:@"网络异常"];
            BFLog(@"%@", error);
        }];
    }];

}

#pragma mark -- 发送验证码按钮点击
- (void)sendVerificationCode:(UIButton *)sender {
    
    [self.view endEditing:YES];
    NSString *url  = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=send_code"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = self.phoneTX.text;
    if (self.phoneTX.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请输入手机号"];
    }else if (![HZQRegexTestter validatePhone:self.phoneTX.text]) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请输入正确的手机号"];
    }else {
        
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"已注册"]) {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"该手机号已被使用,请更换手机号"];
            }else if ([responseObject[@"msg"] isEqualToString:@"信息发送中"]) {
                sendLeftTime = 120;
                [self.sendVerificationCodeButton setEnabled:NO];
                sendTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"信息发送成功,请查收"];
            }else {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"验证码发送失败,请稍后再试"];
            }
            BFLog(@"%@", responseObject);
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"网络异常"];
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
        [self.sendVerificationCodeButton setTitle:@"验证码" forState:UIControlStateNormal];
        [sendTimer invalidate];
        sendTimer = nil;
    } else {
        
        [self.sendVerificationCodeButton setEnabled:NO];
        [self.sendVerificationCodeButton setTitle:[NSString stringWithFormat:@"%ds",sendLeftTime] forState:UIControlStateNormal];
    }
}


#pragma mark -- 创建导航
- (void)setUpNavigationBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:BF_ScaleFont(18)],NSForegroundColorAttributeName:BFColor(0x0E61C0)}];
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.bgImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.bgImageView.image = [UIImage imageNamed:@"beijin1.jpg"];
    self.bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgImageView];
    
    //添加返回按钮
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backToHome) image:@"back" highImage:@"back"];
    self.navigationItem.leftBarButtonItem = back;
}


#pragma mark -- 返回按钮
- (void)backToHome {
    _block(nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark --UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.phoneTX resignFirstResponder];
    [self.verificationCodeTX resignFirstResponder];
    return YES;
}



@end
