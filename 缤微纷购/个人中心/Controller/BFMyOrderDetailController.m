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

@interface BFMyOrderDetailController ()< UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**自定义头部视图*/
@property (nonatomic, strong) BFOrderDetailView *headerView;
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

- (BFOrderDetailView *)headerView {
    if (!_headerView) {
        _headerView = [BFOrderDetailView detailView];
    }
    return _headerView;
}

- (BFLogisticInfoView *)footerView {
    if (!_footerView) {
        _footerView = [BFLogisticInfoView logisticView];
    }
    return _footerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66) style:UITableViewStylePlain];
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
    self.title = @"订单详情";
    //添加tableView
    [self tableView];
    //获取数据
    [self getData];
    //头部视图
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
}


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
        BFLog(@"%@",responseObject);
        self.headerView.model = self.model;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
}


#pragma mark --footer视图



#pragma mark --代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.productArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFLog(@"%lu",self.productArray.count);
    if (self.productArray.count == 0) {
        return [[UITableViewCell alloc] init];
    }else {
        if (indexPath.row == self.productArray.count) {
            BFModeCell *cell = [BFModeCell cellWithTableView:tableView];
            cell.model = self.model;
            self.modeCellH = cell.modeCellH;
            cell.userInteractionEnabled = NO;
            return cell;
        }else {
            BFProductDetailCell *cell = [BFProductDetailCell cellWithTableView:tableView];
            cell.model = self.productArray[indexPath.row];
            self.orderProductH = cell.productDetailH;
            return cell;
        }
    }
    
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
