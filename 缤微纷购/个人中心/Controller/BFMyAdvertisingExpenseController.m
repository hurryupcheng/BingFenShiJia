//
//  BFAdvertisingExpenseController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyAdvertisingExpenseController.h"
#import "BFMyAdvertisingExpenseSectionView.h"
#import "BFMyAdvertisingExpenseModel.h"
#import "BFInstructionCell.h"
#import "BFAdvertisingExpenseInformationCell.h"
#import "BFPersonInformationController.h"
#import "BFMyAdvertisingExpenseTabbar.h"
#import "BFBottomHeaderCell.h"
#import "BFUpYearAndMonthCell.h"
#import "BFCustomerOrderCell.h"
#import "BFDateModel.h"
#import "BFCommissionModel.h"
#import "BFMyClientController.h"
#import "BFGetYearAndMonth.h"
#import "BFRecommendDividedCell.h"
#import "BFRecommendDividedModel.h"


@interface BFMyAdvertisingExpenseController ()<UITableViewDelegate, UITableViewDataSource, SectionHeaderViewDelegate, BFBottomHeaderCellDelegate, BFSegmentViewDelegate>

/**底部tableView*/
@property (nonatomic, strong) UITableView *bottomTableView;
/**上面tableView*/
@property (nonatomic, strong) UITableView *upTableView;
/**自定义tabbar*/
@property (nonatomic, strong) BFMyAdvertisingExpenseTabbar *myTabbar;
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;
/**底部头cell*/
@property (nonatomic, strong) BFBottomHeaderCell *headerCell;
/**_upTableView的cell*/
@property (nonatomic, strong) BFUpYearAndMonthCell *dateCell;
/**年月数组*/
@property (nonatomic, strong) NSArray *dateArray;
/**客户订单数组*/
@property (nonatomic, strong) NSMutableArray *proxyOrderArray;
/**参数字典*/
@property (nonatomic, strong) NSMutableDictionary *parameter;
/**BFCommissionModel*/
@property (nonatomic, strong) BFCommissionModel *commissionModel;
/**BFCommissionModel*/
@property (nonatomic, strong) BFRecommendDividedModel *recommendDividedmodel;
/**_upTableView的cell*/
@property (nonatomic, strong) BFAdvertisingExpenseInformationCell *cell;

@end

@implementation BFMyAdvertisingExpenseController

- (NSMutableDictionary *)parameter {
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionary];
    }
    return _parameter;
}


- (BFMyAdvertisingExpenseTabbar *)myTabbar {
    if (!_myTabbar) {
        _myTabbar = [BFMyAdvertisingExpenseTabbar myTabbar];
        //_myTabbar.model = self.user;
        [self.view addSubview:_myTabbar];
        //_myTabbar.backgroundColor = [UIColor blueColor];
    }
    return _myTabbar;
}

- (NSMutableArray *)proxyOrderArray {
    if (!_proxyOrderArray) {
        _proxyOrderArray = [NSMutableArray array];
    }
    return _proxyOrderArray;
}

- (NSArray *)dateArray {
    if (!_dateArray) {
        _dateArray = [BFGetYearAndMonth getTenMonthBeforeTheCurrentTime];
    }
    return _dateArray;
}

- (UITableView *)bottomTableView {
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-166) style:UITableViewStylePlain];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_bottomTableView];
        
        
    }
    return _bottomTableView;
}

- (UITableView *)upTableView {
    if (!_upTableView) {
        _upTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-166) style:UITableViewStylePlain];
        _upTableView.delegate = self;
        _upTableView.dataSource = self;
        [self.view addSubview:_upTableView];
        _upTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _upTableView;
}

- (BFSegmentView *)segment {
    if (!_segment) {
        _segment = [BFSegmentView segmentView];
        _segment.delegate = self;
        _segment.titleArray = @[@"VIP订单", @"客户订单", @"推荐分成订单"];
        [self.view addSubview:_segment];
    }
    return _segment;
}
#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当月广告费";
    self.view.backgroundColor = BFColor(0xffffff);
    
    //添加底部tableView
    [self bottomTableView];
    //添加上面tableView
    [self upTableView];
    //底部固定视图
    [self myTabbar];

}
#pragma mark --viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //添加分段控制器
    [self segment];
    //进入页面点击分段控制器第一个
    self.segment.segmented.selectedSegmentIndex = 1;
    [self.segment click];
}


#pragma mark --viewWillAppear
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:{
            BFMyClientController *MyClientVC = [[BFMyClientController alloc] init];
            [self.navigationController pushViewController:MyClientVC animated:YES];
            break;
        }
        case 1:{
            
            break;
        }
        case 2: {
            
            break;
        }
            
    }
}

- (void)getCustomerOrder {

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        BFUpYearAndMonthCell *cell = [BFUpYearAndMonthCell cellWithTableView:tableView];
        cell.yearAndMonth.text = self.dateArray[indexPath.row];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"测试2324";
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        self.upTableView.hidden = YES;
        self.bottomTableView.hidden = NO;
    }else {
        if (indexPath.row == 0) {
            self.upTableView.hidden = NO;
            self.bottomTableView.hidden = YES;
        }
    }
}

@end
