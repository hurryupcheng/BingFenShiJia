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
- (void)userRigisterWithBFPassWordView:(BFPassWordView *)BFPassWordView {
   [self.view endEditing:YES];
    
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=login"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = BFPassWordView.phoneTX.text;
    parameter[@"pass"] = [MyMD5 md5:BFPassWordView.firstPasswordTX.text];
    
    [BFHttpTool POST:url params:parameter success:^(id responseObject) {

        BFUserInfo *userInfo = [BFUserInfo parse:responseObject];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserInfo"];
        BFLog(@"responseObject%@",userInfo);
        [BFPassWordView.phoneTX.text writeToFile:self.phonePath atomically:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络问题"];
        BFLog(@"error%@",error);
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
