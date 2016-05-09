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
#import "BFMyGroupPurchaseController.h"
#import "BFMyCouponsController.h"
#import "BFAddRecommenderView.h"
#import "BFMyClientController.h"
#import "BFCurrentMonthCommissionController.h"

@interface PersonalViewController ()<FunctionButtonDelegate, BFPersonalCenterTopViewDelegate, AddRecommenderViewDelegate>
/**个人中心有阴影的界面*/
@property (nonatomic, strong) BFPersonalCenterTopView *topView;
/**个人中心6个功能按钮的界面*/
@property (nonatomic, strong) BFFunctionButtonView *functionView;
/**用户信息*/
@property (nonatomic, strong) BFUserInfo *userInfo;
/**添加推荐人*/
@property (nonatomic, strong) BFAddRecommenderView *addView;

//@property (nonatomic,retain)UIView *backgroundView;
@property (nonatomic,retain)UIImageView *groundView;
//@property (nonatomic,retain)UIButton *picImageBut;
//
//@property (nonatomic,retain)NSArray *arr;

//@property (nonatomic, assign) BOOL denglu;

@end

@implementation PersonalViewController

- (BFAddRecommenderView *)addView {
    if (!_addView) {
        _addView = [[BFAddRecommenderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _addView.delegate = self;
        [self.view addSubview:_addView];
    }
    return _addView;
}



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
#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.groundView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.groundView.image = [UIImage imageNamed:@"bg.jpg"];
    self.groundView.userInteractionEnabled = YES;
    //添加背景图片
    [self.view addSubview:self.groundView];
    //添加上部视图
    [self.view addSubview:self.topView];
    //添加下面功能视图
    [self.view addSubview:self.functionView];

}
#pragma mark -- viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //添加上部视图改变状态方法
    [self.topView changeStatus];
    //[self.addView addRecommender];
    self.userInfo = [BFUserDefaluts getUserInfo];
    BFUserInfo *haha = [BFUserDefaluts getUserInfo];
    BFLog(@"---------积分%@", haha.score);
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
}

#pragma mark -- viewWillAppear
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.navigationController.navigationBarHidden = NO;
    //self.tabBarController.tabBar.hidden = YES;
    
}

#pragma mark -- 添加推荐人代理
- (void)hideView {
    [self.topView changeStatus];
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
    
    if (self.userInfo == nil) {
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
            LogViewController *logVC= [LogViewController new];
            [self.navigationController pushViewController:logVC animated:YES];
            self.navigationController.navigationBarHidden = NO;
        }];
        
    }else {
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = YES;
        BFPersonInformationController *personInfoVC = [[BFPersonInformationController alloc]init];
        [self.navigationController pushViewController:personInfoVC animated:YES];
        BFLog(@"我的资料");
    }
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

#pragma mark -- 添加推荐人按钮代理点击
- (void)gotoAddRecommender {
    [self.addView showView];
   
}

#pragma mark -- 点击确定添加推荐人
- (void)sureToAddRecommenderWithView:(BFAddRecommenderView *)view {
     BFLog(@"添加推荐人%@",view.IDTextField.text);
}

#pragma mark -- 注册按钮代理点击
- (void)goToPersonalCenterTopButtoInterfaceWithType:(BFPersonalCenterTopButtonType)type {
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    switch (type) {
        case BFPersonalCenterTopButtonTypeIntegral:{
            BFMyIntegralController *myIntegralVC = [BFMyIntegralController new];
            [self.navigationController pushViewController:myIntegralVC animated:YES];
            BFLog(@"点击了积分按钮");
            break;
        }
        case BFPersonalCenterTopButtonTypeAdvertisingExpense:{
            BFCurrentMonthCommissionController *currentVC = [BFCurrentMonthCommissionController new];
            [self.navigationController pushViewController:currentVC animated:YES];
            BFLog(@"点击了广告费按钮");
            break;
        }
        case BFPersonalCenterTopButtonTypeMyClient:{
            BFLog(@"点击了我的客户按钮");
            BFMyClientController *myClientVC = [BFMyClientController new];
            [self.navigationController pushViewController:myClientVC animated:YES];
            
            break;
        }
        default:
            break;
    }
}

#pragma mark -- 6个功能按钮的点击
- (void)chooseFunction:(BFFunctionButtonType)type {
 
    switch (type) {
        case BFFunctionButtonTypeMyWallet:{
            if (self.userInfo == nil) {
                [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
                    
                    LogViewController *logVC= [LogViewController new];
                    [self.navigationController pushViewController:logVC animated:YES];
                    self.navigationController.navigationBarHidden = NO;
                }];
            }else {
                self.navigationController.navigationBarHidden = NO;
                self.tabBarController.tabBar.hidden = YES;
                BFMyWalletController *myWallet = [[BFMyWalletController alloc]init];
                [self.navigationController pushViewController:myWallet animated:YES];
                BFLog(@"我的钱包");
            }
            break;
        }
        case BFFunctionButtonTypeMyOrder:{
            if (self.userInfo == nil) {
                [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
                    
                    LogViewController *logVC= [LogViewController new];
                    [self.navigationController pushViewController:logVC animated:YES];
                    self.navigationController.navigationBarHidden = NO;
                }];
            }else {
                self.tabBarController.tabBar.hidden = YES;
                BFMyOrderController *myorder = [[BFMyOrderController alloc]init];
                [self.navigationController pushViewController:myorder animated:YES];
                BFLog(@"我的订单");
            }
            break;
        }
        case BFFunctionButtonTypeMyGroupPurchase:{
            if (self.userInfo == nil) {
                [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
                    
                    LogViewController *logVC= [LogViewController new];
                    [self.navigationController pushViewController:logVC animated:YES];
                    self.navigationController.navigationBarHidden = NO;
                }];
            }else{
            BFLog(@"我的拼团");
                self.navigationController.navigationBarHidden = NO;
                self.tabBarController.tabBar.hidden = YES;
                BFMyGroupPurchaseController *myGroupPurchaseVC = [BFMyGroupPurchaseController new];
                [self.navigationController pushViewController:myGroupPurchaseVC animated:YES];
            }
            break;
        }
        case BFFunctionButtonTypeMyCoupons:{
            if (self.userInfo == nil) {
                [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
                    
                    LogViewController *logVC= [LogViewController new];
                    [self.navigationController pushViewController:logVC animated:YES];
                    self.navigationController.navigationBarHidden = NO;
                }];
            }else {
                self.navigationController.navigationBarHidden = NO;
                self.tabBarController.tabBar.hidden = YES;
                BFMyCouponsController *myCoupons = [[BFMyCouponsController alloc]init];
                [self.navigationController pushViewController:myCoupons animated:YES];
                BFLog(@"我的优惠券");
            }
            break;
        }
        case BFFunctionButtonTypeMyProFile:{
            if (self.userInfo == nil) {
                [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
                    self.navigationController.navigationBarHidden = NO;
                    LogViewController *logVC= [LogViewController new];
                    [self.navigationController pushViewController:logVC animated:YES];
                }];
            }else {
                self.navigationController.navigationBarHidden = NO;
                self.tabBarController.tabBar.hidden = YES;
                BFPersonInformationController *personInfoVC = [[BFPersonInformationController alloc]init];
                [self.navigationController pushViewController:personInfoVC animated:YES];
                BFLog(@"我的资料");
            }
            break;
        }
        case BFFunctionButtonTypeMyPrivilege:
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"还未开启，敬请期待"];
            BFLog(@"我的特权");
            break;
            
        default:
            break;
    }
}




@end
