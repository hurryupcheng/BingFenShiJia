//
//  BFAdvertisingExpenseController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyAdvertisingExpenseController.h"

@interface BFMyAdvertisingExpenseController ()<UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BFMyAdvertisingExpenseController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-116) style:UITableViewStylePlain];
        //_tableView.backgroundColor = [UIColor whiteColor];
        //[_tableView registerClass:[BFMyOrderCell class] forCellReuseIdentifier:@"myOrder"];
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
    [self setHeadaerSegmented];
}

#pragma mark -- 创建固定的头部视图
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"123";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleWidth(105);
}


@end
