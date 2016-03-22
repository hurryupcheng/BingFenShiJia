//
//  BFAfterSaleProgressController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAfterSaleProgressController.h"
#import "BFAfterSaleProgressCell.h"

@interface BFAfterSaleProgressController ()<UITableViewDelegate, UITableViewDataSource, BFSegmentViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;
/**无信息时的背景*/
@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation BFAfterSaleProgressController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-116) style:UITableViewStylePlain];;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BFColor(0xF2F4F5);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (BFSegmentView *)segment {
    if (!_segment) {
        _segment = [BFSegmentView segmentView];
        _segment.delegate = self;
        _segment.titleArray = @[@"进度中",@"已完成"];
        [self.view addSubview:_segment];
    }
    return _segment;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bgImageView.image = [UIImage imageNamed:@"after_sale_service"];
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"售后进度";
    //添加tableView
    [self tableView];
    //添加分段控制器
    [self segment];
    //进入页面点击分段控制器第一个
    self.segment.segmented.selectedSegmentIndex = 0;
    [self.segment click];

}


#pragma mark -- 分段控制器View的代理
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            BFLog(@"进度中");
            
            break;
        case 1:
            BFLog(@"已完成");


        default:
            break;
    }
}

#pragma mark --tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFAfterSaleProgressCell *cell = [BFAfterSaleProgressCell cellWithTableView:tableView];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(155);
}

@end
