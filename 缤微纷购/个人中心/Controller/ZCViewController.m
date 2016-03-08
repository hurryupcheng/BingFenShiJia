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

@interface ZCViewController ()
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**手机号输入框*/
@property (nonatomic, strong) UITextField *phoneTX;
/**验证码按钮*/
@property (nonatomic, strong) UIButton *sendVerificationCodeButton;
@end

@implementation ZCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.title = @"注册";
    
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

    self.phoneTX = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(60), BF_ScaleHeight(150), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(35)) image:@"phone" placeholder:@"手机号"];
    self.phoneTX.keyboardType = UIKeyboardTypeNumberPad;
    [self.bgImageView addSubview:self.phoneTX];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.phoneTX.frame), ScreenWidth-BF_ScaleWidth(120), 1)];
    line1.backgroundColor = BFColor(0xd0d0d0);
    [self.bgImageView addSubview:line1];
    
    UIButton *sendVerificationCodeButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(line1.frame)+BF_ScaleHeight(20), ScreenWidth-BF_ScaleWidth(120), BF_ScaleHeight(36)) title:@"获取验证码" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xFD8727)];
    //sendVerificationCodeButton.backgroundColor = [UIColor orangeColor];
    sendVerificationCodeButton.layer.cornerRadius = BF_ScaleHeight(18);
    sendVerificationCodeButton.layer.masksToBounds = YES;
    sendVerificationCodeButton.layer.borderColor = BFColor(0xFD8727).CGColor;
    sendVerificationCodeButton.layer.borderWidth = BF_ScaleWidth(1);
    //sendVerificationCodeButton.backgroundColor = BFColor(0xffffff);
    [sendVerificationCodeButton addTarget:self action:@selector(sendVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:sendVerificationCodeButton];

}

#pragma mark -- 发送验证码
- (void)sendVerificationCode {
    BFLog(@"点击发送验证码");
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
