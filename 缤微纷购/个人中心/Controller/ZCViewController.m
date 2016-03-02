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

@property (nonatomic,retain)UIImageView *groubImage;

@end

@implementation ZCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.groubImage = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.groubImage.image = [UIImage imageNamed:@"beijin1.jpg"];
    self.groubImage.userInteractionEnabled = YES;
    [self.view addSubview:self.groubImage];
    
    [self initWithView];
}

- (void)initWithView{

    TextFieldLog *zc = [[TextFieldLog alloc]initWithFrame:CGRectMake(60, CGRectGetMinY(self.view.frame)+70, kScreenWidth-120, 30) imageV:@"1" placeholder:@"手机号" string:@""];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(65, CGRectGetMaxY(zc.frame)+20, kScreenWidth-130, 30)];
    
    button.layer.borderColor = [UIColor orangeColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 15;
    button.layer.masksToBounds = YES;
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [self.groubImage addSubview:zc];
    [self.groubImage addSubview:button];
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
