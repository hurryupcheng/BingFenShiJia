//
//  BFMyIntegralController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//  我的积分

#define SectionHeaderH   BF_ScaleHeight(50)

#import "BFMyIntegralController.h"
#import "BFMyIntegralCell.h"

@interface BFMyIntegralController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**背景图*/
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation BFMyIntegralController

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _bgImageView.image = [UIImage imageNamed:@"bg.jpg"];
    }
    return _bgImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.tableView];
    self.title = @"我的积分";
    [self setNavigationBar];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

#pragma mark -- 设置导航栏
- (void)setNavigationBar {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"积分规则"  style:UIBarButtonItemStylePlain target:self action:@selector(integralRule)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)integralRule {
    BFLog(@"积分规则");
}

#pragma mark --- datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyIntegralCell *cell = [BFMyIntegralCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}






- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, SectionHeaderH)];
    view.backgroundColor = BFColor(0xE5E6E7);
    
    UIView *topLine = [UIView drawLineWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    [view addSubview:topLine];
    
    UIView *bottomLine = [UIView drawLineWithFrame:CGRectMake(0, view.height-1, ScreenWidth, 1)];
    [view addSubview:bottomLine];
    
    
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(90), view.height) font:BF_ScaleFont(12) textColor:BFColor(0x000000) text:@"当前可用积分："];
    [view addSubview:titleLabel];
    
    UILabel *integeralLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, BF_ScaleWidth(180), view.height) font:BF_ScaleFont(20) textColor:BFColor(0xFD8727) text:@"1001"];
    integeralLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(18)];
    [view addSubview:integeralLabel];

    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SectionHeaderH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MyIntegralCellH;
}
@end
