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
        _footerView = [[BFOrderDetailBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, BF_ScaleHeight(45))];
        _footerView.delegate = self;
        [self.view addSubview:_footerView];
    }
    return _footerView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(35)-ScreenHeight, ScreenWidth, ScreenHeight-66) style:UITableViewStyleGrouped];
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
    self.view.backgroundColor = BFColor(0xF4F4F4);
    self.title = @"订单详情";

    //添加tableView
    [self tableView];
    //获取数据
    [self getData];
    
  
}




#pragma mark --获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=checkOrder"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"orderId"] = self.orderId;
    
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            
            if (responseObject) {
                
                self.model = [BFProductInfoModel parse:responseObject[@"order"]];
                self.headerView.model = self.model;
                self.footerView.model = self.model;
                NSArray *array = [BFOrderProductModel parse:responseObject[@"order"][@"item_detail"]];
                [self.productArray addObjectsFromArray:array];
                BFLog(@"%@,,%@",responseObject, parameter);
                
            }
            
            [self.tableView reloadData];
            [self animation];
        } failure:^(NSError *error) {
            BFLog(@"%@",error);
        }];
    }];
}
#pragma mark --动画效果
- (void)animation {
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.y = BF_ScaleHeight(35);
        self.headerView.y = 0;
        self.footerView.y = ScreenHeight-BF_ScaleHeight(45)-64;
    }];

}

#pragma mark --BFOrderDetailBottomViewDelegate
- (void)clickToOperateWithType:(BFOrderDetailBottomViewButtonType)type {
    switch (type) {
        case BFOrderDetailBottomViewButtonTypeCancleOrder:{
            UIAlertController *alertC = [UIAlertController alertWithControllerTitle:@"取消订单" controllerMessage:@"确定取消订单吗" preferredStyle:UIAlertControllerStyleAlert actionTitle:@"确定" style:UIAlertActionStyleDefault handler:^{
                //取消订单请求
                [self cancleOrder];
            }];
            [self presentViewController:alertC animated:YES completion:nil];
            BFLog(@"取消订单");
            break;
        }
        case BFOrderDetailBottomViewButtonTypePay:{
            BFLog(@"支付");
            BFPayoffViewController *payVC = [[BFPayoffViewController alloc] init];
            if ([self.model.pay_type isEqualToString:@"1"]) {
                payVC.pay = @"微信支付";
            }else if ([self.model.pay_type isEqualToString:@"2"]) {
                payVC.pay = @"支付宝";
            }
            payVC.totalPrice = self.model.order_sumPrice;
            payVC.orderid = self.model.orderId;
            payVC.addTime = self.model.add_time;
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (BFOrderProductModel *model in self.productArray) {
                [mutableArray addObject:model.img];
            }
            payVC.img = mutableArray;
            //BFLog(@"%@",payVC.img);
            [self.navigationController pushViewController:payVC animated:YES];
            break;
        }
        case BFOrderDetailBottomViewButtonTypeCheckLogistics:{
            BFCheckLogisticsController *checkLogisticsVC = [[BFCheckLogisticsController alloc] init];
            checkLogisticsVC.freecode = self.model.freecode;
            [self.navigationController pushViewController:checkLogisticsVC animated:YES];
            BFLog(@"查看物流");
            break;
        }
        case BFOrderDetailBottomViewButtonTypeConfirmReceipt:
            BFLog(@"确认收货");
            break;
            
        default:
            break;
    }
}

#pragma mark -- 取消订单请求
- (void)cancleOrder{
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading..." dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=cancelOrder"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"uid"] = userInfo.ID;
        parameter[@"token"] = userInfo.token;
        parameter[@"orderId"] = self.model.orderId;
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"--%@", responseObject);
            if ([responseObject[@"msg"] isEqualToString:@"取消成功"]) {
                [BFProgressHUD MBProgressFromView:self.navigationController.view rightLabelText:@"订单取消成功"];
                self.headerView.statusLabel.text = @"已关闭";
                self.footerView.hidden = YES;
                //发送通知修改上级页面
                [BFNotificationCenter postNotificationName:@"changeOrderArray" object:nil];
            }else {
                [BFProgressHUD MBProgressFromView:self.navigationController.view rightLabelText:@"订单取消失败"];
            }
        } failure:^(NSError *error) {
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
        fxqVC.ID = model.ID;
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
        return 40;
    }
    return 0.1;
}

@end
