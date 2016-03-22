//
//  BFMyOrderController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyOrderController.h"
#import "BFMyOrderCell.h"
#import "BFMyOrderModel.h"
#import "BFMyOrderDetailController.h"

@interface BFMyOrderController ()<UITableViewDelegate, UITableViewDataSource, BFSegmentViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;
/**订单数组*/
@property (nonatomic, strong) NSMutableArray *oderArray;
/**参数字典*/
@property (nonatomic, strong) NSMutableDictionary *parameter;
@end

@implementation BFMyOrderController

- (NSMutableDictionary *)parameter {
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionary];
    }
    return _parameter;
}

- (NSMutableArray *)oderArray {
    if (!_oderArray) {
        _oderArray = [NSMutableArray array];
    }
    return _oderArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50-ScreenHeight, ScreenWidth, ScreenHeight-116) style:UITableViewStylePlain];
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
        _segment.titleArray = @[@"未付款",@"已付款",@"我的售后"];
        [self.view addSubview:_segment];
    }
    return _segment;
}
#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"我的订单";
    //添加tableView
    [self tableView];
    //添加分段控制器
    [self segment];
    //进入页面点击分段控制器第一个
    self.segment.segmented.selectedSegmentIndex = 0;
    [self.segment click];


}

#pragma mark -- 获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=goods_info"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    [BFProgressHUD MBProgressFromView:self.view LabelText:@"正在请求..." dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:self.parameter success:^(id responseObject) {
            if (![responseObject[@"order"] isKindOfClass:[NSNull class]]) {
                [self.oderArray removeAllObjects];
                NSArray *array = [BFMyOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"order"]];
                [self.oderArray addObjectsFromArray:array];
                BFLog(@"我的订单%@",responseObject);
            }else {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"没有数据"];
            }
            [self.tableView reloadData];
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.y = 50;
            } completion:nil];
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络问题..."];
            BFLog(@"error%@",error);
        }];
    }];
    
}



#pragma mark -- 分段控制器View的代理
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.y = 50-ScreenHeight;
    } completion:^(BOOL finished) {
        
    }];
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            BFLog(@"点击未付款");
            self.parameter[@"status"] = @"1";
            self.parameter[@"refund_status"] = nil;
            [self getData];
            break;
        case 1:
            BFLog(@"点击已付款");
            self.parameter[@"status"] = @"0";
            self.parameter[@"refund_status"] = nil;
            [self getData];
            break;
        case 2:
            BFLog(@"点击我的售后");
            self.parameter[@"status"] = nil;
            self.parameter[@"refund_status"] = @"1";
            [self getData];
            break;
        default:
            break;
    }
    
}




#pragma mark --- datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.oderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyOrderCell *cell = [BFMyOrderCell cellWithTableView:tableView];
    cell.model = self.oderArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyOrderModel *model = self.oderArray[indexPath.row];
    BFMyOrderDetailController *detailVC = [BFMyOrderDetailController new];
    detailVC.orderId = model.orderId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleWidth(130);
}

#pragma mark -- viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
@end
