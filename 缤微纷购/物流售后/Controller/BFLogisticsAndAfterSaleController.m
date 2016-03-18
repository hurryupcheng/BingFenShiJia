//
//  BFLogisticsAndAfterSaleController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFLogisticsAndAfterSaleController.h"
#import "BFLogisticsCell.h"
#import "BFLogisticsHeaderView.h"

@interface BFLogisticsAndAfterSaleController ()<UITableViewDelegate, UITableViewDataSource, BFLogisticsHeaderViewDelegate, BFLogisticsCellDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**无信息时的背景*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**分区头视图*/
@property (nonatomic, strong) BFLogisticsHeaderView *headerView;

@end

@implementation BFLogisticsAndAfterSaleController

- (BFLogisticsHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [BFLogisticsHeaderView createHeaderView];
        _headerView.delegate = self;
    }
    return _headerView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BFColor(0xF2F4F5);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bgImageView.image = [UIImage imageNamed:@"after_sale_service"];
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"物流·售后";
    //添加tableView
    [self tableView];
    //添加导航按钮
    [self setNavigationBar];
}
#pragma mark --添加导航按钮
- (void)setNavigationBar {
    UIButton *afterSaleProgress = [UIButton buttonWithType:0];
    afterSaleProgress.frame = CGRectMake(0, 0, BF_ScaleWidth(60), BF_ScaleHeight(44));
    [afterSaleProgress setTitle:@"售后进度" forState:UIControlStateNormal];
    //[afterSaleProgress setTitleColor:BFColor(0x000F8F) forState:UIControlStateNormal];
    afterSaleProgress.backgroundColor = [UIColor greenColor];
    afterSaleProgress.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    [afterSaleProgress addTarget:self action:@selector(clickToGoToAfterSaleProgressInterFace) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:afterSaleProgress];
    self.navigationItem.rightBarButtonItems = @[rightItem];
}

- (void)clickToGoToAfterSaleProgressInterFace {
    
}


#pragma mark --tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFLogisticsCell *cell = [BFLogisticsCell cellWithTableView:tableView];
    cell.delegate = self;
    return cell;
}

#pragma mark -- BFLogisticsCell代理
- (void)clickToOperateWithType:(BFLogisticsCellButtonType)type {
    switch (type) {
        case BFLogisticsCellButtonTypeApplyAfterSale:
            BFLog(@"申请售后");
            break;
        case BFLogisticsCellButtonTypeCheckLogistics:
            BFLog(@"查看物流");
            break;
        case BFLogisticsCellButtonTypeConfirmReceipt:
            BFLog(@"确认收货");
            break;

    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(200);
}

#pragma mark -- 分区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return BF_ScaleHeight(30);
}
//分区头视图代理
- (void)clickToSeeConmmonProblem {
    
}

@end
