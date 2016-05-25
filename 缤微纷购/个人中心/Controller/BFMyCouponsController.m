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
#import "BFCustomerServiceView.h"

@interface BFMyCouponsController ()<UITableViewDelegate, UITableViewDataSource, BFSegmentViewDelegate, BFCustomerServiceViewDelegate>
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
    //添加navigationbar
    [self setUpNavigationBar];
     //添加tableView
    [self tableView];
    //添加分段控制器
    [self segment];
    //进入页面点击第一个分段控制器
    self.segment.segmented.selectedSegmentIndex = 0;
    [self.segment click];

}


#pragma mark -- 设置客服按钮
- (void)setUpNavigationBar {
    UIButton *telephone = [UIButton buttonWithType:0];
    //telephone.backgroundColor = [UIColor redColor];
    telephone.width = 30;
    telephone.height = 30;
    [telephone addTarget:self action:@selector(telephone) forControlEvents:UIControlEventTouchUpInside];
    [telephone setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
    UIBarButtonItem *telephoneItem = [[UIBarButtonItem alloc] initWithCustomView:telephone];
    self.navigationItem.rightBarButtonItem = telephoneItem;
}

- (void)telephone {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    BFCustomerServiceView *customerServiceView = [BFCustomerServiceView createCustomerServiceView];
    customerServiceView.delegate = self;
    [window addSubview:customerServiceView];
}


#pragma mark --BFCustomerServiceViewDelegate
- (void)clickToChooseCustomerServiceWithType:(BFCustomerServiceViewButtonType)type {
    switch (type) {
        case BFCustomerServiceViewButtonTypeTelephone:{
            BFLog(@"点击电话客服");
            UIAlertController *alertC = [UIAlertController alertWithControllerTitle:nil controllerMessage:nil preferredStyle:UIAlertControllerStyleActionSheet actionTitle:@"020-38875719" style:UIAlertActionStyleDefault handler:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://020-38875719"]]];
            }];
            [self presentViewController:alertC animated:YES completion:nil];
            
            
            break;
        }
        case BFCustomerServiceViewButtonTypeWechat:
            BFLog(@"点击微信客服");
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"暂不支持，尽请期待"];
            break;
            
    }
}



#pragma mark -- 获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=coupon"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    BFLog(@"%@",self.parameter);
    [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
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
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有优惠券哦!"];
                }
            }else {
                [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有优惠券哦!"];
            }
            [hud hideAnimated:YES];
            [self.tableView reloadData];
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.y = 50;
            } completion:nil];
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
            BFLog(@"%@",error);
        }];
    }];
}
#pragma mark -- 分段控制器View的代理
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
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
        [BFProgressHUD MBProgressWithLabelText:@"正在领取优惠券" dispatch_get_main_queue:^(MBProgressHUD *hud) {
            [BFHttpTool GET:url params:parameter success:^(id responseObject) {
                if ([responseObject[@"msg"] isEqualToString:@"恭喜领取成功，请去购物吧！"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view rightLabelText:@"恭喜领取成功，请去购物吧！"];
                    [self.couponsArray removeObjectAtIndex:indexPath.row];
                    //[self.couponsArray removeObject:model];
                    if (self.couponsArray.count == 0) {
                        self.bgImageView.hidden = NO;
                    }
                    [self.tableView reloadData];
                    
                }else if ([responseObject[@"msg"] isEqualToString:@"对不起！已经领取光了"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"对不起！已经领取光了"];
                }else if ([responseObject[@"msg"] isEqualToString:@"您已经领取过该券，请去购物吧"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"您已经领取过该券，请去购物吧"];
                }else if ([responseObject[@"msg"] isEqualToString:@"回馈老客户，广告主专用的哦！"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"回馈老客户，广告主专用的哦！"];
                }else {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"领取失败，请稍后再试！"];
                }
                BFLog(@"%@",responseObject);
            } failure:^(NSError *error) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"领取失败，请稍后再试！"];
                BFLog(@"%@",error);
            }];
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
