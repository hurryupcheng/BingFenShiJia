//
//  BFRecommendOrderCommissionController.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFRecommendOrderCommissionController.h"
#import "BFGetYearAndMonth.h"
#import "BFUpYearAndMonthCell.h"
#import "BFBottomHeaderView.h"
#import "BFMyAdvertisingExpenseTabbar.h"
#import "BFWithdrawCashView.h"
#import "BFRecommendDividedCell.h"
#import "BFInstructionCell.h"
#import "BFRecommendDividedModel.h"

@interface BFRecommendOrderCommissionController ()<UITableViewDelegate, UITableViewDataSource, BFBottomHeaderViewDelegate, BFMyAdvertisingExpenseTabbarDelegate>
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
/**推荐分成订单模型*/
@property (nonatomic, strong) BFRecommendDividedModel *recommendDividedmodel;
/**推荐分成订单可变数组*/
@property (nonatomic, strong) NSMutableArray *recommendArray;
//返回顶部按钮
@property (nonatomic, strong) UIButton *TopButton;
//偏移量
@property (nonatomic, assign) CGFloat contentOffSetY;
@end

@implementation BFRecommendOrderCommissionController

#pragma mark -- 懒加载

- (NSMutableArray *)recommendArray {
    if (!_recommendArray) {
        _recommendArray = [NSMutableArray array];
    }
    return _recommendArray;
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
//    //获取数据
//    [self getRecommendDividedData:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.headerView.timeLabel.text = [self.dateArray firstObject];
    [self.recommendArray removeAllObjects];
    [self.bottomTableView reloadData];
    //获取数据
    [self getRecommendDividedData];
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

#pragma mark --获取推荐分成订单数据
- (void)getRecommendDividedData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_recom"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
//    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading..." dispatch_get_global_queue:^{
//        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
//    } dispatch_get_main_queue:^{
    [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"++++%@,,%@", responseObject, parameter);
            if (responseObject) {
                //[self.recommendArray removeAllObjects];
                self.recommendDividedmodel =  [BFRecommendDividedModel parse:responseObject];
                if ([responseObject[@"recom_data"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = [RecommendDividedList parse:self.recommendDividedmodel.recom_data];
                    if (array.count == 0) {
                        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有订单哦!"];
                    }else {
                        //BFLog(@"-----%@", array);
                        [self.recommendArray addObjectsFromArray:array];
                    }
                }else {
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有订单哦!"];
                }
                self.myTabbar.recommendDividedModel = self.recommendDividedmodel;
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
        return self.recommendArray.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        BFUpYearAndMonthCell *cell = [BFUpYearAndMonthCell cellWithTableView:tableView];
        cell.yearAndMonth.text = self.dateArray[indexPath.row];
        return cell;
    }else {
        if (indexPath.row == 0) {
            BFRecommendDividedCell *cell = [BFRecommendDividedCell cellWithTableView:tableView];
            cell.model = self.recommendDividedmodel;
            return cell;
        }else {
            BFInstructionCell *cell = [BFInstructionCell cellWithTableView:tableView];
            cell.model = self.recommendArray[indexPath.row-1];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.upTableView) {
        
        [self.recommendArray removeAllObjects];
        [self.bottomTableView reloadData];
        self.headerView.timeLabel.text = self.dateArray[indexPath.row];
        [self getRecommendDividedData:self.dateArray[indexPath.row]];

    }
    
}


#pragma mark --获取推荐分成订单数据
- (void)getRecommendDividedData:(NSString *)date {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_recom"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"year"] = [date substringWithRange:NSMakeRange(0, 4)];
    [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        BFLog(@"++++%@,,%@", responseObject, parameter);
        if (responseObject) {
            //[self.recommendArray removeAllObjects];
            self.recommendDividedmodel =  [BFRecommendDividedModel parse:responseObject];
            if ([responseObject[@"recom_data"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [RecommendDividedList parse:self.recommendDividedmodel.recom_data];
                if (array.count == 0) {
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有订单哦!"];
                }else {
                    //BFLog(@"-----%@", array);
                    [self.recommendArray addObjectsFromArray:array];
                }
            }else {
                [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有订单哦!"];
            }
            self.myTabbar.recommendDividedModel = self.recommendDividedmodel;
        }
        
    
        double delayInSeconds = 0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.headerView click];
            [hud hideAnimated:YES];
            [self.bottomTableView reloadData];
            [UIView animateWithDuration:0.5 animations:^{
                self.bottomTableView.y = 44;
                self.myTabbar.y = ScreenHeight -160;
                self.headerView.y = 0;
            }];
        });
        
    } failure:^(NSError *error) {
        [hud hideAnimated:YES];
        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
        BFLog(@"--%@", error);
    }];
        }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        return 44;
    }else {
        if (indexPath.row == 0) {
            return BF_ScaleHeight(100);
        }else {
            return BF_ScaleFont(110);
        }
    } 
}

#pragma mark -- 添加返回顶部的按钮
- (UIButton *)TopButton{
    if (!_TopButton) {
        _TopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _TopButton.frame = CGRectMake(ScreenWidth - BF_ScaleWidth(60),ScreenHeight-BF_ScaleHeight(220), BF_ScaleWidth(50), BF_ScaleWidth(50));
        _TopButton.layer.cornerRadius = BF_ScaleWidth(25);
        _TopButton.layer.masksToBounds = YES;
        _TopButton.backgroundColor = BFColor(0x1dc3ff);
        [_TopButton setTitle:@"TOP" forState:UIControlStateNormal];
        [self.TopButton addTarget:self action:@selector(TopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TopButton;
}
- (void)TopButtonAction:(UIButton *)sender{
    
    self.bottomTableView.contentOffset = CGPointMake(0, 0);
    
    [self.TopButton removeFromSuperview];
}
//开始拖动scrollV
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _contentOffSetY = scrollView.contentOffset.y;
}

//只要偏移量发生改变就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currcontentOffSetY = scrollView.contentOffset.y;
    if (_contentOffSetY > currcontentOffSetY && currcontentOffSetY > ScreenHeight/2) {
        [self.view addSubview:self.TopButton];
        //        [self.view bringSubviewToFront:self.TopButton];
    }else{
        [self.TopButton removeFromSuperview];
    }
}

@end
