//
//  ZCViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define VerificationCode  @"m=Json&a=send_code"

#import "Header.h"
#import "TextFieldLog.h"
#import "ZCViewController.h"
#import "BFPassWordView.h"
#import "BFMobileNumber.h"
#import "MyMD5.h"
#import "BFRegistModel.h"
#import "BFUserInfo.h"

@interface ZCViewController ()<RegisterDelegate>
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**密码页面*/
@property (nonatomic, strong) BFPassWordView *bgView;
///**获取验证码*/
@property (nonatomic, strong) UIButton *sendVerificationCodeButton;
/**手机号保存路径*/
@property (nonatomic, strong) NSString *phonePath;
@end

@implementation ZCViewController

- (NSString *)phonePath {
    if (!_phonePath) {
        _phonePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"phone.plist"];
    }
    return _phonePath;
}






/**密码页面*/
- (BFPassWordView *)bgView {
    if (!_bgView) {
        _bgView = [BFPassWordView new];
        _bgView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight) ;
        _bgView.delegate = self;
        //_bgView.backgroundColor = [UIColor blueColor];
        [self.bgImageView addSubview:_bgView];
    }
    return _bgView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.title = @"注册";
    
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.bgImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.bgImageView.image = [UIImage imageNamed:@"beijin1.jpg"];
    self.bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgImageView];
    //添加自定义的view

    [self bgView];
}




#pragma mark --注册按钮代理
- (void)userRigisterWithBFPassWordView:(BFPassWordView *)BFPassWordView{
   [self.view endEditing:YES];
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"友情提醒" message:WarningText preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"先去微信商城确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击");
    }];
    
    UIAlertAction *newAction = [UIAlertAction actionWithTitle:@"新用户注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self registAndBunding:BFPassWordView];
    }];
    
    UIAlertAction *oldAction = [UIAlertAction actionWithTitle:@"微信商城老客户绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self registAndBunding:BFPassWordView];
    }];
    
    
    [alertC addAction:cancleAction];
    [alertC addAction:newAction];
    [alertC addAction:oldAction];
    
    
//    UIAlertController *warningAC = [UIAlertController alertWithControllerTitle:@"友情提醒" controllerMessage:WarningText preferredStyle:UIAlertControllerStyleAlert cancleTitle:@"先去微信商城看看绑定没有" actionTitle:@"微信商城已经绑定手机号" style:UIAlertActionStyleDefault handler:^{
//            }];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)registAndBunding:(BFPassWordView *)BFPassWordView {
    NSString *firstPW = [MyMD5 md5:BFPassWordView.firstPasswordTX.text];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=add_user"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"type"] = @"3";
    parameter[@"openid"] = BFPassWordView.phoneTX.text;
    parameter[@"nickname"] = @"";
    parameter[@"ico"] = @"";
    parameter[@"tel"] = BFPassWordView.phoneTX.text;
    parameter[@"pass"] = firstPW;
    parameter[@"code"] = BFPassWordView.verificationCodeTX.text;
    // 1.创建请求管理者
    [BFProgressHUD MBProgressWithLabelText:@"正在注册..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"responseObject%@,,,%@",responseObject,parameter);
            //BFRegistModel *model = [BFRegistModel parse:responseObject];
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressWithLabelText:@"注册成功，正在跳转..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
                    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=login"];
                    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
                    parameter[@"phone"] = BFPassWordView.phoneTX.text;
                    parameter[@"pass"] = [MyMD5 md5:BFPassWordView.firstPasswordTX.text];
                    
                    [BFHttpTool POST:url params:parameter success:^(id responseObject) {
                        BFLog(@"responseObject%@,,%@",responseObject,parameter);
                        if ([responseObject[@"status"] isEqualToString:@"1"]) {
                            BFUserInfo *userInfo = [BFUserInfo parse:responseObject];
                            userInfo.loginType = @"3";
                            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
                            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserInfo"];
                            [BFPassWordView.phoneTX.text writeToFile:self.phonePath atomically:YES];
                            [hud hideAnimated:YES];
                            [BFProgressHUD MBProgressOnlyWithLabelText:@"客官,欢迎光临!"];
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }else {
                            [hud hideAnimated:YES];
                            [BFProgressHUD MBProgressFromView:self.view wrongLabelText:@"登录失败"];
                        }
                        
                    } failure:^(NSError *error) {
                        [hud hideAnimated:YES];
                        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络问题"];
                        BFLog(@"error%@",error);
                    }];
                    
                    
                }];
            }else if([responseObject[@"status"] isEqualToString:@"0"]){
                if ([responseObject[@"msg"] isEqualToString:@"验证码不对"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"验证码不正确"];
                } else if ([responseObject[@"msg"] isEqualToString:@"验证码过期"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"验证码过期"];
                }else if ([responseObject[@"msg"] isEqualToString:@"该帐号已注册"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressOnlyWithLabelText:@"该手机号已注册,请更换"];
                    BFPassWordView.verificationCodeTX.text = @"";
                }else if ([responseObject[@"msg"] isEqualToString:@"注册失败"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"注册失败"];
                }else {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"注册失败"];
                }
                
            }
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"网络异常"];
            BFLog(@"error%@",error);
        }];
    }];

}

/**点击空白收起键盘*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    //self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

@end
