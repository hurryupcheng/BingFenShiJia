//
//  BFCustomerOrderCommissionController.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFCustomerOrderCommissionController.h"
#import "BFGetYearAndMonth.h"
#import "BFUpYearAndMonthCell.h"
#import "BFBottomHeaderView.h"
#import "BFMyAdvertisingExpenseTabbar.h"
#import "BFWithdrawCashView.h"
#import "BFCustomerIntroduceCell.h"
#import "BFCustomerOrderCell.h"
#import "BFCustmorOrderModel.h"


@interface BFCustomerOrderCommissionController ()<UITableViewDelegate, UITableViewDataSource, BFBottomHeaderViewDelegate, BFMyAdvertisingExpenseTabbarDelegate>
/**底部tableView*/
@property (nonatomic, strong) UITableView *bottomTableView;
/**上面tableView*/
@property (nonatomic, strong) UITableView *upTableView;
/**年月数组*/
@property (nonatomic, strong) NSArray *dateArray;
/**区头*/
@property (nonatomic, strong) BFBottomHeaderView *headerView;
/**自定义tabbar*/
@property (nonatomic, strong) BFMyAdvertisingExpenseTabbar *myTabbar;
/**客户订单模型*/
@property (nonatomic, strong) BFCustmorOrderModel *model;
/**推荐分成订单可变数组*/
@property (nonatomic, strong) NSMutableArray *customerArray;
/**分页*/
@property (nonatomic, assign) NSInteger page;
@end

@implementation BFCustomerOrderCommissionController

#pragma mark -- 懒加载

- (NSMutableArray *)customerArray {
    if (!_customerArray) {
        _customerArray  = [NSMutableArray array];
    }
    return _customerArray;
}

- (BFMyAdvertisingExpenseTabbar *)myTabbar {
    if (!_myTabbar) {
        _myTabbar = [[BFMyAdvertisingExpenseTabbar alloc] initWithFrame: CGRectMake(0, ScreenHeight-114, ScreenWidth, 46)];
        _myTabbar.delegate = self;
        [self.view addSubview:_myTabbar];
        //_myTabbar.backgroundColor = [UIColor blueColor];
    }
    return _myTabbar;
}

- (BFBottomHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFBottomHeaderView alloc] initWithFrame:CGRectMake(0, -44, ScreenWidth, 44)];
        _headerView.delegate = self;
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (UITableView *)bottomTableView {
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 204-ScreenHeight, ScreenWidth,ScreenHeight-204) style:UITableViewStylePlain];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_bottomTableView];
    }
    return _bottomTableView;
}

- (UITableView *)upTableView {
    if (!_upTableView) {
        _upTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenHeight-114, ScreenWidth, ScreenHeight-204) style:UITableViewStylePlain];
        _upTableView.delegate = self;
        _upTableView.dataSource = self;
        //_upTableView.hidden = YES;
        [self.view addSubview:_upTableView];
        _upTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _upTableView;
}


- (NSArray *)dateArray {
    if (!_dateArray) {
        _dateArray = [BFGetYearAndMonth getTenMonthBeforeTheCurrentTime];
    }
    return _dateArray;
}


#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.page = 1;
    //BFLog(@"%@", NSStringFromCGRect(self.view.frame));
    self.headerView.timeLabel.text = [self.dateArray firstObject];
    //添加底部tableView
    [self bottomTableView];
    //添加上面tableView
    [self upTableView];
    //可以点击的头部
    //[self headerView];
    //底部固定视图
    [self myTabbar];
    //获取数据
    //[self getCustomerOrderData];
    //上啦刷新
    [self setupUpRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.headerView.timeLabel.text = [self.dateArray firstObject];
    [self.customerArray removeAllObjects];
    [self.bottomTableView reloadData];
    //获取数据
    [self getCustomerOrderData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomTableView.y = 204-ScreenHeight;
        //self.upTableView.y = 44;
        self.myTabbar.y = ScreenHeight -114;
        self.headerView.y = -44;
        
    }];
}

#pragma mark --上啦刷新
- (void)setupUpRefresh {
    self.bottomTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadMoreData {
    self.page++;
    if (self.model.page_num <= 5) {
        if (self.page > self.model.page_num) {
            //self.page--;
            [self.bottomTableView.mj_footer endRefreshing];
            [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,没有更多订单了哦!"];
            return;
        }else {
            [self getUpRefreshData:self.headerView.timeLabel.text];
        }
    }else {
        if (self.page > 5) {
            //self.page--;
            [self.bottomTableView.mj_footer endRefreshing];
            [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,没有更多订单了哦!"];
            return;
        }else {
            [self getUpRefreshData:self.headerView.timeLabel.text];
        }
    }
}

- (void)getUpRefreshData:(NSString *)date {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_commission"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"year"] = [date substringWithRange:NSMakeRange(0, 4)];
    parameter[@"month"] = [date substringWithRange:NSMakeRange(5, 2)];
    parameter[@"page"] = @(self.page);
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        BFLog(@"++++%@,,%@", responseObject, parameter);
        if (responseObject) {
            self.model =  [BFCustmorOrderModel parse:responseObject];
            if ([responseObject[@"proxy_order"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFCustomerOrderList parse:self.model.proxy_order];
                //BFLog(@"-----%@", array);
                if (array.count == 0) {
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有订单哦!"];
                }else {
                    //BFLog(@"-----%@", array);
                    [self.customerArray addObjectsFromArray:array];
                }

            }else {
                [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有订单哦!"];
            }
            //self.myTabbar.custmorOrderModel = self.model;
        }
        double delayInSeconds = 0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.bottomTableView reloadData];
            [self.bottomTableView.mj_footer endRefreshing];
        });
        
    } failure:^(NSError *error) {
        self.page--;
        [self.bottomTableView.mj_footer endRefreshing];
        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
        BFLog(@"--%@", error);
    }];

}

