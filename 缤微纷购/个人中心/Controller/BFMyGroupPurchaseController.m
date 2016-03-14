//
//  BFMyGroupPurchaseController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyGroupPurchaseController.h"
#import "BFMyGroupPurchaseCell.h"

@interface BFMyGroupPurchaseController ()<UITableViewDelegate, UITableViewDataSource, BFMyGroupPurchaseCellDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation BFMyGroupPurchaseController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BFColor(0xF4F4F4);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的拼团";
    //添加tableView;
    [self tableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyGroupPurchaseCell *cell = [BFMyGroupPurchaseCell cellWithTableView:tableView];
    cell.delegate = self;
    //cell.textLabel.text = @"测试";
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BF_ScaleHeight(133);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 13;
    }
    return 0;
}
#pragma mark --BFMyGroupPurchaseCell代理方法
/**BFMyGroupPurchaseCell代理方法*/
- (void)clickToGotoCheckDetailWithButtonType:(MyGroupPurchaseCellCheckButtonType)type {
    switch (type) {
        case MyGroupPurchaseCellCheckButtonTypeGroup:{
            BFLog(@"团详情");
            break;
        }
        case MyGroupPurchaseCellCheckButtonTypeOrder:{
            BFLog(@"订单详情");
            break;
        }
    }
}

@end
