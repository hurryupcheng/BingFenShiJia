//
//  PersonalViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ZCViewController.h"
#import "LogViewController.h"
#import "BFMyWalletController.h"
#import "JFView.h"
#import "ViewController.h"
#import "Header.h"
#import "BFPersonalCenterTopView.h"
#import "BFFunctionButtonView.h"
#import "PersonalViewController.h"
#import "BFSettingController.h"
#import "BFPersonInformationController.h"
#import "BFMyOrderController.h"
#import "BFMyIntegralController.h"
#import "BFMyCouponsController.h"
#import "BFMyAdvertisingExpenseController.h"

@interface PersonalViewController ()<FunctionButtonDelegate, BFPersonalCenterTopViewDelegate>
/**个人中心有阴影的界面*/
@property (nonatomic, strong) BFPersonalCenterTopView *topView;
/**个人中心6个功能按钮的界面*/
@property (nonatomic, strong) BFFunctionButtonView *functionView;

@property (nonatomic,retain)UIView *backgroundView;
@property (nonatomic,retain)UIImageView *groundView;
@property (nonatomic,retain)UIButton *picImageBut;

@property (nonatomic,retain)NSArray *arr;

@property (nonatomic)BOOL denglu;

@end

@implementation PersonalViewController

- (BFPersonalCenterTopView *)topView {
    if (!_topView) {
        _topView = [[BFPersonalCenterTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.42)];
        _topView.delegate = self;
    }
    return _topView;
}

- (BFFunctionButtonView *)functionView {
    if (!_functionView) {
        _functionView = [[BFFunctionButtonView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), ScreenWidth, ScreenHeight-self.topView.height-49)];
        _functionView.delegate = self;
    }
    return _functionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.groundView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.groundView.image = [UIImage imageNamed:@"bg.jpg"];
    self.groundView.userInteractionEnabled = YES;
    [self.view addSubview:self.groundView];
    
    self.denglu = NO;
    
    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.functionView];
    
//    //[self initWithButton];
//    [self initWithPic];
//    //[self initWithInstall];
}

#pragma mark -- 设置按钮代理点击
- (void)goToSettingInterface {
    self.navigationController.navigationBarHidden = NO;
    BFSettingController *settingVC = [BFSettingController new];
    [self.navigationController pushViewController:settingVC animated:YES];
    BFLog(@"点击了设置按钮");
}

#pragma mark -- 头像按钮代理点击
- (void)goToUserHeadInterface {
    self.navigationController.navigationBarHidden = NO;
    BFLog(@"点击了头像按钮");
}

#pragma mark -- 登录按钮代理点击
- (void)goToLoginInterface {
    self.navigationController.navigationBarHidden = NO;
    LogViewController *log = [[LogViewController alloc]init];
    [self.navigationController pushViewController:log animated:YES];
    BFLog(@"点击了登录按钮");
}

#pragma mark -- 注册按钮代理点击
- (void)goToRegisterInterface {
    self.navigationController.navigationBarHidden = NO;
    ZCViewController *zc = [[ZCViewController alloc]init];
    [self.navigationController pushViewController:zc animated:YES];
    BFLog(@"点击了注册按钮");
}

#pragma mark -- 注册按钮代理点击
- (void)goToPersonalCenterTopButtoInterfaceWithType:(BFPersonalCenterTopButtonType)type {
    self.navigationController.navigationBarHidden = NO;
    switch (type) {
        case BFPersonalCenterTopButtonTypeIntegral:{
            BFMyIntegralController *myIntegralVC = [BFMyIntegralController new];
            [self.navigationController pushViewController:myIntegralVC animated:YES];
            BFLog(@"点击了积分按钮");
            break;
        }
        case BFPersonalCenterTopButtonTypeAdvertisingExpense:{
            BFMyAdvertisingExpenseController *myAdvertisingExpense = [BFMyAdvertisingExpenseController new];
            [self.navigationController pushViewController:myAdvertisingExpense animated:YES];
            BFLog(@"点击了广告费按钮");
            break;
        }
        case BFPersonalCenterTopButtonTypeMyClient:{
            BFLog(@"点击了我的客户按钮");
            break;
        }
        default:
            break;
    }
}

#pragma mark -- 6个功能按钮的点击
- (void)chooseFunction:(BFFunctionButtonType)type {
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    switch (type) {
        case BFFunctionButtonTypeMyWallet:{
            BFMyWalletController *myWallet = [[BFMyWalletController alloc]init];
            [self.navigationController pushViewController:myWallet animated:YES];
            BFLog(@"我的钱包");
            break;
        }
        case BFFunctionButtonTypeMyOrder:{
            BFMyOrderController *myorder = [[BFMyOrderController alloc]init];
            [self.navigationController pushViewController:myorder animated:YES];

            BFLog(@"我的订单");
            break;
        }
        case BFFunctionButtonTypeMyGroupPurchase:
            BFLog(@"我的拼团");
            break;
        case BFFunctionButtonTypeMyCoupons:{
            BFMyCouponsController *myCoupons = [[BFMyCouponsController alloc]init];
            [self.navigationController pushViewController:myCoupons animated:YES];
            BFLog(@"我的优惠券");
            break;
        }
        case BFFunctionButtonTypeMyProFile:{
            
            BFPersonInformationController *personInfoVC = [[BFPersonInformationController alloc]init];
            [self.navigationController pushViewController:personInfoVC animated:YES];
            BFLog(@"我的资料");
            break;
        }
        case BFFunctionButtonTypeMyPrivilege:
            BFLog(@"我的特权");
            break;
            
        default:
            break;
    }
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
    [install addTarget:self action:@selector(goToSetting) forControlEvents:UIControlEventTouchUpInside];
    [install setBackgroundImage:[UIImage imageNamed:@"iconfont-setting.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:install];

}

- (void)goToSetting {
    BFSettingController *settingVC = [BFSettingController new];
    [self.navigationController pushViewController:settingVC animated:YES];
    self.navigationController.navigationBar.hidden = NO;
    //self.tabBarController.tabBar.hidden = YES;
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
                       self.navigationController.navigationBar.hidden = NO;
            self.tabBarController.tabBar.hidden = NO;
            break;
        }case 1:{
            BFMyOrderController *myorder = [[BFMyOrderController alloc]init];
            //myorder.titles = self.arr[1];
            [self.navigationController pushViewController:myorder animated:YES];
            self.navigationController.navigationBar.hidden = NO;
            self.tabBarController.tabBar.hidden = YES;
            
            break;
        }case 2:{
           
            break;
        }case 3:{

            break;
        }case 4:{
            
            BFPersonInformationController *personInfoVC = [[BFPersonInformationController alloc]init];
            [self.navigationController pushViewController:personInfoVC animated:NO];
            self.navigationController.navigationBar.hidden = NO;
            self.tabBarController.tabBar.hidden = YES;
            
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