#pragma mark --获取推荐分成订单数据
- (void)getCustomerOrderData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_commission"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"page"] = @(self.page);
//    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading..." dispatch_get_global_queue:^{
//        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
//    } dispatch_get_main_queue:^{
    [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"++++%@,,%@", responseObject, parameter);
            if (responseObject) {
                self.model =  [BFCustmorOrderModel parse:responseObject];
                if ([responseObject[@"proxy_order"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = [BFCustomerOrderList parse:self.model.proxy_order];
                    if (array.count == 0) {
                        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有订单哦!"];
                    }else {
                        //BFLog(@"-----%@", array);
                        [self.customerArray addObjectsFromArray:array];
                    }
                }else {
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有订单哦!"];
                }
                self.myTabbar.custmorOrderModel = self.model;
            }
            
            double delayInSeconds = 0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [hud hideAnimated:YES];
                [self.bottomTableView reloadData];
                if (!self.headerView.clickButton.selected) {
                    [self.headerView click];
                }
                
                [UIView animateWithDuration:0.5 animations:^{
                    self.bottomTableView.y = 44;
                    self.myTabbar.y = ScreenHeight -160;
                    self.headerView.y = 0;
                }];
            });
            
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
            [hud hideAnimated:YES];
            BFLog(@"--%@", error);
        }];
    }];
}


#pragma mark --BFMyAdvertisingExpenseTabbar代理方法
- (void)howToWithdrawCash {
    BFLog(@"----");
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    BFWithdrawCashView *withdrawCashView = [BFWithdrawCashView creatWithdrawCashView];
    [window addSubview:withdrawCashView];
}


#pragma mark --BFBottomHeaderView代理方法
- (void)clickToChangeStatus:(UIButton *)button {
    BFLog(@"-------%d",button.selected);
    if (button.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            //self.bottomTableView.y = 44;
            self.upTableView.y = ScreenHeight-114;
            self.myTabbar.y = ScreenHeight -160;
            self.headerView.y = 0;
            
        }];
        //        self.upTableView.hidden = YES;
        //        self.bottomTableView.hidden = NO;
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomTableView.y = 204-ScreenHeight;
            self.upTableView.y = 44;
            self.myTabbar.y = ScreenHeight -114;
            self.headerView.y = -44;
        }];
        //        self.upTableView.hidden = NO;
        //        self.bottomTableView.hidden = YES;
    }
}



#pragma mark -- tableView方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.upTableView) {
        return self.dateArray.count;
    }else {
        return self.customerArray.count+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        BFUpYearAndMonthCell *cell = [BFUpYearAndMonthCell cellWithTableView:tableView];
        cell.yearAndMonth.text = self.dateArray[indexPath.row];
        return cell;
    }else {
        if (indexPath.row == 0) {
            BFCustomerIntroduceCell *cell = [BFCustomerIntroduceCell cellWithTableView:tableView];
            cell.model = self.model;
            return cell;
        }else {
            BFCustomerOrderCell *cell = [BFCustomerOrderCell cellWithTableView:tableView];
            cell.model = self.customerArray[indexPath.row-1];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.upTableView) {
        //[self.headerView click];
        [self.customerArray removeAllObjects];
        [self.bottomTableView reloadData];
        self.page = 1;
        self.headerView.timeLabel.text = self.dateArray[indexPath.row];
        [self getCustomerOrderData:self.dateArray[indexPath.row]];
        
    }
    
}

- (void)getCustomerOrderData:(NSString *)date {
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_commission"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"year"] = [date substringWithRange:NSMakeRange(0, 4)];
    parameter[@"month"] = [date substringWithRange:NSMakeRange(5, 2)];
    parameter[@"page"] = @(self.page);
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        BFLog(@"++++%@,,%@", responseObject, parameter);
        if (responseObject) {
            self.model =  [BFCustmorOrderModel parse:responseObject];
            if ([responseObject[@"proxy_order"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFCustomerOrderList parse:self.model.proxy_order];
                if (array.count == 0) {
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有订单哦!"];
                }else {
                    //BFLog(@"-----%@", array);
                    [self.customerArray addObjectsFromArray:array];
                }
            }else {
                [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有订单哦!"];
            }
            self.myTabbar.custmorOrderModel = self.model;
        }
        double delayInSeconds = 0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.headerView click];
            [self.bottomTableView reloadData];
            
            [UIView animateWithDuration:0.5 animations:^{
                self.bottomTableView.y = 44;
                self.myTabbar.y = ScreenHeight -160;
                self.headerView.y = 0;
            }];
        });
        
    } failure:^(NSError *error) {

        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
        BFLog(@"--%@", error);
    }];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        return 44;
    }else {
        if (indexPath.row == 0) {
            return BF_ScaleHeight(120);
        }else {
            return BF_ScaleFont(110);
        }
    }
}




@end
