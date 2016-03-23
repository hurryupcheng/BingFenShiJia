//
//  BFMyClientController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyClientController.h"
#import "BFMyCustomerCell.h"

@interface BFMyClientController ()<UITableViewDelegate, UITableViewDataSource, BFSegmentViewDelegate>

/**底部tableView*/
@property (nonatomic, strong) UITableView *tableView;

/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;

@end

@implementation BFMyClientController



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-116) style:UITableViewStylePlain];
        _tableView.backgroundColor = BFColor(0xEBEBEB);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (BFSegmentView *)segment {
    if (!_segment) {
        _segment = [BFSegmentView segmentView];
        _segment.delegate = self;
        _segment.titleArray = @[@"已关注", @"未关注", @"直推人数", @"团队人数"];
        [self.view addSubview:_segment];
    }
    return _segment;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的客户";
    self.view.backgroundColor = BFColor(0xEBEBEB);
    //添加分段控制器
    [self segment];
    self.segment.segmented.selectedSegmentIndex = 1;
    [self.segment click];
    //添加底部tableView
    [self tableView];
    //获取数据
    [self getData];
    
}

#pragma mark --获取数据
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark -- getData
- (void)getData {
   
}

- (void)animation {
    
}

#pragma mark --BFSegmentView代理方法
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            BFLog(@"点击已关注");
            break;
        case 1:
            BFLog(@"点击未关注");
            break;
        case 2:
            BFLog(@"点击直推人数");
            break;
        case 3:
            BFLog(@"点击团队人数");
            break;
    }
}

#pragma mark --tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyCustomerCell *cell = [BFMyCustomerCell cellWithTabelView:tableView];
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(110);
}

@end
