//
//  BFWithdrawalRecordController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFWithdrawalRecordController.h"
#import "BFWithdrawalRecordCell.h"

@interface BFWithdrawalRecordController ()<UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BFWithdrawalRecordController

#pragma mark -- 懒加载
- (UITableView *)tableView {
    if (!_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BFColor(0xECECEC);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xECECEC);
    self.title = @"提现记录";
    //添加tableView
    [self tableView];
    
}

#pragma mark -- tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFWithdrawalRecordCell *cell = [BFWithdrawalRecordCell cellWithTableView:tableView];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(60);
}

@end
