//
//  BFWithdrawalRecordController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFWithdrawalRecordController.h"
#import "BFWithdrawalRecordCell.h"
#import "BFWithdrawalRecordModel.h"

@interface BFWithdrawalRecordController ()<UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**提现记录数组*/
@property (nonatomic, strong) NSMutableArray *recordArray;
/**提现记录模型*/
@property (nonatomic, strong) BFWithdrawalRecordModel *model;
/**提现记录模型*/
@property (nonatomic, assign) NSInteger page;
/**判断是不是第一次加载数据*/
@property (nonatomic, assign) BOOL isFirstTime;
@end

@implementation BFWithdrawalRecordController

#pragma mark -- 懒加载


- (NSMutableArray *)recordArray {
    if (!_recordArray) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
}

- (UITableView *)tableView {
    if (!_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64-ScreenHeight, ScreenWidth, ScreenHeight-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BFColor(0xECECEC);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xECECEC);
    self.title = @"提现记录";
    self.page = 1;
    self.isFirstTime = YES;
    //添加tableView
    [self tableView];
    //加载数据
    [self getData];
    //上啦加载数据
    [self setupUpRefresh];
}

#pragma mark -- 上啦加载数据
- (void)setupUpRefresh {
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadMoreData {
    self.page++;
    if (self.page > self.model.page_num) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"没有更多数据"];
        return;
    }
    [self getData];
}

#pragma mark -- 加载数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=withdraw_detail"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"page"] = @(self.page);
    if (self.isFirstTime) {
        [BFProgressHUD MBProgressFromView:self.view LabelText:@"正在请求..." dispatch_get_main_queue:^{
            [BFHttpTool POST:url params:parameter success:^(id responseObject) {
                BFLog(@"----%@,,%@", responseObject,parameter);
                if (responseObject) {
                    self.model = [BFWithdrawalRecordModel parse:responseObject];
                    NSArray *array = [BFWithdrawalRecordList parse:self.model.withdraw_detail];
                    [self.recordArray addObjectsFromArray:array];
                }
                [self.tableView reloadData];
                
                [UIView animateWithDuration:0.5 animations:^{
                    self.tableView.y = 0;
                }];
                [self.tableView.mj_footer endRefreshing];
                self.isFirstTime = NO;
            } failure:^(NSError *error) {
                self.page--;
                [self.tableView.mj_footer endRefreshingWithNoNoHTTP];
                BFLog(@"%@", error);
            }];
            
        }];

    }else {
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"----%@,,%@", responseObject,parameter);
            if (responseObject) {
                self.model = [BFWithdrawalRecordModel parse:responseObject];
                NSArray *array = [BFWithdrawalRecordList parse:self.model.withdraw_detail];
                [self.recordArray addObjectsFromArray:array];
            }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSError *error) {
            self.page--;
            [self.tableView.mj_footer endRefreshingWithNoNoHTTP];
            BFLog(@"%@", error);
        }];

    }

}


#pragma mark -- tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recordArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFWithdrawalRecordCell *cell = [BFWithdrawalRecordCell cellWithTableView:tableView];
    cell.model = self.recordArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(60);
}





@end
