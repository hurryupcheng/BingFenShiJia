//
//  BFAddressController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAddressController.h"
#import "BFAddressCell.h"
#import "BFAddAddressController.h"
@interface BFAddressController ()<UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BFAddressController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BFColor(0xffffff);
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    //添加导航栏
    [self setNavigationBar];
    //添加tableView
    [self tableView];
    
}
#pragma mark -- 添加导航栏
- (void)setNavigationBar{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickToAddAddress)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickToAddAddress {
    BFAddAddressController *addVC = [BFAddAddressController new];
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark -- tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFAddressCell *cell = [BFAddressCell cellWithTableView:tableView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(105);
}

@end
