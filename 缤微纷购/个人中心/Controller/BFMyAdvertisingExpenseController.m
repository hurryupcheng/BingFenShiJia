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

@interface BFMyAdvertisingExpenseController ()<UITableViewDelegate, UITableViewDataSource, SectionHeaderViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *listArray;
/**是否打开*/
@property (nonatomic, getter=isOpen) BOOL isOpen;
/**底部视图*/
@property (nonatomic, strong) UIView *bottomView;
/**自定义分区头*/
@property (nonatomic, strong) BFMyAdvertisingExpenseSectionView *headerView;
/**自定义tabbar*/
@property (nonatomic, strong) BFMyAdvertisingExpenseTabbar *myTabbar;
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;

@property (nonatomic, strong) NSMutableDictionary *parameter;
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


- (NSArray *)listArray{
    if (!_listArray) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"list.plist" ofType:nil];
        NSArray * dicArr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary *dict in dicArr) {
            BFMyAdvertisingExpenseModel *group = [BFMyAdvertisingExpenseModel parsingJsonWithDictionary:dict];
            [arr addObject:group];
        }
        _listArray = arr;
    }
    return _listArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-160) style:UITableViewStylePlain];
        //_tableView.backgroundColor = [UIColor redColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (BFSegmentView *)segment {
    if (!_segment) {
        _segment = [BFSegmentView segmentView];
        _segment.titleArray = @[@"VIP订单",@"客户订单",@"推荐分成订单"];
    }
    return _segment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本月广告费";
    //self.view.backgroundColor = [UIColor greenColor];
    //设置头部分段控制器
    [self.view addSubview:self.segment];
    [self myTabbar];
    //设置底部tabBar
    //[self setBottomTabbar];
    [self.view addSubview:self.tableView];

    
}


- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_commission"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    //self.parameter[@"p"] = @1;
    [BFHttpTool GET:url params:self.parameter success:^(id responseObject) {
        BFLog(@"%@,",responseObject);
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
}

/**进入页面就点击第一个*/
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.headerView = (BFMyAdvertisingExpenseSectionView *)[self tableView:self.tableView viewForHeaderInSection:0] ;
    [self.headerView click];
}




#pragma mark -- 创建固定的头部视图


- (void)change:(UISegmentedControl *)segment {
    BFLog(@"%lu",segment.selectedSegmentIndex);
}
#pragma mark --- datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BFMyAdvertisingExpenseModel *group = self.listArray[section];
    //BFLog(@"%lu",(unsigned long)group.groups.count);
    return group.isOpen?group.groups.count+1:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BFAdvertisingExpenseInformationCell *cell = [BFAdvertisingExpenseInformationCell cellWithTableView:tableView];
        if (self.listArray) {
            BFMyAdvertisingExpenseModel *group = self.listArray[indexPath.section];
            self.myTabbar.model = group;
            cell.total = group;
            
        }
            return cell;
    }else {
        BFInstructionCell *cell = [BFInstructionCell cellWithTableView:tableView];
        if (self.listArray) {
            BFMyAdvertisingExpenseModel *group = self.listArray[indexPath.section];
            BFUserModel *user = group.groups[indexPath.row-1];
            cell.user = user;
        }
         return cell;
    }

}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(90);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.headerView = [BFMyAdvertisingExpenseSectionView myHeadViewWithTableView:tableView];
    self.headerView.contentView.backgroundColor = BFColor(0xffffff);
    self.headerView.delegate = self;
    if (self.listArray) {
        BFMyAdvertisingExpenseModel *group = self.listArray[section];
        group.isOpen = NO;
        self.headerView.group = group;
      
    }
    
    return self.headerView;
}


- (void)myAdvertisingExpenseSectionView:(BFMyAdvertisingExpenseSectionView *)view didButton:(UIButton *)button {
    
    NSString *year = [button.titleLabel.text substringWithRange:NSMakeRange(0,4)];
    NSString *month = [button.titleLabel.text substringWithRange:NSMakeRange(5,2)];
    
    self.parameter[@"year"] = year;
    self.parameter[@"month"] = month;
    [self getData];
    BFLog(@"---%@,,,%@,,,%@,,,%@",button.titleLabel.text,year,month,self.parameter);
    [self.tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

@end
