//
//  LogViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define ThirdLoginButtonHeight (CGRectGetMaxY(quickLoginLabel.frame)-BF_ScaleHeight(25))
#define ThirdLoginButtonWidth ((ScreenWidth-CGRectGetMaxX(quickLoginLabel.frame)-BF_ScaleWidth(140))/4)
#define Magin        (BF_ScaleWidth(0))
#define ThirdLoginWH  BF_ScaleHeight(50)

#import <ShareSDK/ShareSDK.h>
#import "Header.h"
#import "TextFieldLog.h"
#import "ZCViewController.h"
#import "LogViewController.h"
#import "BFMobileNumber.h"
#import "MyMD5.h"
#import "BFForgetPasswordController.h"
#import "BFAccountBindingController.h"

@interface LogViewController ()<UITextFieldDelegate>
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
/**登录按钮*/
@property (nonatomic, strong) UIButton *loginButton;
@end

@implementation LogViewController

#pragma mark --懒加载

- (NSString *)phonePath {
    if (!_phonePath) {
        _phonePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"phone.plist"];
    }
    return _phonePath;
}




#pragma mark --viewDidLoad
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
    //创建view
    [self initWithView];
}


- (void)clean {
    self.phoneTX.text = [[NSString alloc] initWithContentsOfFile:self.phonePath];
}



#pragma mark --创建view®
- (void)initWithView{

    self.phoneTX = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(60), BF_ScaleHeight(150), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(35)) image:@"technician" placeholder:@"手机号"];
    self.phoneTX.text = [[NSString alloc] initWithContentsOfFile:self.phonePath];
    //self.phoneTX.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTX.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTX.delegate = self;
    self.phoneTX.returnKeyType = UIReturnKeyNext;
    [self.bgImageView addSubview:self.phoneTX];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.phoneTX.frame), ScreenWidth-BF_ScaleWidth(120), 1)];
    line1.backgroundColor = BFColor(0xd0d0d0);
    [self.bgImageView addSubview:line1];
    
    self.passwordTX = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(line1.frame)+BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(35)) image:@"password" placeholder:@"密码"];
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
    
    
    UILabel *quickLoginLabel = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(55), CGRectGetMaxY(self.view.frame)-BF_ScaleHeight(75), BF_ScaleWidth(70), ThirdLoginWH) font:BF_ScaleFont(14) textColor:BFColor(0x7B715C) text:@"快捷登录:"];
    [self.bgImageView addSubview:quickLoginLabel];
    //quickLoginLabel.backgroundColor = [UIColor redColor];
    
    
    UIButton *qqLogin = [self setupBtnWithFrame:CGRectMake(CGRectGetMaxX(quickLoginLabel.frame)+Magin, quickLoginLabel.y, ThirdLoginWH, ThirdLoginWH) image:@"third_login_qq" type:BFThirdLoginTypeQQ];
    [self.bgImageView addSubview:qqLogin];
    
    
//    UIButton *alipayLogin = [self setupBtnWithFrame:CGRectMake(CGRectGetMaxX(qqLogin.frame)+Magin, quickLoginLabel.y, ThirdLoginWH, ThirdLoginWH) image:@"third_login_alipay" type:BFThirdLoginTypeAlipay];
//    [self.bgImageView addSubview:alipayLogin];
    
    UIButton *sinaLogin = [self setupBtnWithFrame:CGRectMake(CGRectGetMaxX(qqLogin.frame)+Magin, quickLoginLabel.y, ThirdLoginWH, ThirdLoginWH) image:@"third_login_sina" type:BFThirdLoginTypeSina];
    [self.bgImageView addSubview:sinaLogin];
    
    UIButton *wechatLogin = [self setupBtnWithFrame:CGRectMake(CGRectGetMaxX(sinaLogin.frame)+Magin, quickLoginLabel.y, ThirdLoginWH, ThirdLoginWH) image:@"third_login_wechat" type:BFThirdLoginTypeWechat];
    [self.bgImageView addSubview:wechatLogin];
}


