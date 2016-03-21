//
//  LogViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define ThirdLoginButtonHeight (CGRectGetMaxY(quickLoginLabel.frame)-BF_ScaleHeight(25))
#define ThirdLoginButtonWidth ((ScreenWidth-CGRectGetMaxX(quickLoginLabel.frame)-BF_ScaleWidth(140))/4)
#define Magin   (BF_ScaleWidth(6))
#import "Header.h"
#import "TextFieldLog.h"
#import "ZCViewController.h"
#import "LogViewController.h"
#import "BFMobileNumber.h"
#import "MyMD5.h"

@interface LogViewController ()<UITextFieldDelegate>{
    __block int         leftTime;
    __block NSTimer     *timer;
}
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**背景图片*/
@property (nonatomic, strong) NSString *str;
/**手机输入框*/
@property (nonatomic, strong) UITextField *phoneTX;
/**密码输入框*/
@property (nonatomic, strong) UITextField *passwordTX;
/**手机号保存路径*/
@property (nonatomic, strong) NSString *phonePath;
/**密码保存路径*/
@property (nonatomic, strong) NSString *passwordPath;
/**登录按钮*/
@property (nonatomic, strong) UIButton *loginButton;
@end

@implementation LogViewController


- (NSString *)phonePath {
    if (!_phonePath) {
        _phonePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"phone.plist"];
    }
    return _phonePath;
}

- (NSString *)passwordPath {
    if (!_passwordPath) {
        _passwordPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"password.plist"];
    }
    return _passwordPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    
    
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.bgImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.bgImageView.image = [UIImage imageNamed:@"beijin1.jpg"];
    self.bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgImageView];
    
    [self initWithView];
}

- (void)initWithView{

    self.phoneTX = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(60), BF_ScaleHeight(150), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(35)) image:@"technician" placeholder:@"手机号"];
    self.phoneTX.text = [[NSString alloc] initWithContentsOfFile:self.phonePath];
    //self.phoneTX.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTX.delegate = self;
    self.phoneTX.returnKeyType = UIReturnKeyNext;
    [self.bgImageView addSubview:self.phoneTX];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.phoneTX.frame), ScreenWidth-BF_ScaleWidth(120), 1)];
    line1.backgroundColor = BFColor(0xd0d0d0);
    [self.bgImageView addSubview:line1];
    
    self.passwordTX = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(line1.frame)+BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(35)) image:@"password" placeholder:@"密码"];
    self.passwordTX.text = [[NSString alloc] initWithContentsOfFile:self.passwordPath];
    self.passwordTX.delegate = self;
    self.passwordTX.returnKeyType = UIReturnKeyDone;
    self.passwordTX.secureTextEntry = YES;
    [self.bgImageView addSubview:self.passwordTX];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.passwordTX.frame), ScreenWidth-BF_ScaleWidth(120), 0.5)];
    line2.backgroundColor = BFColor(0xd0d0d0);
    [self.bgImageView addSubview:line2];
    
    
    UIButton *loginButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(line2.frame)+BF_ScaleHeight(20), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(36)) title:@"登录" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xffffff)];
    self.loginButton = loginButton;
    
    loginButton.backgroundColor = BFColor(0xFD8727);
    loginButton.layer.cornerRadius = BF_ScaleHeight(18);
    loginButton.layer.masksToBounds = YES;
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:loginButton];
    
    
    
    UIButton *registerButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(loginButton.frame)+BF_ScaleHeight(18), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(36)) title:@"立即注册 享新客专属折扣" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xFD8727)];
    registerButton.layer.cornerRadius = BF_ScaleHeight(18);
    registerButton.layer.masksToBounds = YES;
    registerButton.layer.borderColor = BFColor(0xFD8727).CGColor;
    registerButton.layer.borderWidth = BF_ScaleWidth(1);
    registerButton.backgroundColor = BFColor(0xffffff);
    [registerButton addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:registerButton];
    
    
    UIButton *forgetButton = [UIButton buttonWithFrame:CGRectMake(ScreenWidth-BF_ScaleWidth(140), CGRectGetMaxY(registerButton.frame)+BF_ScaleHeight(18), BF_ScaleWidth(80), BF_ScaleHeight(10)) title:@"忘记密码?" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0x7B715C)];
    [forgetButton addTarget:self action:@selector(forgetPassWord:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:forgetButton];
    
    
    UILabel *quickLoginLabel = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.view.frame)-BF_ScaleHeight(50), 0, 0) font:BF_ScaleFont(14) textColor:BFColor(0x7B715C) text:@"快捷登录:"];
    [self.bgImageView addSubview:quickLoginLabel];
    //quickLoginLabel.backgroundColor = [UIColor redColor];
    [quickLoginLabel sizeToFit];
    
    UIButton *qqLogin = [self setupBtnWithFrame:CGRectMake(CGRectGetMaxX(quickLoginLabel.frame)+Magin, CGRectGetMaxY(quickLoginLabel.frame)-BF_ScaleHeight(25), BF_ScaleHeight(25), BF_ScaleHeight(25)) image:@"QQ_Login" type:BFThirdLoginTypeQQ];
    [self.bgImageView addSubview:qqLogin];
    
    
    UIButton *alipayLogin = [self setupBtnWithFrame:CGRectMake(CGRectGetMaxX(qqLogin.frame)+Magin, CGRectGetMaxY(quickLoginLabel.frame)-BF_ScaleHeight(25), BF_ScaleHeight(25), BF_ScaleHeight(25)) image:@"QQ_Login" type:BFThirdLoginTypeAlipay];
    [self.bgImageView addSubview:alipayLogin];
    
    UIButton *sinaLogin = [self setupBtnWithFrame:CGRectMake(CGRectGetMaxX(alipayLogin.frame)+Magin, CGRectGetMaxY(quickLoginLabel.frame)-BF_ScaleHeight(25), BF_ScaleHeight(25), BF_ScaleHeight(25)) image:@"weibo_Login" type:BFThirdLoginTypeSina];
    [self.bgImageView addSubview:sinaLogin];
    
    UIButton *wechatLogin = [self setupBtnWithFrame:CGRectMake(CGRectGetMaxX(sinaLogin.frame)+Magin, CGRectGetMaxY(quickLoginLabel.frame)-BF_ScaleHeight(25), BF_ScaleHeight(25), BF_ScaleHeight(25)) image:@"weixin_Login" type:BFThirdLoginTypeWechat];
    [self.bgImageView addSubview:wechatLogin];
}


