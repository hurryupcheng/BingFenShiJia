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
@end

@implementation BFRecommendOrderCommissionController

#pragma mark -- 懒加载

- (BFMyAdvertisingExpenseTabbar *)myTabbar {
    if (!_myTabbar) {
        _myTabbar = [[BFMyAdvertisingExpenseTabbar alloc] initWithFrame: CGRectMake(0, ScreenHeight-160, ScreenWidth, 46)];
        _myTabbar.delegate = self;
        [self.view addSubview:_myTabbar];
        //_myTabbar.backgroundColor = [UIColor blueColor];
    }
    return _myTabbar;
}

- (BFBottomHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFBottomHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        _headerView.delegate = self;
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (UITableView *)bottomTableView {
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth,ScreenHeight-204) style:UITableViewStylePlain];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_bottomTableView];
    }
    return _bottomTableView;
}

- (UITableView *)upTableView {
    if (!_upTableView) {
        _upTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight-204) style:UITableViewStylePlain];
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
    self.view.backgroundColor = [UIColor redColor];
    BFLog(@"%@", NSStringFromCGRect(self.view.frame));
    self.headerView.timeLabel.text = [self.dateArray firstObject];
    //添加底部tableView
    [self bottomTableView];
    //添加上面tableView
    [self upTableView];
    //可以点击的头部
    //[self headerView];
    //底部固定视图
    [self myTabbar];
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
//        [UIView animateWithDuration:0.5 animations:^{
//            self.bottomTableView.y = 94;
//            self.upTableView.y = ScreenHeight;
//            self.myTabbar.y = ScreenHeight -110;
//            self.headerView.y = 50;
//        }];
        self.upTableView.hidden = YES;
        self.bottomTableView.hidden = NO;
    }else {
//        [UIView animateWithDuration:0.5 animations:^{
//            self.bottomTableView.y = 160-ScreenHeight;
//            self.upTableView.y = 94;
//            self.myTabbar.y = ScreenHeight;
//            self.headerView.y = 0;
//        }];
        self.upTableView.hidden = NO;
        self.bottomTableView.hidden = YES;
    }
}


#pragma mark -- tableView方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.upTableView) {
        return self.dateArray.count;
    }else {
        return 10;
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
            return cell;
        }else {
            BFInstructionCell *cell = [BFInstructionCell cellWithTableView:tableView];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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


@end
