//
//  BFMyOrderDetailController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFPayoffViewController.h"
#import "BFMyOrderDetailController.h"
#import "BFProductInfoModel.h"
#import "BFProductDetailCell.h"
#import "BFOrderProductModel.h"
#import "BFCheckLogisticsController.h"
#import "BFOrderDetailAddressCell.h"
#import "BFOrderIdView.h"
#import "BFOrderDetailBottomView.h"
#import "BFOrderDetailInfoCell.h"
#import "FXQViewController.h"

@interface BFMyOrderDetailController ()< UITableViewDelegate, UITableViewDataSource, BFOrderDetailBottomViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**自定义头部视图*/
@property (nonatomic, strong) BFOrderIdView *headerView;
/**自定义footer视图*/
@property (nonatomic, strong) BFOrderDetailBottomView *footerView;
/**BFProductInfoModel模型*/
@property (nonatomic, strong) BFProductInfoModel *model;
/**商品数组*/
@property (nonatomic, strong) NSMutableArray *productArray;

@end

@implementation BFMyOrderDetailController

- (NSMutableArray *)productArray {
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}



- (BFOrderIdView *)headerView {
    if (!_headerView) {
        _headerView = [[BFOrderIdView alloc] initWithFrame:CGRectMake(0, -BF_ScaleHeight(35), ScreenWidth, BF_ScaleHeight(35))];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (BFOrderDetailBottomView *)footerView {
    if (!_footerView) {
        _footerView = [[BFOrderDetailBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, BF_ScaleHeight(50))];
        _footerView.delegate = self;
        //_footerView.backgroundColor = BFColor(0x4da800);
        [self.view addSubview:_footerView];
    }
    return _footerView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(35)-ScreenHeight, ScreenWidth, ScreenHeight-64-BF_ScaleHeight(35)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BFColor(0xF4F4F4);
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"订单详情";

    //添加tableView
    [self tableView];
    //获取数据
    [self getData];
    //从本页面进入支付页面，支付成功接受通知
//    [BFNotificationCenter addObserver:self selector:@selector(changeOrderStatus) name:@"changeOrderStatus" object:nil];
  
}

#pragma mark --销毁通知
//- (void)dealloc {
//    [BFNotificationCenter removeObserver:self];
//}


#pragma mark --获取数据
- (void)getData {
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=checkOrder"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"orderId"] = self.orderId;
    
    [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            
            if (responseObject) {
                
                self.model = [BFProductInfoModel parse:responseObject[@"order"]];
                self.headerView.model = self.model;
                self.footerView.model = self.model;
                if ([[BFOrderProductModel parse:responseObject[@"order"][@"item_detail"]] isKindOfClass:[NSArray class]]) {
                    NSArray *array = [BFOrderProductModel parse:responseObject[@"order"][@"item_detail"]];
                    [self.productArray addObjectsFromArray:array];

                }
                BFLog(@"%@,,%@",responseObject, parameter);
                
            }
            [hud hideAnimated:YES];
            [self.tableView reloadData];
            [self animation];
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressOnlyWithLabelText:@"网络异常"];
            BFLog(@"%@",error);
        }];
    }];
}
#pragma mark --动画效果
- (void)animation {
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.y = BF_ScaleHeight(35);
        self.headerView.y = 0;
        self.footerView.y = ScreenHeight-BF_ScaleHeight(50)-64;
    }];

}

#pragma mark --BFOrderDetailBottomViewDelegate
- (void)clickToOperateWithType:(BFOrderDetailBottomViewButtonType)type {
    switch (type) {
        case BFOrderDetailBottomViewButtonTypeCancleOrder:{
            
            UIAlertController *alertC = [UIAlertController alertWithControllerTitle:@"取消订单" controllerMessage:@"客官,真的要取消吗?请三思啊!" preferredStyle:UIAlertControllerStyleAlert cancleTitle:@"还是算了吧!" actionTitle:@"下定决心不买了" style:UIAlertActionStyleDefault handler:^{
                //取消订单请求
                [self cancleOrder];
            }];
            [self presentViewController:alertC animated:YES completion:nil];
            BFLog(@"取消订单");
            break;
        }
        case BFOrderDetailBottomViewButtonTypePay:{
            //去支付
            [self gotoPay];
            
            break;
        }
        case BFOrderDetailBottomViewButtonTypeCheckLogistics:{
            BFCheckLogisticsController *checkLogisticsVC = [[BFCheckLogisticsController alloc] init];
            checkLogisticsVC.freecode = self.model.freecode;
            [self.navigationController pushViewController:checkLogisticsVC animated:YES];
            BFLog(@"查看物流");
            break;
        }
        case BFOrderDetailBottomViewButtonTypeConfirmReceipt:{
            UIAlertController *alertC = [UIAlertController alertWithControllerTitle:@"确认收货" controllerMessage:@"客官,请确认收到货物后再收货哦!" preferredStyle:UIAlertControllerStyleAlert cancleTitle:@"那就再等等吧!" actionTitle:@"货物已收到,非常满意" style:UIAlertActionStyleDefault handler:^{
                //确认收货
                [self confirmOrder];
            }];
            [self presentViewController:alertC animated:YES completion:nil];
            BFLog(@"确认收货");
            break;
        }
    }
}
#pragma mark -- 去支付
- (void)gotoPay {
    float payMoney = [self.model.order_sumPrice floatValue];
    if (payMoney < 0.01) {
        [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"订单提交失败"];
    }else {
    [BFProgressHUD MBProgressWithLabelText:@"正在跳转支付页面..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=re_order_pay"];
        NSMutableDictionary *paramerer = [NSMutableDictionary dictionary];
        paramerer[@"uid"] = userInfo.ID;
        paramerer[@"token"] = userInfo.token;
        paramerer[@"orderId"] = self.model.orderId;
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
                    
                    payVC.totalPrice = [NSString stringWithFormat:@"%.2f", payMoney];
                    
                    payVC.orderid = self.model.orderId;
                    payVC.addTime = self.model.add_time;
                    NSMutableArray *mutableArray = [NSMutableArray array];
                    for (BFOrderProductModel *model in self.productArray) {
                        [mutableArray addObject:model.img];
                    }
                    payVC.img = mutableArray;
                    [hud hideAnimated:YES];
                    [self.navigationController pushViewController:payVC animated:YES];
                    
                }
            } failure:^(NSError *error) {
                [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
                [hud hideAnimated:YES];
                BFLog(@"%@", error);
            }];
    }];

    }
}




