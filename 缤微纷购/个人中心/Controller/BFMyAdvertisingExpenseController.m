//
//  BFAdvertisingExpenseController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyAdvertisingExpenseController.h"
#import "BFInstructionCell.h"
#import "BFAdvertisingExpenseInformationCell.h"
#import "BFPersonInformationController.h"
#import "BFMyAdvertisingExpenseTabbar.h"
#import "BFUpYearAndMonthCell.h"
#import "BFCustomerOrderCell.h"
#import "BFCommissionModel.h"
#import "BFMyClientController.h"
#import "BFGetYearAndMonth.h"
#import "BFRecommendDividedCell.h"
#import "BFRecommendDividedModel.h"
#import "BFBottomHeaderView.h"
#import "BFCustomerServiceView.h"

@interface BFMyAdvertisingExpenseController ()<UITableViewDelegate, UITableViewDataSource, BFSegmentViewDelegate, BFBottomHeaderViewDelegate, BFCustomerServiceViewDelegate>

/**底部tableView*/
@property (nonatomic, strong) UITableView *bottomTableView;
/**上面tableView*/
@property (nonatomic, strong) UITableView *upTableView;
/**自定义tabbar*/
@property (nonatomic, strong) BFMyAdvertisingExpenseTabbar *myTabbar;
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;
/**年月数组*/
@property (nonatomic, strong) NSArray *dateArray;
/**客户订单数组*/
@property (nonatomic, strong) NSMutableArray *proxyOrderArray;
/**客户订单模型*/
@property (nonatomic, strong) BFCommissionModel *commissionModel;
/**推荐分成订单模型*/
@property (nonatomic, strong) BFRecommendDividedModel *recommendDividedmodel;
/**区头*/
@property (nonatomic, strong) BFBottomHeaderView *headerView;



@end

@implementation BFMyAdvertisingExpenseController

- (BFBottomHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFBottomHeaderView alloc] initWithFrame:CGRectMake(0, 6, ScreenWidth, 44)];
        _headerView.delegate = self;
        [self.view addSubview:_headerView];
    }
    return _headerView;
}


- (BFMyAdvertisingExpenseTabbar *)myTabbar {
    if (!_myTabbar) {
        _myTabbar = [[BFMyAdvertisingExpenseTabbar alloc] initWithFrame: CGRectMake(0, ScreenHeight, ScreenWidth, 46)];
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
        _bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160-ScreenHeight, ScreenWidth, ScreenHeight-210) style:UITableViewStylePlain];
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
        //_upTableView.hidden = YES;
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
    self.headerView.timeLabel.text = [self.dateArray firstObject];
    //添加navigationbar
    [self setUpNavigationBar];
    //添加底部tableView
    [self bottomTableView];
    //添加上面tableView
    [self upTableView];
    //可以点击的头部
    [self headerView];
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
    //[self.headerView click];
}


#pragma mark --BFSegmentView代理方法
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomTableView.y = 94-ScreenHeight;
        self.headerView.y = 0;
        self.myTabbar.y = ScreenHeight ;
    }];
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:{
            BFMyClientController *MyClientVC = [[BFMyClientController alloc] init];
            [self.navigationController pushViewController:MyClientVC animated:YES];
            break;
        }
        case 1:{
            BFLog(@"segmentView -- %d",self.headerView.clickButton.selected);
            self.headerView.timeLabel.text = [self.dateArray firstObject];
            [self getcommissionData:nil];
           
            break;
        }
        case 2: {
            BFLog(@"segmentView -- %d",self.headerView.clickButton.selected);
            self.headerView.timeLabel.text = [self.dateArray firstObject];
            [self getRecommendDividedData:nil];

            break;
        }
            
            
    }
}
#pragma mark --获取客户订单数据
- (void)getcommissionData:(NSString *)date {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_commission"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"year"] = [date substringWithRange:NSMakeRange(0, 4)];
    parameter[@"month"] = [date substringWithRange:NSMakeRange(5, 2)];
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        if (responseObject) {
            [self.proxyOrderArray removeAllObjects];
            self.commissionModel =  [BFCommissionModel parse:responseObject];
            NSArray *array = [ProxyOrderList parse:self.commissionModel.proxy_order];
            [self.proxyOrderArray addObjectsFromArray:array];
            self.myTabbar.commissionModel = self.commissionModel;
        }
        [self.bottomTableView reloadData];
        if (!self.headerView.clickButton.selected) {
            [self.headerView click];
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomTableView.y = 94;
            self.myTabbar.y = ScreenHeight -110;
            self.headerView.y = 50;
        }];
        //BFLog(@"--%@,,%@", responseObject,parameter);
    } failure:^(NSError *error) {
        BFLog(@"--%@", error);
    }];
    
}

