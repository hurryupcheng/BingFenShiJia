//
//  BFMyGroupPurchaseController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyGroupPurchaseController.h"
#import "BFMyGroupPurchaseCell.h"
#import "BFMyGroupPurchaseModel.h"

@interface BFMyGroupPurchaseController ()<UITableViewDelegate, UITableViewDataSource, BFMyGroupPurchaseCellDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**拼团数组*/
@property (nonatomic, strong) NSMutableArray *groupArray;

@end

@implementation BFMyGroupPurchaseController

- (NSMutableArray *)groupArray {
    if (!_groupArray) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

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

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的拼团";
    //添加tableView;
    [self tableView];
    //请求数据
    [self getData];
}

#pragma mark -- 请求数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=team_order"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFProgressHUD MBProgressFromView:self.view andLabelText:@"正在请求..."];
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        NSArray *array = [BFMyGroupPurchaseModel mj_objectArrayWithKeyValuesArray:responseObject[@"team"]];
        [self.groupArray addObjectsFromArray:array];
        BFLog(@"我的订单%@,,%@",responseObject, self.groupArray);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BFLog(@"error:%@",error);
    }];
}

#pragma mark -- tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BFLog(@"%lu",(unsigned long)self.groupArray.count);
    return self.groupArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyGroupPurchaseCell *cell = [BFMyGroupPurchaseCell cellWithTableView:tableView];
    cell.model = self.groupArray[indexPath.row];
    cell.delegate = self;
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
