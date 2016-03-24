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
@property (nonatomic, strong) NSMutableArray *dateArray;
/**参数字典*/
@property (nonatomic, strong) NSMutableDictionary *parameter;
/**BFCommissionModel*/
@property (nonatomic, strong) BFCommissionModel *model;
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

- (NSMutableArray *)dateArray {
    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
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
        _upTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 94, ScreenWidth, ScreenHeight-210) style:UITableViewStylePlain];
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
    //添加分段控制器
    [self segment];
    //进入页面点击分段控制器第一个
    self.segment.segmented.selectedSegmentIndex = 1;
    [self.segment click];
    //添加底部tableView
    [self bottomTableView];
    //添加上面tableView
    [self upTableView];
    //获取数据
    [self getData];
    //底部固定视图
    [self myTabbar];

}


- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=year_month"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFProgressHUD MBProgressFromView:self.view LabelText:@"正在请求..." dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            if (responseObject) {
                NSArray *array = [BFDateModel parse:responseObject];
                [self.dateArray addObjectsFromArray:array];
                BFLog(@"%lu",(unsigned long)self.dateArray.count);
            }
            [self.upTableView reloadData];
            BFLog(@"%@",responseObject);
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
            
            [self tableView:self.upTableView didSelectRowAtIndexPath:path];
            [self tableView:self.upTableView didSelectRowAtIndexPath:path];
            [self animation];
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络异常"];
            BFLog(@"%@", error);
        }];
    }];

}

- (void)animation {
    
}

#pragma mark --BFSegmentView代理方法
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:{
            
            BFLog(@"VIP订单");
            break;
        }
        case 1:
            BFLog(@"客户订单");
            break;
        case 2:
            BFLog(@"推荐分成订单");
            break;
    }
}







#pragma mark -- 创建固定的头部视图


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.upTableView) {
        return self.dateArray.count;
    }else {
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.upTableView) {
        BFUpYearAndMonthCell *cell = [BFUpYearAndMonthCell cellWithTableView:tableView];
        cell.model = self.dateArray[indexPath.row];
        self.dateCell = cell;
        return cell;
    }else {
        if (indexPath.row == 0) {
            BFBottomHeaderCell *cell = [BFBottomHeaderCell cellWithTabelView:tableView];
            self.headerCell = cell;
            cell.delegate = self;
            return cell;
        } else if (indexPath.row == 1) {
            BFAdvertisingExpenseInformationCell *cell = [BFAdvertisingExpenseInformationCell cellWithTableView:tableView];
            self.cell = cell;
            return cell;
        }
        else {
            BFCustomerOrderCell*cell = [BFCustomerOrderCell cellWithTableView:tableView];
    
            return cell;
            
            
        }
        
        
    }
}

#pragma mark --BFBottomHeaderCellDelegate方法
- (void)clickToChangeStatus:(UIButton *)button {
    if (button.selected == YES) {
        self.upTableView.hidden = YES;
    }else {
        self.upTableView.hidden = NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        BFDateModel *model = self.dateArray[indexPath.row];
        self.headerCell.timeLabel.text = [NSString stringWithFormat:@"%ld年%@月",(long)model.year, model.month];
        [self getMyClientData:model];
        [self.headerCell click];
        self.upTableView.hidden = YES;
        [self.bottomTableView reloadData];
        
    }else {
        if (indexPath.row == 0) {
            self.upTableView.hidden = NO;
        }
        
    }
}

- (void)getMyClientData:(BFDateModel *)model {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_commission"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    self.parameter[@"year"] = @(model.year);
    self.parameter[@"month"] = model.month;
    
    [BFHttpTool GET:url params:self.parameter success:^(id responseObject) {
        
        
        self.model = [BFCommissionModel parse:responseObject];
        self.cell.model = self.model;
        
        BFLog(@"%@,%@",responseObject,self.parameter);
        [self.upTableView reloadData];
    
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络异常"];
        BFLog(@"%@", error);
    }];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        return BF_ScaleHeight(44);
    }else {
        if (indexPath.row == 0) {
            return BF_ScaleHeight(44);
        }else if (indexPath.row == 1){
            return BF_ScaleHeight(135);
        }else {
            return BF_ScaleHeight(140);
        }
    }
}

@end
