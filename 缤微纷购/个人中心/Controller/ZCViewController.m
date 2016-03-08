//
//  ZCViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "TextFieldLog.h"
#import "ZCViewController.h"
#import "BFPassWordView.h"
#import "BFMobileNumber.h"
#import "MyMD5.h"
#import "BFRegistModel.h"
#import "BFUserInfo.h"

@interface ZCViewController ()<RegisterDelegate>{
    __block int         leftTime;
    __block NSTimer     *timer;
}
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**密码页面*/
@property (nonatomic, strong) BFPassWordView *bgView;
///**获取验证码*/
@property (nonatomic, strong) UIButton *sendVerificationCodeButton;
@end

@implementation ZCViewController
- (UIButton *)sendVerificationCodeButton {
    if (!_sendVerificationCodeButton) {
        _sendVerificationCodeButton =[self.bgView viewWithTag:1000];
    }
    return _sendVerificationCodeButton;
}

/**密码页面*/
- (UIView *)bgView {
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
    self.navigationController.navigationBar.translucent = YES;
    self.title = @"注册";
    
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.bgImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.bgImageView.image = [UIImage imageNamed:@"beijin1.jpg"];
    self.bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgImageView];
    [self bgView];
    //[self initWithView];
    

}

- (void)initWithView{

//    self.phoneTX = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(60), BF_ScaleHeight(150), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(35)) image:@"phone" placeholder:@"手机号"];
//    self.phoneTX.returnKeyType = UIReturnKeyDone;
//    self.phoneTX.keyboardType = UIKeyboardTypeNumberPad;
//    [self.bgImageView addSubview:self.phoneTX];
//    
//    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.phoneTX.frame), ScreenWidth-BF_ScaleWidth(120), 1)];
//    line1.backgroundColor = BFColor(0xd0d0d0);
//    [self.bgImageView addSubview:line1];
//    
//     self.sendVerificationCodeButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(line1.frame)+BF_ScaleHeight(20), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(36)) title:@"获取验证码" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xFD8727)];
//    //sendVerificationCodeButton.backgroundColor = [UIColor orangeColor];
//    self.sendVerificationCodeButton.layer.cornerRadius = BF_ScaleHeight(18);
//    self.sendVerificationCodeButton.layer.masksToBounds = YES;
//    self.sendVerificationCodeButton.layer.borderColor = BFColor(0xFD8727).CGColor;
//    self.sendVerificationCodeButton.layer.borderWidth = BF_ScaleWidth(1);
//    //sendVerificationCodeButton.backgroundColor = BFColor(0xffffff);
//    [self.sendVerificationCodeButton addTarget:self action:@selector(sendVerificationCode) forControlEvents:UIControlEventTouchUpInside];
//    [self.bgImageView addSubview:self.sendVerificationCodeButton];

}

#pragma mark -- 发送验证码
//- (void)sendVerificationCode {
//    [self.view endEditing:YES];
//    BFLog(@"点击发送验证码");
//    if (![BFMobileNumber isMobileNumber:self.phoneTX.text]) {
////        UIAlertView *aler = [[UIAlertView alloc]
////                             initWithTitle:@"温馨提示" message:@"请输入有效的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
////        [aler show];
//        [BFProgressHUD MBProgressOnlywithLabelText:@"请输入有效的手机号"];
//    }else {
//        self.sendVerificationCodeButton.hidden = YES;
//        self.bgView.hidden = NO;
//    }
//}

- (void)sendVerificationCodeBFPassWordView:(BFPassWordView *)BFPassWordView button:(UIButton *)button {
    
    [self.view endEditing:YES];
    BFLog(@"点击发送验证码");
    
}


#pragma mark --注册
- (void)userRigisterWithBFPassWordView:(BFPassWordView *)BFPassWordView {
   [self.view endEditing:YES];
    
    NSString *firstPW = [MyMD5 md5:BFPassWordView.firstPasswordTX.text];
    NSString *secondPW = [MyMD5 md5:BFPassWordView.secondPasswordTX.text];
    NSString *url = @"http://192.168.1.201/binfen/index.php?a=reg&m=Json";
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = BFPassWordView.phoneTX.text;
    parameter[@"pass"] = firstPW;
    // 1.创建请求管理者
    [BFHttpTool POST:url params:parameter success:^(id responseObject) {
        BFLog(@"responseObject%@,,,",responseObject);
        BFRegistModel *model = [BFRegistModel parse:responseObject];
        if ([model.msg isEqualToString:@"注册成功"]) {
            [BFProgressHUD MBProgressFromWindowWithLabelText:@"注册成功，正在跳转..." dispatch_get_main_queue:^{
                
                NSString *url = @"http://192.168.1.201/binfen/index.php?m=Json&a=login";
                NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
                parameter[@"phone"] = BFPassWordView.phoneTX.text;
                parameter[@"pass"] = firstPW;
                [BFHttpTool POST:url params:parameter success:^(id responseObject) {
                    
                    BFUserInfo *userInfo = [BFUserInfo parse:responseObject];
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserInfo"];
                    BFLog(@"responseObject%@",userInfo);
                    [self.navigationController popToRootViewControllerAnimated:YES];
                } failure:^(NSError *error) {
                    BFLog(@"error%@",error);
                }];

            }];
        }
    } failure:^(NSError *error) {
        BFLog(@"error%@",error);
    }];
}

/**点击空白收起键盘*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

@end