/**
 *创建button
 */
- (UIButton *)setupBtnWithFrame:(CGRect)frame image:(NSString *)image type:(BFThirdLoginType)type {
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = frame;
    button.tag = type;
    //button.backgroundColor = BFColor(0x4da800);
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
#pragma mark -- 第三方登录点击
- (void)thirdLogin:(UIButton *)sender {
    //音效
    [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    switch (sender.tag) {
        case BFThirdLoginTypeQQ:{
            BFLog(@"BFThirdLoginTypeQQ");
            [self thirdPartyLogin:ShareTypeQQSpace];
            break;
        }case BFThirdLoginTypeSina:{
            [self thirdPartyLogin:ShareTypeSinaWeibo];
            BFLog(@"BFThirdLoginTypeSina");
            break;
        } case BFThirdLoginTypeWechat:{
            BFLog(@"BFThirdLoginTypeWechat");
            [self thirdPartyLogin:ShareTypeWeixiSession];
            break;
        }
    }
}


#pragma mark --第三方登录
- (void)thirdPartyLogin:(ShareType)shareType {
    
    //登录之前取消上次
    [ShareSDK cancelAuthWithType:shareType];
    [ShareSDK getUserInfoWithType:shareType authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
       if (result)
       {
           NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=oauth"];
           NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
           if (shareType == ShareTypeQQSpace) {
               parameter[@"type"] = @"1";
               parameter[@"openid"] = [userInfo uid];
           }else if (shareType == ShareTypeSinaWeibo) {
               parameter[@"type"] = @"2";
               parameter[@"openid"] = [userInfo uid];
           }else if (shareType == ShareTypeWeixiSession) {
               parameter[@"type"] = @"0";
               parameter[@"openid"] = [userInfo sourceData][@"unionid"];
           }
           parameter[@"nickname"] = [userInfo nickname];
           //parameter[@"openid"] = [userInfo uid];
           parameter[@"ico"] = [userInfo profileImage];
           //parameter[@"unionid"] = [userInfo sourceData][@"unionid"];
           [BFProgressHUD MBProgressWithLabelText:@"正在登陆..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
                   
               [BFHttpTool POST:url params:parameter success:^(id responseObject) {
                   BFLog(@"%@,,%@", responseObject, parameter);
                   if ([responseObject[@"status"] isEqualToString:@"0"]) {
                       [hud hideAnimated:YES];
                       //如果没有绑定手机号，跳转到绑定手机号页面
                       BFAccountBindingController *accountVC = [[BFAccountBindingController alloc] init];
                       accountVC.parameter = parameter;
                       accountVC.block = ^(BFUserInfo *userInfo) {
                           if (userInfo == nil) {
                               [BFProgressHUD MBProgressFromView:self.view wrongLabelText:@"登录失败"];
                           }else {
                               [BFProgressHUD MBProgressWithLabelText:@"手机号绑定成功,正在跳转..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
                                   [self tabBarBadge:userInfo.ID];
                                   NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
                                   [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserInfo"];
                                   [hud hideAnimated:YES];
                                   [BFProgressHUD MBProgressOnlyWithLabelText:@"客官,欢迎光临!"];
                                   [self.navigationController popViewControllerAnimated:YES];
                               }];
                           }
                       };
                       UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:accountVC];
                       [self presentViewController:navigationController animated:YES completion:nil];
                   }else if ([responseObject[@"status"] isEqualToString:@"1"]) {
                       [hud hideAnimated:YES];
                       [BFProgressHUD MBProgressWithLabelText:@"登录成功,正在跳转..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
                           BFUserInfo *userInfo = [BFUserInfo parse:responseObject];
                           [self tabBarBadge:userInfo.ID];
                           NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
                           [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserInfo"];
                           [hud hideAnimated:YES];
                           [BFProgressHUD MBProgressOnlyWithLabelText:@"客官,欢迎再次光临!"];
                           [self.navigationController popViewControllerAnimated:YES];
                       }];
                   }
                   
               } failure:^(NSError *error) {
                   [hud hideAnimated:YES];
                   [BFProgressHUD MBProgressFromWindowWithLabelText:@"网络异常"];
                   BFLog(@"%@", error);
               }];
               BFLog(@" ---- %@,%@,%@,%@,%@",[userInfo nickname],[userInfo uid],[userInfo nickname],[userInfo profileImage],[userInfo sourceData][@"unionid"]);
            }];
           }else{
               [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"登录失败"];
               NSLog(@"授权失败!error code == %ld, error code == %@", (long)[error errorCode], [error errorDescription]);
           }
       }];
    

}