/**
 *创建button
 */
- (UIButton *)setupBtnWithFrame:(CGRect)frame image:(NSString *)image type:(BFThirdLoginType)type {
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = frame;
    button.tag = type;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
#pragma mark -- 第三方登录点击
//
- (void)thirdLogin:(UIButton *)sender {
    switch (sender.tag) {
        case BFThirdLoginTypeQQ:
            BFLog(@"BFThirdLoginTypeQQ");
            break;
        case BFThirdLoginTypeAlipay:
            BFLog(@"BFThirdLoginTypeAlipay");
            break;
        case BFThirdLoginTypeSina:
            BFLog(@"BFThirdLoginTypeSina");
            break;
        case BFThirdLoginTypeWechat:
            BFLog(@"BFThirdLoginTypeWechat");
            break;
        default:
            break;
    }
}

- (void)forgetPassWord:(UIButton *)sender {
    BFLog(@"忘记密码");
}

//  登陆点击按钮事件
- (void)login{
    leftTime = 2;
    [self.loginButton setEnabled:NO];
    [self.loginButton setBackgroundColor:BFColor(0xD5D8D1)];
    
    if(timer)
        [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
    if ([self.phoneTX.text isEqualToString:@"" ] || [self.passwordTX.text isEqualToString:@""]) {
//        UIAlertView *aler = [[UIAlertView alloc]
//                             initWithTitle:@"温馨提示" message:@"手机号或密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [aler show];
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"手机号或密码不能为空"];
        
    } else if ( ![BFMobileNumber isMobileNumber:self.phoneTX.text]) {
//            UIAlertView *alers = [[UIAlertView alloc]
//                                  initWithTitle:@"温馨提示" message:@"请输入有效的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alers show];
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"请输入有效的手机号码"];
    
    }else if (self.passwordTX.text.length < 6 || self.passwordTX.text.length >20){
//        UIAlertView *aler = [[UIAlertView alloc]
//                             initWithTitle:@"温馨提示" message:@"请输入6~15位长度密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [aler show];
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"请输入6~20位长度密码"];

    }else {
        
        NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=login"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"phone"] = self.phoneTX.text;
        parameter[@"pass"] = [MyMD5 md5:self.passwordTX.text];
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"responseObject%@",responseObject);
            BFUserInfo *userInfo = [BFUserInfo parse:responseObject];
            if ([userInfo.msg isEqualToString:@"登录失败"]) {
                [BFProgressHUD MBProgressFromView:self.view andLabelText:@"账号或者密码错误"];
                return ;
            }
            [BFProgressHUD MBProgressFromWindowWithLabelText:@"登录成功，正在跳转..." dispatch_get_main_queue:^{
                
                
                
                [self.phoneTX.text writeToFile:self.phonePath atomically:YES];
                [self.passwordTX.text writeToFile:self.passwordPath atomically:YES];
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserInfo"];
                BFLog(@"responseObject%@",userInfo);
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        } failure:^(NSError *error) {
            BFLog(@"error%@",error);
        }];
    }
}

- (void)registerUser{

    ZCViewController *zc = [[ZCViewController alloc]init];
    [self.navigationController pushViewController:zc animated:YES];
}

- (void)timerAction {
    leftTime--;
    if(leftTime<=0)
    {
        [self.loginButton setEnabled:YES];
        self.loginButton.backgroundColor = BFColor(0xFD8727);
    } else
    {
        
        [self.loginButton setEnabled:NO];
        [self.loginButton setBackgroundColor:BFColor(0xD5D8D1)];
    }

}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL ret = NO;
    if (textField == self.phoneTX) {
        [self.passwordTX becomeFirstResponder];
    }else {
        [self.passwordTX resignFirstResponder];
    }
    return ret;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
   self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
