//
//  PersonalViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ZCViewController.h"
#import "LogViewController.h"
#import "MyMoneyViewController.h"
#import "MyorderViewController.h"
#import "MyViewController.h"
#import "JFView.h"
#import "ViewController.h"
#import "Header.h"
#import "PersonalViewController.h"

@interface PersonalViewController ()

@property (nonatomic,retain)UIView *backgroundView;
@property (nonatomic,retain)UIImageView *groundView;
@property (nonatomic,retain)UIButton *picImageBut;

@property (nonatomic,retain)NSArray *arr;

@property (nonatomic)BOOL denglu;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.groundView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.groundView.image = [UIImage imageNamed:@"bg.jpg"];
    self.groundView.userInteractionEnabled = YES;
    [self.view addSubview:self.groundView];
    
    self.denglu = NO;
    
    [self initWithButton];
    [self initWithPic];
    [self initWithInstall];
}


- (void)initWithButton{
    self.arr = @[@"我的钱包",@"我的订单",@"我的拼团",@"优惠卷",@"我的资料",@"我的特权"];

    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, button_y, kScreenWidth, button_y)];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    [self.groundView addSubview:self.backgroundView];
    
    for (int i = 0; i < 6; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((i%3)+(i%3)* (button_x1),(i/3)*-1+(i/3)*((button_y)/2), button_x1+2, (button_y)/2);
//        button.backgroundColor = [UIColor redColor];
        
        button.tag = i;
        button.layer.borderWidth = 1;
        button.layer.borderColor = rgb(245, 245, 245, 1.0).CGColor;
        [button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat x = button.frame.size.width-50;
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(25, 20, x ,x)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"iicon0%d.png",i+1]];
//        image.backgroundColor = [UIColor redColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame)+10, button.frame.size.width, 30)];
//        label.backgroundColor = [UIColor greenColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.arr[i];
        label.font = [UIFont systemFontOfSize:CGFloatY(14)];
    
        [button addSubview:label];
        [button addSubview:image];
        [self.backgroundView addSubview:button];
        
    }

}

#pragma  mark 头像登陆注册
- (void)initWithPic{
    
    self.picImageBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.picImageBut.frame = CGRectMake(kScreenWidth/2-(((kScreenWidth/4)-10)/2), CGRectGetMinY(self.backgroundView.frame)-100-(kScreenWidth/4)-10, (kScreenWidth/4)-10, kScreenWidth/4-10);
    [self.picImageBut addTarget:self action:@selector(picimage) forControlEvents:UIControlEventTouchUpInside];
    [self.picImageBut setBackgroundImage:[UIImage imageNamed:@"touxiang1.png"] forState:UIControlStateNormal];

    if (self.denglu == NO) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-((kScreenWidth/3)/2), CGRectGetMinY(self.backgroundView.frame)-110, kScreenWidth/3, 25)];
        label.userInteractionEnabled = YES;
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        label.layer.borderWidth = 1;
        label.layer.borderColor = [UIColor grayColor].CGColor;
   
        NSArray *arr = @[@"登陆",@"注册"];
        for (int i = 0; i < 2; i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth/3)/2*i, 0, (kScreenWidth/3)/2, 25)];
            
            [button setTitle:arr[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.tag = 100+i;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(log:) forControlEvents:UIControlEventTouchUpInside];

            [label addSubview:button];
        }
        [self.groundView addSubview:label];
        
        UILabel *black = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/3)/2, 5, 1, 15)];
        black.backgroundColor = [UIColor grayColor];
        [label addSubview:black];
        
    }else{
        
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.backgroundView.frame)-110, kScreenWidth, 30)];
    nameLabel.text = [NSString stringWithFormat:@"ID:%@      推荐人:%@",@"8",@"一号"];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.groundView addSubview:nameLabel];
}
    
    JFView *jf = [[JFView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.backgroundView.frame)-60, kScreenWidth, 60) jifen:@"100" yuer:[NSString stringWithFormat:@"¥ %.2f",10.00] kehu:@"100"];
    
    [self.groundView addSubview:jf];
    
    [self.groundView addSubview:self.picImageBut];

}

#pragma  mark 设置按钮
- (void)initWithInstall{
 
    UIButton *install = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-60, 30, 20, 20)];
    
    [install setBackgroundImage:[UIImage imageNamed:@"iconfont-setting.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:install];

}

#pragma  mark  登陆注册按钮点击事件
- (void)log:(UIButton *)button{
    switch (button.tag) {
        case 100:{
            NSLog(@"登陆");
            LogViewController *log = [[LogViewController alloc]init];
            [self.navigationController pushViewController:log animated:YES];
        }
            break;
            case 101:
        {
            NSLog(@"注册");
            ZCViewController *zc = [[ZCViewController alloc]init];
            [self.navigationController pushViewController:zc animated:YES];
        }
            break;
        default:
            break;
    }

}

- (void)selectedButton:(UIButton *)button{

    switch (button.tag) {
        case 0:{
            MyMoneyViewController *myMoney = [[MyMoneyViewController alloc]init];
            [self.navigationController pushViewController:myMoney animated:YES];
            break;
        }case 1:{
            MyorderViewController *myorder = [[MyorderViewController alloc]init];
            myorder.titles = self.arr[1];
            [self.navigationController pushViewController:myorder animated:YES];
            break;
        }case 2:{
           
            break;
        }case 3:{

            break;
        }case 4:{
            
            MyViewController *myVC = [[MyViewController alloc]init];
      [self.navigationController pushViewController:myVC animated:NO];
            
            break;
        }case 5:{
            UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"暂未开放,尽请期待!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            break;
            
        }default:
            break;
    }

}

// 更换头像
- (void)picimage{
    NSLog(@"");
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