#pragma mark --忘记密码
- (void)forgetPassWord:(UIButton *)sender {
    //音效
    [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    BFForgetPasswordController *forgetPasswordVC = [[BFForgetPasswordController alloc] init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
    BFLog(@"忘记密码");
}

#pragma mark --登录按钮点击事件
- (void)login{
    //音效
    [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    [self.view endEditing:YES];
    
    
    if ([self.phoneTX.text isEqualToString:@"" ] || [self.passwordTX.text isEqualToString:@""]) {

        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"手机号或密码不能为空"];
        
    } else if ( ![BFMobileNumber isMobileNumber:self.phoneTX.text]) {

        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"请输入有效的手机号码"];
    
    }else if (self.passwordTX.text.length < 6 || self.passwordTX.text.length >20){

        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"请输入6~20位长度密码"];

    }else {
        
        NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=login"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"phone"] = self.phoneTX.text;
        parameter[@"pass"] = [MyMD5 md5:self.passwordTX.text];
        
        [BFProgressHUD MBProgressWithLabelText:@"正在登陆..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
            [BFHttpTool POST:url params:parameter success:^(id responseObject) {
                BFLog(@"responseObject:%@",responseObject);
                BFUserInfo *userInfo = [BFUserInfo parse:responseObject];
                if ([userInfo.msg isEqualToString:@"登录成功"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressWithLabelText:@"登录成功,正在跳转..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
                        
                        [self.phoneTX.text writeToFile:self.phonePath atomically:YES];
                        
                        [self tabBarBadge:userInfo.ID];
                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
                        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserInfo"];
                        //BFLog(@"responseObject%@",userInfo.user_icon);
                        [hud hideAnimated:YES];
                        [self.navigationController popViewControllerAnimated:YES];
                        [BFProgressHUD MBProgressOnlyWithLabelText:@"客官,欢迎再次光临!"];
                    }];
                }else {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"账号或者密码错误"];
                }
                            } failure:^(NSError *error) {
                [BFProgressHUD MBProgressFromView:self.navigationController.view  andLabelText:@"网络问题"];
                [hud hideAnimated:YES];
                BFLog(@"error%@",error);
            }];

        }];
        
    }
}

#pragma mark -- 登录后改变购物车数值
- (void)tabBarBadge:(NSString *)userID {
    [[CXArchiveShopManager sharedInstance]initWithUserID:userID ShopItem:nil];
    NSArray *array = [[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop];
    BFLog(@"---%lu", (unsigned long)array.count);
    UITabBarController *tabBar = [self.tabBarController viewControllers][1];
    if (array.count == 0) {
        tabBar.tabBarItem.badgeValue = nil;
    }else {
        tabBar.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
    }
}

#pragma mark --注册按钮点击事件
- (void)registerUser{
    //音效
    [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    ZCViewController *zc = [[ZCViewController alloc]init];
    [self.navigationController pushViewController:zc animated:YES];
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark --UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL ret = NO;
    if (textField == self.phoneTX) {
        [self.passwordTX becomeFirstResponder];
    }else {
        [self.passwordTX resignFirstResponder];
    }
    return ret;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.phoneTX) {
        self.passwordTX.text = @"";
    }
}

#pragma mark --viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
   self.tabBarController.tabBar.hidden = YES;
    
}
#pragma mark --viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}




@end
