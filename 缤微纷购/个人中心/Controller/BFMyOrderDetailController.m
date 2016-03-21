//
//  BFMyOrderDetailController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyOrderDetailController.h"
#import "BFProductInfoModel.h"
#import "BFProductDetailCell.h"
#import "BFOrderProductModel.h"
#import "BFCheckLogisticsController.h"
#import "BFOrderDetailAddressCell.h"
#import "BFOrderIdView.h"
#import "BFOrderDetailBottomView.h"
#import "BFOrderDetailInfoCell.h"

@interface BFMyOrderDetailController ()< UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**自定义头部视图*/
@property (nonatomic, strong) BFOrderIdView*headerView;
/**自定义footer视图*/
@property (nonatomic, strong) BFOrderDetailBottomView *footerView;
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

- (BFOrderDetailBottomView *)footerView {
    if (!_footerView) {
        _footerView = [BFOrderDetailBottomView createFooterView];
    }
    return _footerView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(35), ScreenWidth, ScreenHeight-66) style:UITableViewStyleGrouped];
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
    //头部视图
    [self setUpHeaderView];
    //头部视图
    [self setUpFooterView];
  
}
#pragma mark --viewDidLoad



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

    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
}
#pragma mark --订单编号视图
- (void)setUpHeaderView {
    [self.view addSubview:self.headerView];
}

#pragma mark --footer视图
- (void)setUpFooterView {
    [self.view addSubview:self.footerView];
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
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFLog(@"%lu",self.productArray.count);
    if (indexPath.section == 0) {
        BFOrderDetailAddressCell *cell = [BFOrderDetailAddressCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.section == 2) {
        BFOrderDetailInfoCell *cell = [BFOrderDetailInfoCell cellWithTableView:tableView];
        return cell;
    }else {
        BFProductDetailCell *cell = [BFProductDetailCell cellWithTableView:tableView];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
