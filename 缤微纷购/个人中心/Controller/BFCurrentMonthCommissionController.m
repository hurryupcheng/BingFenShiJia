//
//  BFCurrentMonthCommissionController.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFModifyBankCardController.h"
#import "BFCurrentMonthCommissionController.h"
#import "BFCustomerServiceView.h"
#import "BFVIPOrderCommissionController.h"
#import "BFCustomerOrderCommissionController.h"
#import "BFRecommendOrderCommissionController.h"

@interface BFCurrentMonthCommissionController ()<BFSegmentViewDelegate, BFCustomerServiceViewDelegate>
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;
/**vip订单*/
@property (nonatomic, strong) BFVIPOrderCommissionController *vipVC;
/**客户订单*/
@property (nonatomic, strong) BFCustomerOrderCommissionController *customerVC;
/**推荐分成*/
@property (nonatomic, strong) BFRecommendOrderCommissionController *recommendVC;
@end

@implementation BFCurrentMonthCommissionController


#pragma mark -- 懒加载

- (BFVIPOrderCommissionController *)vipVC {
    if (!_vipVC) {
        _vipVC = [[BFVIPOrderCommissionController alloc] init];
        _vipVC.view.frame = CGRectMake(0, 50, ScreenHeight, ScreenHeight-50);
    }
    return _vipVC;
}

- (BFCustomerOrderCommissionController *)customerVC {
    if (!_customerVC) {
        _customerVC = [[BFCustomerOrderCommissionController alloc] init];
        _customerVC.view.frame = CGRectMake(0, 50, ScreenHeight, ScreenHeight-50);
    }
    return _customerVC;
}

- (BFRecommendOrderCommissionController *)recommendVC {
    if (!_recommendVC) {
        _recommendVC = [[BFRecommendOrderCommissionController alloc] init];
        _recommendVC.view.frame = CGRectMake(0, 50, ScreenHeight, ScreenHeight-50);
    }
    return _recommendVC;
}

- (BFSegmentView *)segment {
    if (!_segment) {
        _segment = [BFSegmentView segmentView];
        _segment.delegate = self;
        _segment.titleArray = @[@"VIP订单", @"客户订单", @"推荐分成订单"];
        [self.view addSubview:_segment];
    }
    return _segment;
}


#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0x4da800);
    self.title = @"当月广告费";
    //添加navigationbar
    [self setUpNavigationBar];
    //添加分段控制器
    [self segment];
    //进入页面点击分段控制器第一个
    self.segment.segmented.selectedSegmentIndex = 1;
    [self.segment click];
    
    [BFNotificationCenter addObserver:self selector:@selector(gotoModifyBankInfo) name:@"gotoModify" object:nil];
}
- (void)gotoModifyBankInfo{
    BFModifyBankCardController *modifyVC = [[BFModifyBankCardController alloc] init];
    modifyVC.block = ^(BFUserInfo *userInfo) {
        
    };
    [self.navigationController pushViewController:modifyVC animated:YES];

}

#pragma mark --BFSegmentView代理方法
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    
    switch (segmentedControl.selectedSegmentIndex) {
        case 0: {
            [self.customerVC.view removeFromSuperview];
            [self.recommendVC.view removeFromSuperview];
            [self.view addSubview:self.vipVC.view];
            BFLog(@"点击第一个");
            break;
        }
        case 1: {
            [self.vipVC.view removeFromSuperview];
            [self.recommendVC.view removeFromSuperview];
            [self.view addSubview:self.customerVC.view];
            BFLog(@"点击第二个");
           break;
        }
        case 2: {
            [self.customerVC.view removeFromSuperview];
            [self.vipVC.view removeFromSuperview];
            [self.view addSubview:self.recommendVC.view];
            BFLog(@"点击第三个");
            break;
        }
    }
    [self.view bringSubviewToFront:self.segment];
}



#pragma mark -- 设置客服按钮
- (void)setUpNavigationBar {
    UIButton *telephone = [UIButton buttonWithType:0];
    //telephone.backgroundColor = [UIColor redColor];
    telephone.width = 30;
    telephone.height = 30;
    [telephone addTarget:self action:@selector(telephone) forControlEvents:UIControlEventTouchUpInside];
    [telephone setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
    UIBarButtonItem *telephoneItem = [[UIBarButtonItem alloc] initWithCustomView:telephone];
    self.navigationItem.rightBarButtonItem = telephoneItem;
}

- (void)telephone {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    BFCustomerServiceView *customerServiceView = [BFCustomerServiceView createCustomerServiceView];
    customerServiceView.delegate = self;
    [window addSubview:customerServiceView];
}


#pragma mark --BFCustomerServiceViewDelegate
- (void)clickToChooseCustomerServiceWithType:(BFCustomerServiceViewButtonType)type {
    switch (type) {
        case BFCustomerServiceViewButtonTypeTelephone:{
            BFLog(@"点击电话客服");
            UIAlertController *alertC = [UIAlertController alertWithControllerTitle:nil controllerMessage:nil preferredStyle:UIAlertControllerStyleActionSheet actionTitle:@"020-38875719" style:UIAlertActionStyleDefault handler:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://020-38875719"]]];
            }];
            [self presentViewController:alertC animated:YES completion:nil];
            
            
            break;
        }
        case BFCustomerServiceViewButtonTypeWechat:
            BFLog(@"点击微信客服");
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"暂不支持，尽请期待"];
            break;
            
    }
}
@end
