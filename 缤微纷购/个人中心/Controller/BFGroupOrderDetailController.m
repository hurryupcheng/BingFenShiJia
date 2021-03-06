//
//  BFGroupOrderDetailController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFGroupDetailController.h"
#import "BFGroupOrderDetailController.h"
#import "BFGroupOrderDetailView.h"
#import "BFGroupOrderDetailModel.h"
#import "BFPayoffViewController.h"
#import "BFCheckLogisticsController.h"

@interface BFGroupOrderDetailController ()<BFGroupOrderDetailViewDelegate>
/**团订单详情自定义view*/
@property (nonatomic, strong) BFGroupOrderDetailView *detailView;
/**model*/
@property (nonatomic, strong) BFGroupOrderDetailModel *model;
@end

@implementation BFGroupOrderDetailController

#pragma mark --懒加载
- (BFGroupOrderDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[BFGroupOrderDetailView alloc] initWithFrame:CGRectMake(0, 64-ScreenHeight, ScreenWidth, ScreenHeight-64)];
        _detailView.delegate = self;
        [self.view addSubview:_detailView];
    }
    return _detailView;
}





#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"团订单详情";
    //添加自定义view
    [self detailView];
    //添加数据
    [self getData];
    
}

#pragma mark -- 销毁通知
- (void)dealloc {
    [BFNotificationCenter removeObserver:self];
}




#pragma mark --获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=torderstatus"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"itemid"] = self.itemid;
    parameter[@"teamid"] = self.teamid;
    
    [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"%@,,%@",responseObject, parameter);
            if (responseObject) {
                self.model = [BFGroupOrderDetailModel parse:responseObject[@"order"]];
                self.detailView.model = self.model;
                [hud hideAnimated:YES];
                [UIView animateWithDuration:0.5 animations:^{
                    self.detailView.y = 0;
                }];
            }
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressOnlyWithLabelText:@"网路异常"];
            BFLog(@"%@",error);
        }];
    }];
}

#pragma mark --BFGroupOrderDetailViewDelegate代理方法
- (void)clickToViewWithButtonType:(BFGroupOrderDetailViewButtonType)buttonType {
    switch (buttonType) {
        case BFGroupOrderDetailViewButtonTypePay:{
            [self gotoPay];
            BFLog(@"点击支付");
            break;
        }
        case BFGroupOrderDetailViewButtonTypeGroup:{
            BFGroupDetailController *groupDetailVC = [[BFGroupDetailController alloc] init];
            groupDetailVC.itemid = self.itemid;
            groupDetailVC.teamid = self.teamid;
            [self.navigationController pushViewController:groupDetailVC animated:YES];
            BFLog(@"点击查看团详情");
            break;
        }
        case BFGroupOrderDetailViewButtonTypeLogistics:{
            BFLog(@"点击查看物流");
            BFCheckLogisticsController *vc = [BFCheckLogisticsController new];
            vc.freecode = self.model.freecode;
            [self.navigationController pushViewController:vc animated:YES];
            break;

        }
    }
}

#pragma mark --跳转到支付页面
- (void)gotoPay {
    [BFProgressHUD MBProgressWithLabelText:@"正在跳转支付页面..." dispatch_get_main_queue:^(MBProgressHUD *hud) {

        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=re_order_pay"];
        NSMutableDictionary *paramerer = [NSMutableDictionary dictionary];
        paramerer[@"uid"] = userInfo.ID;
        paramerer[@"token"] = userInfo.token;
        paramerer[@"orderId"] = self.model.orderid;
    //    [BFProgressHUD MBProgressFromView:self.navigationController.view LabelText:@"正在跳转支付页面..." dispatch_get_main_queue:^{
            [BFHttpTool POST:url params:paramerer success:^(id responseObject) {
                if (responseObject) {
                    BFLog(@"---%@,,%@",responseObject, paramerer);
                    BFLog(@"支付");
                    BFGenerateOrderModel *orderModel = [BFGenerateOrderModel parse:responseObject];
                    BFPayoffViewController *payVC = [[BFPayoffViewController alloc] init];
                    if ([self.model.pay_type isEqualToString:@"2"]) {
                        payVC.pay = @"支付宝";
                    }else {
                        payVC.pay = @"微信支付";
                    }
                    payVC.orderModel = orderModel;
                    payVC.totalPrice = self.model.order_sumPrice;
                    payVC.orderid = self.model.orderid;
                    payVC.addTime = self.model.add_time;
                    payVC.img = [@[self.model.img] mutableCopy];
                    payVC.isPT = YES;

                    [hud hideAnimated:YES];
                    [self.navigationController pushViewController:payVC animated:YES];
                    
                }
            } failure:^(NSError *error) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
                BFLog(@"%@", error);
            }];
    }];

}




@end
