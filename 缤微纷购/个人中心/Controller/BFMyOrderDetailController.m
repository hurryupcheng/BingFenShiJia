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

@interface BFMyOrderDetailController ()< UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**自定义头部视图*/
@property (nonatomic, strong) BFOrderDetailView *headerView;
/**自定义footer视图*/
@property (nonatomic, strong) BFLogisticInfoView *footerView;
/**BFModeCell的高度*/
@property (nonatomic, assign) CGFloat modeCellH;
@end

@implementation BFMyOrderDetailController




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
        BFLog(@"%@",responseObject);
        BFProductInfoModel *model = [BFProductInfoModel parse:responseObject[@"order"]];
        
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
}


#pragma mark --footer视图
- (void)getFooterView {
    
}


#pragma mark --代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        BFModeCell *cell = [BFModeCell cellWithTableView:tableView];
        
        return cell;
    }else {
        BFProductDetailCell *cell = [BFProductDetailCell cellWithTableView:tableView];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.row == 2) {
        return BF_ScaleHeight(130);
    }
    return BF_ScaleHeight(80);
}

@end
