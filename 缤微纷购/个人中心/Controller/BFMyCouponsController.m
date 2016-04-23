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
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(80), BF_ScaleHeight(100), BF_ScaleWidth(160), BF_ScaleHeight(170))];
        _bgImageView.image = [UIImage imageNamed:@"coupon_bg"];
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50-ScreenHeight, ScreenWidth, ScreenHeight-114) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
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
        _segment.backgroundColor = BFColor(0xF2F4F5);
        _segment.delegate = self;
        _segment.titleArray = @[@"未领取",@"未使用",@"已使用"];
        [self.view addSubview:_segment];
    }
    return _segment;
}

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xF2F4F5);
    self.title = @"优惠券";
    //添加背景图
    [self bgImageView];
     //添加tableView
    [self tableView];
    //添加分段控制器
    [self segment];
    //进入页面点击第一个分段控制器
    self.segment.segmented.selectedSegmentIndex = 0;
    [self.segment click];

}

#pragma mark -- 获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=coupon"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    BFLog(@"%@",self.parameter);
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:self.parameter success:^(id responseObject) {
            BFLog(@"%@",responseObject);
            [self.couponsArray removeAllObjects];
            if ([responseObject[@"coupon_data"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFMyCouponsModel parse:responseObject[@"coupon_data"]];
                if (array.count != 0) {
                    self.tableView.hidden = NO;
                    self.bgImageView.hidden = YES;
                    [self.couponsArray addObjectsFromArray:array];
                    
                }else {
                    
                    self.tableView.hidden = YES;
                    [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"没有更多数据"];
                }
            }
            
            [self.tableView reloadData];
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.y = 50;
            } completion:nil];
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络问题"];
            BFLog(@"%@",error);
        }];
    }];
}
#pragma mark -- 分段控制器View的代理
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.y = 50 - ScreenHeight;
        self.bgImageView.hidden = NO;
    }];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyCouponsModel *model = self.couponsArray[indexPath.row];
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if ([model.is_used isEqualToString:@"0"]) {
        NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=add_coupon"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"uid"] = userInfo.ID;
        parameter[@"token"] = userInfo.token;
        parameter[@"id"] = model.ID;
        BFLog(@"%@",parameter);
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            
            if ([responseObject[@"msg"] isEqualToString:@"恭喜领取成功，请去购物吧！"]) {
                
                [BFProgressHUD MBProgressFromView:self.view LabelText:@"恭喜领取成功，请去购物吧！" dispatch_get_main_queue:^{
                    [self getData];
//                    self.segment.segmented.selectedSegmentIndex = 1;
//                    [self.segment click];
                }];
            }else if ([responseObject[@"msg"] isEqualToString:@"对不起！已经领取光了"]) {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"对不起！已经领取光了"];
            }else if ([responseObject[@"msg"] isEqualToString:@"您已经领取过该券，请去购物吧"]) {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"您已经领取过该券，请去购物吧"];
            }else {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"领取失败，请稍后再试！"];
            }
            
            BFLog(@"%@",responseObject);
        } failure:^(NSError *error) {
            BFLog(@"%@",error);
        }];
    }else {

    }
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
