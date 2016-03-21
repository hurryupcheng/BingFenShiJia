//
//  BFMyOrderDetailController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyOrderDetailController.h"
#import "BFLogisticInfoView.h"
#import "BFProductInfoModel.h"
#import "BFOrderDetailView.h"
#import "BFProductDetailCell.h"
#import "BFModeCell.h"
#import "BFOrderProductModel.h"
#import "BFCheckLogisticsController.h"
#import "BFOrderDetailAddressCell.h"
#import "BFOrderIdView.h"

@interface BFMyOrderDetailController ()< UITableViewDelegate, UITableViewDataSource, BFLogisticInfoViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**自定义头部视图*/
@property (nonatomic, strong) BFOrderIdView*headerView;
/**自定义footer视图*/
@property (nonatomic, strong) BFLogisticInfoView *footerView;
/**BFProductInfoModel模型*/
@property (nonatomic, strong) BFProductInfoModel *model;
/**BFModeCell的高度*/
@property (nonatomic, assign) CGFloat modeCellH;
/**BFOrderProductModel的高度*/
@property (nonatomic, assign) CGFloat orderProductH;
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
        _headerView = [BFOrderIdView createHeaderView];
    }
    return _headerView;
}

//- (BFLogisticInfoView *)footerView {
//    if (!_footerView) {
//        _footerView = [BFLogisticInfoView logisticView];
//    }
//    return _footerView;
//}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(35), ScreenWidth, ScreenHeight-66) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BFColor(0xF4F4F4);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    //头部视图
    [self setUpHeaderView];
    //[self setUpFooterView];
}
#pragma mark --viewDidLoad
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.tableView.y = -ScreenHeight;
//    }];
//}


#pragma mark --获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=checkOrder"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"orderId"] = self.orderId;
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        
        self.model = [BFProductInfoModel parse:responseObject[@"order"]];
        NSArray *array = [BFOrderProductModel parse:responseObject[@"order"][@"item_detail"]];
        [self.productArray addObjectsFromArray:array];
        //BFLog(@"%@",responseObject);

        [self.tableView reloadData];
//        [UIView animateWithDuration:0.5 animations:^{
//            self.tableView.y = 0;
//        }];
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
}
#pragma mark --订单编号视图
- (void)setUpHeaderView {
    [self.view addSubview:self.headerView];
}

#pragma mark --footer视图
//- (void)setUpFooterView {
//    self.footerView = [BFLogisticInfoView logisticView];
//    self.footerView.model = self.model;
//    self.footerView.delegate = self;
//    self.tableView.tableFooterView = self.footerView;
//}

//footer代理
//- (void)logisticInfoView:(BFLogisticInfoView *)view type:(BFLogisticInfoViewButtonType)type {
//    switch (type) {
//        case BFLogisticInfoViewButtonTypeCheckLogistics:{
//            BFLog(@"查看物流");
//            BFCheckLogisticsController *vc = [BFCheckLogisticsController new];
//            vc.freecode = self.model.freecode;
//            [self.navigationController pushViewController:vc animated:YES];
//            break;
//        }
//        case BFLogisticInfoViewButtonTypePay:
//            BFLog(@"付款");
//            break;
//        case BFLogisticInfoViewButtonTypeCancleOrder:
//            BFLog(@"取消订单");
//            break;
//        case BFLogisticInfoViewButtonTypeApplyRebund:
//            BFLog(@"申请退款");
//            break;
//        case BFLogisticInfoViewButtonTypeApplyReturnGoods:
//            BFLog(@"申请退货退款");
//            break;
//        case BFLogisticInfoViewButtonTypeConfirmReceipt:
//            BFLog(@"确认收货");
//            break;
//        case BFLogisticInfoViewButtonTypeCancleReturn:
//            BFLog(@"撤销退货退款申请");
//            break;
//            
//        default:
//            break;
//    }
//}

#pragma mark --代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 2) {
        return 6;
    }else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFLog(@"%lu",self.productArray.count);
    if (indexPath.section == 0) {
        BFOrderDetailAddressCell *cell = [BFOrderDetailAddressCell cellWithTableView:tableView];
        return cell;
    }
    return [[UITableViewCell alloc] init];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.row == self.productArray.count) {
        return self.modeCellH;
        BFLog(@"%f",self.modeCellH);
    }else {
        return self.orderProductH;
    }
    
}

@end
