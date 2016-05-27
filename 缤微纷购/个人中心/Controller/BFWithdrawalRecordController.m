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
//返回顶部按钮
@property (nonatomic, strong) UIButton *TopButton;
//偏移量
@property (nonatomic, assign) CGFloat contentOffSetY;
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
        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,没有更多提现记录了哦!"];
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
        [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
            [BFHttpTool POST:url params:parameter success:^(id responseObject) {
                BFLog(@"----%@,,%@", responseObject,parameter);
                if (responseObject) {
                    [hud hideAnimated:YES];
                    if ([responseObject[@"withdraw_detail"] isKindOfClass:[NSArray class]]) {
                        self.model = [BFWithdrawalRecordModel parse:responseObject];
                        NSArray *array = [BFWithdrawalRecordList parse:self.model.withdraw_detail];
                        if (array.count != 0) {
                            [self.recordArray addObjectsFromArray:array];
                        }else {
                            [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有提现记录哦!"];
                        }
                    } else {
                        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有提现记录哦!"];
                    }
                }
                [self.tableView reloadData];
                
                [UIView animateWithDuration:0.5 animations:^{
                    self.tableView.y = 0;
                }];
                [self.tableView.mj_footer endRefreshing];
                self.isFirstTime = NO;
            } failure:^(NSError *error) {
                self.page--;
                [hud hideAnimated:YES];
                [self.tableView.mj_footer endRefreshing];
                [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"网络问题,请求失败"];
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
            [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"网络问题,请求失败"];
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

#pragma mark -- 添加返回顶部的按钮
- (UIButton *)TopButton{
    if (!_TopButton) {
        _TopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _TopButton.frame = CGRectMake(ScreenWidth - BF_ScaleWidth(60),ScreenHeight-BF_ScaleHeight(150), BF_ScaleWidth(50), BF_ScaleWidth(50));
        _TopButton.layer.cornerRadius = BF_ScaleWidth(25);
        _TopButton.layer.masksToBounds = YES;
        _TopButton.backgroundColor = BFColor(0x1dc3ff);
        [_TopButton setTitle:@"TOP" forState:UIControlStateNormal];
        [self.TopButton addTarget:self action:@selector(TopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TopButton;
}
- (void)TopButtonAction:(UIButton *)sender{
    
    self.tableView.contentOffset = CGPointMake(0, 0);
    
    [self.TopButton removeFromSuperview];
}
//开始拖动scrollV
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _contentOffSetY = scrollView.contentOffset.y;
}

//只要偏移量发生改变就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currcontentOffSetY = scrollView.contentOffset.y;
    if (_contentOffSetY > currcontentOffSetY && currcontentOffSetY > 0) {
        [self.view addSubview:self.TopButton];
        //        [self.view bringSubviewToFront:self.TopButton];
    }else{
        [self.TopButton removeFromSuperview];
    }
}



@end
