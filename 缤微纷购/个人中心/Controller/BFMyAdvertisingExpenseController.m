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

@end

@implementation BFMyAdvertisingExpenseController

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-BF_ScaleHeight(50)-64, ScreenWidth, BF_ScaleHeight(50))];
        _bottomView.backgroundColor = BFColor(0xffffff);
        _bottomView.layer.shadowOpacity = 0.3;
        _bottomView.layer.shadowColor = BFColor(0x000000).CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(0, 0);
        [self.view addSubview:_bottomView];
        
        UILabel *label = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(240), _bottomView.height) font:BF_ScaleFont(16) textColor:BFColor(0x000000) text:@"本月总佣金：¥0.60"];
        [_bottomView addSubview:label];
        
        UIButton *raiseCashButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(250), BF_ScaleHeight(10), BF_ScaleWidth(60), BF_ScaleHeight(30)) title:@"如何体现" image:nil font:BF_ScaleFont(12) titleColor:BFColor(0xffffff)];
        raiseCashButton.layer.cornerRadius = 3;
        raiseCashButton.backgroundColor = BFColor(0x102D97);
        [raiseCashButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:raiseCashButton];
    }
    return _bottomView;
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本月广告费";
    [self.view addSubview:self.tableView];
    //设置头部分段控制器
    [self setHeadaerSegmented];
    //设置底部tabBar
    [self setBottomTabBar];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.headerView = (BFMyAdvertisingExpenseSectionView *)[self tableView:self.tableView viewForHeaderInSection:0] ;
    [self.headerView click];
}


#pragma mark --创建底部tabbar

#pragma mark -- 创建固定的头部视图
- (void)setBottomTabBar {
    
}


- (void)setHeadaerSegmented {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor = BFColor(0xffffff);
    [self.view addSubview:headerView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, ScreenWidth, 0.5)];
    line.backgroundColor = BFColor(0xA3A3A3);
    [headerView addSubview:line];
    
    NSArray *segmentedArray = @[@"VIP订单",@"客户订单",@"推荐分成订单"];
    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    //改变segment的字体大小和颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:BFColor(0x13359A),NSForegroundColorAttributeName,nil];
    //设置各种状态的字体和颜色
    [segmented setTitleTextAttributes:dic forState:UIControlStateNormal];
    segmented.frame = CGRectMake(5, 10, ScreenWidth-10, 30);
    [segmented setTintColor:BFColor(0xFD8727)];
    [headerView addSubview:segmented];
    
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
        BFAdvertisingExpenseInformationCell *cell = [BFAdvertisingExpenseInformationCell    cellWithTableView:tableView];
        if (self.listArray) {
            BFMyAdvertisingExpenseModel *group = self.listArray[indexPath.section];
            BFUserModel *user = group.groups[indexPath.row];
            cell.user = user;
            
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
        self.isOpen = group.isOpen;
        self.headerView.group = group;
      
    }
    
    
    
    return self.headerView;
}

- (void)myAdvertisingExpenseSectionView:(BFMyAdvertisingExpenseSectionView *)view didButton:(UIButton *)button {

    [self.tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

@end
