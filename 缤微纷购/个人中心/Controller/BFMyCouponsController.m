//
//  BFMyCouponsController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyCouponsController.h"
#import "BFMyCouponsCell.h"
#import "BFMyCouponsModel.h"

@interface BFMyCouponsController ()<UITableViewDelegate, UITableViewDataSource, BFSegmentViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**背景图*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;
/**优惠券可变数组*/
@property (nonatomic, strong) NSMutableArray *couponsArray;
/**请求参数可变字典*/
@property (nonatomic, strong) NSMutableDictionary *parameter;
@end

@implementation BFMyCouponsController

- (NSMutableArray *)couponsArray {
    if (!_couponsArray) {
        _couponsArray = [NSMutableArray array];
    }
    return _couponsArray;
}

- (NSMutableDictionary *)parameter {
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionary];
    }
    return _parameter;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _bgImageView.image = [UIImage imageNamed:@"bg.jpg"];
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-116) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BFColor(0xD6D6D6);
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
        _segment.titleArray = @[@"未领取",@"未使用",@"已使用"];
        [self.view addSubview:_segment];
    }
    return _segment;
}

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xD6D6D6);
    self.title = @"优惠券";
    //添加背景图
    //[self bgImageView];
     //添加tableView
    [self tableView];
    //添加分段控制器
    [self segment];
    //进入页面点击第一个分段控制器
    [self.segment click];

}

#pragma mark -- 获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=coupon"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    BFLog(@"%@",self.parameter);
    [BFHttpTool GET:url params:self.parameter success:^(id responseObject) {
        NSArray *array = [BFMyCouponsModel parse:responseObject[@"coupon_data"]];
        [self.couponsArray addObjectsFromArray:array];
        [self.tableView reloadData];
        BFLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
    
}
#pragma mark -- 分段控制器View的代理
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {

    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            BFLog(@"点击未领取");
            self.parameter[@"status"] = @"2";
            
            break;
        case 1:
            BFLog(@"点击未使用");
            self.parameter[@"status"] = @"1";
            break;
        case 2:
            BFLog(@"点击已使用");
            self.parameter[@"status"] = @"0";
            break;
        default:
            break;
    }
    [self getData];
}


#pragma mark --- datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.couponsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyCouponsCell *cell = [BFMyCouponsCell cellWithTableView:tableView];
    cell.model = self.couponsArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return BF_ScaleHeight(10);
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleWidth(100);
}

@end