#pragma mark -- 支付成功改变状态
- (void)changeOrderStatus {
    _block(YES);
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=checkOrder"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"orderId"] = self.orderId;
    
//    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
//        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
//    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            if (responseObject) {
                
                self.model = [BFProductInfoModel parse:responseObject[@"order"]];
                self.headerView.model = self.model;
                self.footerView.model = self.model;
                if ([[BFOrderProductModel parse:responseObject[@"order"][@"item_detail"]] isKindOfClass:[NSArray class]]) {
                    NSArray *array = [BFOrderProductModel parse:responseObject[@"order"][@"item_detail"]];
                    [self.productArray removeAllObjects];
                    [self.productArray addObjectsFromArray:array];
                }
                BFLog(@"%@,,%@",responseObject, parameter);
            }
            [self.tableView reloadData];
            //[self animation];
        } failure:^(NSError *error) {
            BFLog(@"%@",error);
        }];
//    }];

}


#pragma mark -- 确认收货
- (void)confirmOrder {
    [BFProgressHUD MBProgressWithLabelText:@"正在收货,请稍等片刻..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        if (![self.model.status isEqualToString:@"3"]) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"订单还未发货,请耐心等候..."];
        }else {
            BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
            NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=confirmOrder"];
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            parameter[@"uid"] = userInfo.ID;
            parameter[@"token"] = userInfo.token;
            parameter[@"orderId"] = self.model.orderId;
            parameter[@"status"] = self.model.status;
            [BFHttpTool POST:url params:parameter success:^(id responseObject) {
                BFLog(@"--%@----%@", responseObject, parameter);
                if ([responseObject[@"msg"] isEqualToString:@"确认收货成功"]) {
                        [hud hideAnimated:YES];
                        [BFProgressHUD MBProgressFromView:self.navigationController.view rightLabelText:@"确认收货成功"];
                        [self.tableView reloadData];
                        self.headerView.statusLabel.text = @"已完成";
                        self.model.status = @"4";
                        self.footerView.model = self.model;
                        //self.footerView.hidden = YES;
                        _block(YES);
                    
                }else if([responseObject[@"msg"] isEqualToString:@"确认收货失败"]){
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"确认收货失败"];
                }else if([responseObject[@"msg"] isEqualToString:@"该订单不存在"]){
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"该订单不存在"];
                }else {
                    
                }
            } failure:^(NSError *error) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
                BFLog(@"--%@", error);
            }];
        }
    }];

}



#pragma mark -- 取消订单请求
- (void)cancleOrder{
    [BFProgressHUD MBProgressWithLabelText:@"正在取消订单,请稍等片刻..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=cancelOrder"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"uid"] = userInfo.ID;
        parameter[@"token"] = userInfo.token;
        parameter[@"orderId"] = self.model.orderId;
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"--%@", responseObject);
            if ([responseObject[@"msg"] isEqualToString:@"取消成功"]) {
                [hud hideAnimated:YES];
                
                [BFProgressHUD MBProgressFromWindowWithLabelText:@"订单取消成功,正在跳转..." dispatch_get_main_queue:^{
                    //取消订单，改变积分
                    [BFAvailablePoints updateAvailablePoints];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                self.headerView.statusLabel.text = @"已关闭";
                //self.footerView.hidden = YES;
                [UIView animateWithDuration:0.5 animations:^{
                    self.footerView.y = ScreenHeight;
                }];
                _block(YES);
            }else {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressFromView:self.navigationController.view rightLabelText:@"订单取消失败"];
            }
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
            BFLog(@"--%@", error);
        }];
    }];

}


#pragma mark --代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 2) {
        return 1;
    }else {
        return self.productArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BFOrderDetailAddressCell *cell = [BFOrderDetailAddressCell cellWithTableView:tableView];
        cell.model = self.model;
        return cell;
    }else if (indexPath.section == 2) {
        BFOrderDetailInfoCell *cell = [BFOrderDetailInfoCell cellWithTableView:tableView];
        cell.model = self.model;
        return cell;
    }else {
        BFProductDetailCell *cell = [BFProductDetailCell cellWithTableView:tableView];
        cell.model = self.productArray[indexPath.row];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        FXQViewController *fxqVC = [[FXQViewController alloc] init];
        BFOrderProductModel *model = self.productArray[indexPath.row];
        fxqVC.ID = model.itemid;
        [self.navigationController pushViewController:fxqVC animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.section == 0) {
        return BF_ScaleHeight(110);
    }else if (indexPath.section == 2){
        return BF_ScaleHeight(264);
    }else {
        return BF_ScaleHeight(100);
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return BF_ScaleHeight(15);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return BF_ScaleHeight(50);
    }
    return 0.1;
}

@end
