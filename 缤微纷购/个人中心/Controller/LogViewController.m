//
//  LogViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "TextFieldLog.h"
#import "ZCViewController.h"
#import "LogViewController.h"

@interface LogViewController ()

@property (nonatomic,retain)UIImageView *groubImage;
@property (nonatomic,retain)NSString *str;
@property (nonatomic,retain)TextFieldLog *phone;
@property (nonatomic,retain)TextFieldLog *sectetul;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登陆";
    
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.groubImage = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.groubImage.image = [UIImage imageNamed:@"beijin1.jpg"];
    self.groubImage.userInteractionEnabled = YES;
    [self.view addSubview:self.groubImage];
    
    [self initWithView];
    [self initWithKJ];
}

- (void)initWithView{

    self.phone = [[TextFieldLog alloc]initWithFrame:CGRectMake(60, CGRectGetMinY(self.view.frame)+80, kScreenWidth-100, 30) imageV:@"1" placeholder:@"手机号" string:self.str];
    self.phone.text.keyboardType = UIKeyboardTypeNumberPad;
    
    self.sectetul = [[TextFieldLog alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(self.phone.frame)+30, kScreenWidth-100, 30) imageV:@"1" placeholder:@"密码" string:self.str];
    self.sectetul.text.secureTextEntry = YES;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(self.sectetul.frame)+25, kScreenWidth-140, 35)];
    
    button.layer.cornerRadius = 15;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"登陆" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(log) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *zhuce = [[UIButton alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(button.frame)+25, kScreenWidth-140, 35)];
    
    zhuce.layer.cornerRadius = 15;
    zhuce.layer.masksToBounds = YES;
    zhuce.layer.borderWidth = 1;
    zhuce.layer.borderColor = [UIColor orangeColor].CGColor;
    [zhuce setTitle:@"立即注册 享新客专属折扣" forState:UIControlStateNormal];
    [zhuce setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    zhuce.titleLabel.font = [UIFont systemFontOfSize:15];
    [zhuce addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *getback = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-150, CGRectGetMaxY(zhuce.frame)+10, 100, 30)];
    [getback setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [getback setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    getback.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.groubImage addSubview:self.phone];
    [self.groubImage addSubview:self.sectetul];
    [self.groubImage addSubview:button];
    [self.groubImage addSubview:zhuce];
    [self.groubImage addSubview:getback];
}

//  登陆点击按钮事件
- (void)log{
    
    if (self.phone.text.text.length <= 0 || self.sectetul.text.text.length <= 0) {
        UIAlertView *aler = [[UIAlertView alloc]
                             initWithTitle:@"温馨提示" message:@"手机号或密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        
    } else if (self.phone.text.text.length > 11 || self.phone.text.text.length < 11) {
            UIAlertView *alers = [[UIAlertView alloc]
                                  initWithTitle:@"温馨提示" message:@"手机号错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alers show];
            return;
    
    }else{
        UIAlertView *aler = [[UIAlertView alloc]
                             initWithTitle:@"温馨提示" message:@"登陆成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)zhuce{

    ZCViewController *zc = [[ZCViewController alloc]init];
    [self.navigationController pushViewController:zc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;

}

#pragma  mark 快速登录
- (void)initWithKJ{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(self.view.frame)-130, kScreenWidth/4, 30)];
    
    label.text = @"快捷登录:";
    label.textColor = [UIColor grayColor];
    
    for (int i = 0; i < 4; i++) {
        UIButton *three = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+30*i+(i*5), CGRectGetMaxY(self.view.frame)-130, 30, 30)];
        three.backgroundColor = [UIColor grayColor];
        [self.view addSubview:three];
    }
    
    [self.view addSubview:label];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