#pragma mark --获取推荐分成订单数据
- (void)getRecommendDividedData:(NSString *)date {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_recom"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"year"] = [date substringWithRange:NSMakeRange(0, 4)];
    parameter[@"month"] = [date substringWithRange:NSMakeRange(5, 2)];
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        if (responseObject) {
            [self.proxyOrderArray removeAllObjects];
            self.recommendDividedmodel =  [BFRecommendDividedModel parse:responseObject];
            NSArray *array = [RecommendDividedList parse:self.recommendDividedmodel.recom_data];
            [self.proxyOrderArray addObjectsFromArray:array];
            self.myTabbar.recommendDividedModel = self.recommendDividedmodel;
        }
        [self.bottomTableView reloadData];
        if (!self.headerView.clickButton.selected) {
            [self.headerView click];
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomTableView.y = 94;
            self.myTabbar.y = ScreenHeight -110;
            self.headerView.y = 50;
        }];
        //BFLog(@"--%@,,%@", responseObject,parameter);
    } failure:^(NSError *error) {
        BFLog(@"--%@", error);
    }];
}


#pragma mark --BFBottomHeaderView代理方法
- (void)clickToChangeStatus:(UIButton *)button {
    BFLog(@"-------%d",button.selected);
    if (button.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomTableView.y = 94;
            self.upTableView.y = ScreenHeight;
            self.myTabbar.y = ScreenHeight -110;
            self.headerView.y = 50;
        }];
        //self.upTableView.hidden = YES;
        //self.bottomTableView.hidden = NO;
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomTableView.y = 160-ScreenHeight;
            self.upTableView.y = 94;
            self.myTabbar.y = ScreenHeight;
            self.headerView.y = 0;
        }];
        //self.upTableView.hidden = NO;
        //self.bottomTableView.hidden = YES;
    }
}


#pragma mark -- 设置客服按钮
- (void)setUpNavigationBar {
    UIButton *telephone = [UIButton buttonWithType:0];
    //telephone.backgroundColor = [UIColor redColor];
    telephone.width = 30;
    telephone.height = 30;
    [telephone addTarget:self action:@selector(telephone) forControlEvents:UIControlEventTouchUpInside];
    [telephone setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
    UIBarButtonItem *telephoneItem = [[UIBarButtonItem alloc] initWithCustomView:telephone];
    self.navigationItem.rightBarButtonItem = telephoneItem;
}

- (void)telephone {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    BFCustomerServiceView *customerServiceView = [BFCustomerServiceView createCustomerServiceView];
    customerServiceView.delegate = self;
    [window addSubview:customerServiceView];
}


#pragma mark --BFCustomerServiceViewDelegate
- (void)clickToChooseCustomerServiceWithType:(BFCustomerServiceViewButtonType)type {
    switch (type) {
        case BFCustomerServiceViewButtonTypeTelephone:{
            BFLog(@"点击电话客服");
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //添加取消按钮
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击");
            }];
            //添加电话按钮
            UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:@"020-38875719" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://020-38875719"]]];
            }];
            [alertC addAction:cancleAction];
            [alertC addAction:phoneAction];
            [self presentViewController:alertC animated:YES completion:nil];
            
            break;
        }
        case BFCustomerServiceViewButtonTypeWechat:
            BFLog(@"点击微信客服");
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"暂不支持，尽请期待"];
            break;
            
    }
}





#pragma mark --tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.upTableView) {
        return self.dateArray.count;
    }else {
        return self.proxyOrderArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        BFUpYearAndMonthCell *cell = [BFUpYearAndMonthCell cellWithTableView:tableView];
        cell.yearAndMonth.text = self.dateArray[indexPath.row];
        return cell;
    }else {
        if (self.segment.segmented.selectedSegmentIndex == 1) {
            if (indexPath.row == 0) {
                BFAdvertisingExpenseInformationCell *cell = [BFAdvertisingExpenseInformationCell cellWithTableView:tableView];
                cell.model = self.commissionModel;
                return cell;
            }else {
                BFCustomerOrderCell *cell = [BFCustomerOrderCell cellWithTableView:tableView];
                cell.model = self.proxyOrderArray[indexPath.row];
                return cell;
                
            }
            
        }else if (self.segment.segmented.selectedSegmentIndex == 2) {
            if (indexPath.row == 0) {
                BFRecommendDividedCell *cell = [BFRecommendDividedCell cellWithTableView:tableView];
                cell.model = self.recommendDividedmodel;
                return cell;
            }else {
                BFInstructionCell *cell = [BFInstructionCell cellWithTableView:tableView];
                cell.model = self.proxyOrderArray[indexPath.row];
                return cell;
            }
            
        }else {
            
            return [[UITableViewCell alloc] init];
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        [self.headerView click];
        self.headerView.timeLabel.text = self.dateArray[indexPath.row];
        [self getcommissionData:self.dateArray[indexPath.row]];
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomTableView.y = 94;
            self.upTableView.y = ScreenHeight;
            self.myTabbar.y = ScreenHeight -110;
            self.headerView.y = 50;
        }];
//        self.upTableView.hidden = YES;
//        self.bottomTableView.hidden = NO;
    }
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        return 44;
    }else {
        if (self.segment.segmented.selectedSegmentIndex == 1) {
            if (indexPath.row == 0) {
                return BF_ScaleFont(135);
            }else {
                return BF_ScaleFont(140);
            }
        }else if (self.segment.segmented.selectedSegmentIndex == 2) {
            if (indexPath.row == 0) {
                return BF_ScaleFont(95);
            }else {
                return BF_ScaleFont(110);
            }        }else {
            return 0;
        }
    }
}

@end
