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
        _upTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50+ScreenHeight, ScreenWidth, ScreenHeight-210) style:UITableViewStylePlain];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当月广告费";
    self.view.backgroundColor = BFColor(0xffffff);
    
    //添加底部tableView
    [self bottomTableView];
    //添加上面tableView
    [self upTableView];
    //获取数据
    
    //底部固定视图
    [self myTabbar];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //添加分段控制器
    [self segment];
    //进入页面点击分段控制器第一个
    self.segment.segmented.selectedSegmentIndex = 1;
    [self.segment click];
}


- (void)getMyClientData:(NSString *)date {
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *year = [date substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_commission"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    self.parameter[@"year"] = year;
    self.parameter[@"month"] = month;
    BFLog(@"++++++%@,%@",url,self.parameter);
    [BFHttpTool GET:url params:self.parameter success:^(id responseObject) {
        if (responseObject) {
            [self.proxyOrderArray removeAllObjects];
            self.commissionModel = [BFCommissionModel parse:responseObject];
            NSArray *array = [ProxyOrderList parse:self.commissionModel.proxy_order];
            [self.proxyOrderArray addObjectsFromArray:array];
            self.cell.model = self.commissionModel;
        }
        if (!date) {
             self.dateCell.yearAndMonth.text = [self.dateArray firstObject];
        }
        [self.bottomTableView reloadData];
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomTableView.y = 50;
        }];
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络异常"];
        BFLog(@"%@", error);
    }];
    
}

- (void)getData:(NSString *)date {
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *year = [date substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_recom"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    self.parameter[@"year"] = year;
    self.parameter[@"month"] = month;
    BFLog(@"--------%@,%@",url,self.parameter);
    [BFHttpTool GET:url params:self.parameter success:^(id responseObject) {
        if (responseObject) {
            [self.proxyOrderArray removeAllObjects];
            self.recommendDividedmodel = [BFRecommendDividedModel parse:responseObject];
            NSArray *array = [RecommendDividedList parse:self.recommendDividedmodel.recom_data];
            [self.proxyOrderArray addObjectsFromArray:array];
            //self.cell.model = self.recommendDividedmodel;
        }
        BFLog(@"%@,%lu",responseObject,(unsigned long)self.proxyOrderArray.count);
        if (!date) {
            self.dateCell.yearAndMonth.text = [self.dateArray firstObject];
             BFLog(@"------------------%@,%@",self.dateCell.yearAndMonth.text,[self.dateArray firstObject]);
        }
        [self.bottomTableView reloadData];
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomTableView.y = 50;
        }];
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络异常"];
        BFLog(@"%@", error);
    }];
    
}

- (void)animation {
    
}

#pragma mark --BFSegmentView代理方法
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomTableView.y = -ScreenHeight;
        if (self.upTableView.y == 50) {
            
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            [self tableView:self.upTableView didSelectRowAtIndexPath:index];
           
        }
    }];
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:{
            BFMyClientController *myClientVC = [[BFMyClientController alloc] init];
            [self.navigationController pushViewController:myClientVC animated:YES];
            BFLog(@"VIP订单");
            break;
        }
        case 1:{
            BFLog(@"客户订单");
            self.dateCell.yearAndMonth.text = [self.dateArray firstObject];
            [self getMyClientData:nil];
            break;
        } 
        case 2:{
            BFLog(@"推荐分成订单");
            self.dateCell.yearAndMonth.text = [self.dateArray firstObject];
            [self getData:nil];
            break;
        }
    }
}







#pragma mark -- 创建固定的头部视图


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.upTableView) {
        return self.dateArray.count;
    }else {
        return self.proxyOrderArray.count ;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.upTableView) {
        
        BFUpYearAndMonthCell *cell = [BFUpYearAndMonthCell cellWithTableView:tableView];
        self.dateCell = cell;
        cell.yearAndMonth.text = self.dateArray[indexPath.row];
        
        return cell;
    }else {
        if (self.segment.segmented.selectedSegmentIndex == 1) {
            if (indexPath.row == 0) {
                BFBottomHeaderCell *cell = [BFBottomHeaderCell cellWithTabelView:tableView];
                if (!cell.timeLabel.text) {
                    cell.timeLabel.text = self.dateArray[indexPath.row];
                }
                cell.delegate = self;
                self.headerCell = cell;
                
                return cell;
            } else if (indexPath.row == 1) {
                BFAdvertisingExpenseInformationCell *cell = [BFAdvertisingExpenseInformationCell cellWithTableView:tableView];
                self.cell = cell;
                return cell;
            }
            else {
                BFCustomerOrderCell*cell = [BFCustomerOrderCell cellWithTableView:tableView];
                cell.model = self.proxyOrderArray[indexPath.row];
                return cell;
                
                
            }

        }else if (self.segment.segmented.selectedSegmentIndex == 2 ) {
            if (indexPath.row == 0) {
                BFBottomHeaderCell *cell = [BFBottomHeaderCell cellWithTabelView:tableView];
                if (!cell.timeLabel.text) {
                    cell.timeLabel.text = self.dateArray[indexPath.row];
                }
                cell.delegate = self;
                self.headerCell = cell;
                
                return cell;
            } else if (indexPath.row == 1) {
                BFRecommendDividedCell *cell = [BFRecommendDividedCell cellWithTableView:tableView];
                
                return cell;
            }
            else {
                BFInstructionCell *cell = [BFInstructionCell cellWithTableView:tableView];
                cell.model = self.proxyOrderArray[indexPath.row];
                return cell;
            }

        }else {
            return [[UITableViewCell alloc] init];
        }
        
    }
}

#pragma mark --BFBottomHeaderCellDelegate方法
- (void)clickToChangeStatus:(UIButton *)button {
    if (button.selected == YES) {
        //self.upTableView.hidden = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.upTableView.y = 50+ScreenHeight;
        }];
    }else {
        //self.upTableView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.upTableView.y = 50;
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.upTableView) {
        self.dateCell.yearAndMonth.text = self.dateArray[indexPath.row];
        
        self.headerCell.timeLabel.text = self.dateCell.yearAndMonth.text;
        BFLog(@"----%@--%@",self.dateCell.yearAndMonth.text,self.headerCell.timeLabel.text);
        if (self.segment.segmented.selectedSegmentIndex == 1) {
            [self getMyClientData:self.dateCell.yearAndMonth.text];
        }else if (self.segment.segmented.selectedSegmentIndex == 2) {
            [self getData:self.dateCell.yearAndMonth.text];
        }
        [self.headerCell click];
        [UIView animateWithDuration:0.5 animations:^{
            self.upTableView.y = 50+ScreenHeight;
        }];
        [self.bottomTableView reloadData];
        
    }else {
        if (indexPath.row == 0) {
            if (self.upTableView.y == 94) {
                
            }else {
                [UIView animateWithDuration:0.5 animations:^{
                    self.upTableView.y = 50;
                }];
            }
            
        }
        
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        return BF_ScaleHeight(44);
    }else {
        if (self.segment.segmented.selectedSegmentIndex == 1){
            if (indexPath.row == 0) {
                return BF_ScaleHeight(44);
            }else if (indexPath.row == 1){
                return BF_ScaleHeight(135);
            }else {
                return BF_ScaleHeight(140);
            }
        }else if (self.segment.segmented.selectedSegmentIndex == 2) {
            if (indexPath.row == 0) {
                return BF_ScaleHeight(44);
            }else if (indexPath.row == 1){
                return BF_ScaleHeight(95);
            }else {
                return BF_ScaleHeight(110);
            }
        }else {
            return 0;
        }
    }
}

@end
