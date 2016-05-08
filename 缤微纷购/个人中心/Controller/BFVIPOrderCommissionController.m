//
//  BFVIPOrderCommissionController.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFVIPOrderCommissionController.h"
#import "BFGetYearAndMonth.h"


@interface BFVIPOrderCommissionController ()<UITableViewDelegate, UITableViewDataSource>
/**底部tableView*/
@property (nonatomic, strong) UITableView *bottomTableView;
/**上面tableView*/
@property (nonatomic, strong) UITableView *upTableView;
/**年月数组*/
@property (nonatomic, strong) NSArray *dateArray;
@end

@implementation BFVIPOrderCommissionController


#pragma mark -- 懒加载
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


- (NSArray *)dateArray {
    if (!_dateArray) {
        _dateArray = [BFGetYearAndMonth getTenMonthBeforeTheCurrentTime];
    }
    return _dateArray;
}


#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    //添加底部tableView
    [self bottomTableView];
    //添加上面tableView
    [self upTableView];
}

#pragma mark -- tableView方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = @"VIP订单";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
