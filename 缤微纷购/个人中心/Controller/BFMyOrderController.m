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
#import "BFCustomerServiceView.h"
#import "BFPayoffViewController.h"
#import "BFNavigationController.h"
#import "BFCategoryNavigationView.h"
#import "PersonalViewController.h"

@interface BFMyOrderController ()<UITableViewDelegate, UITableViewDataSource, BFSegmentViewDelegate, BFCustomerServiceViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;
/**订单数组*/
@property (nonatomic, strong) NSMutableArray *oderArray;
/**参数字典*/
@property (nonatomic, strong) NSMutableDictionary *parameter;
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;



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

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(105), BF_ScaleHeight(100), BF_ScaleHeight(110), BF_ScaleHeight(135))];
        _bgImageView.image = [UIImage imageNamed:@"order_bg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50-ScreenHeight, ScreenWidth, ScreenHeight-114) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (BFSegmentView *)segment {
    if (!_segment) {
        _segment = [BFSegmentView segmentView];
        _segment.delegate = self;
        _segment.titleArray = @[@"未付款",@"已付款",@"已完成"];
        [self.view addSubview:_segment];
    }
    return _segment;
}
#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"我的订单";
    //添加navigationbar
    [self setUpNavigationBar];
    //添加背景图
    [self bgImageView];
    //添加tableView
    [self tableView];
    //添加分段控制器
    [self segment];
    // 集成下拉刷新控件
    [self setupDownRefresh];
    //进入页面点击分段控制器第一个
//    self.segment.segmented.selectedSegmentIndex = 0;
//    [self.segment click];
    //从本页面进入支付页面，支付成功接受通知
    [BFNotificationCenter addObserver:self selector:@selector(changeOrderStatus) name:@"changeOrderStatus" object:nil];
    
    //判断
    NSArray *vcsArray = [self.navigationController viewControllers];
    UIViewController *lastVC = vcsArray[vcsArray.count-2];
    BFLog(@"----========%@", vcsArray);
    if ([lastVC isKindOfClass:[BFPayoffViewController class]]) {
        
        //[lastVC removeFromParentViewController];
        self.segment.segmented.selectedSegmentIndex = 1;
        [self.segment click];
    }else {
        self.segment.segmented.selectedSegmentIndex = 0;
        [self.segment click];
    }
      
}



#pragma mark -- viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


#pragma mark -- 发送通知改变状态
- (void)changeOrderStatus {
    self.segment.segmented.selectedSegmentIndex = 1;
    [self.segment click];
}


#pragma mark -- 销毁通知
- (void)dealloc {
    [BFNotificationCenter removeObserver:self];
}

#pragma mark --集成下拉刷新
- (void)setupDownRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    //[self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=goods_info"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;

        
        [BFHttpTool GET:url params:self.parameter success:^(id responseObject) {
            BFLog(@"----%@", responseObject);
            if ([responseObject[@"order"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFMyOrderModel parse:responseObject[@"order"]];
                [BFSoundEffect playSoundEffect:@"paopao.wav"];
                [self showNewStatusCount:array.count - self.oderArray.count];
                [self.oderArray removeAllObjects];
                [self.oderArray addObjectsFromArray:array];
                self.bgImageView.hidden = YES;
            }else if([responseObject[@"msg"] isEqualToString:@"数据为空"]) {
                //self.tableView.hidden = YES;
                [BFSoundEffect playSoundEffect:@"paopao.wav"];
                [self showNewStatusCount:0];

            }
            //BFLog(@"我的订单%@",responseObject);
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题..."];
            [self.tableView.mj_header endRefreshing];
            BFLog(@"error%@",error);
        }];


}


#pragma mark -- 刷新看是否有数据更新
- (void)showNewStatusCount:(NSUInteger)count
{
    // 1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = label.backgroundColor = BFColor(0xFD8B2F);
    label.width = ScreenWidth;
    label.height = 35;
    // 2.设置其他属性
    if (count == 0) {
        label.text = @"亲,没有更多的订单哦!";
    } else {
        label.text = [NSString stringWithFormat:@"共有%zd条新的订单", count];
    }
    label.textColor = BFColor(0xffffff);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    
    // 3.添加
    label.y = 50-label.height;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.view insertSubview:label aboveSubview:self.tableView];
    
    // 4.动画
    // 先利用1s的时间，让label往下移动一段距离
    CGFloat duration = 1.0; // 动画的时间
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        CGFloat delay = 1.0; // 延迟1s
        // UIViewAnimationOptionCurveLinear:匀速
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
}


#pragma mark -- 获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=goods_info"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {

        [BFHttpTool GET:url params:self.parameter success:^(id responseObject) {
            [self.oderArray removeAllObjects];
            if ([responseObject[@"order"] isKindOfClass:[NSArray class]]) {
                
                
                NSArray *array = [BFMyOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"order"]];
                if (array.count != 0 ) {
//                    self.tableView.hidden = NO;
                    double delayInSeconds = 0.2;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        self.bgImageView.hidden = YES;
                    });
                    [self.oderArray addObjectsFromArray:array];
                }else {
                    //self.tableView.hidden = YES;
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,没有可查看的订单哦!"];
                }
            }else if([responseObject[@"msg"] isEqualToString:@"数据为空"]) {
                //self.tableView.hidden = YES;
                [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,没有可查看的订单哦!"];
            }
            //BFLog(@"我的订单%@",responseObject);
            [self.tableView reloadData];
            [hud hideAnimated:YES];
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.y = 50;
            } completion:nil];
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题..."];
            BFLog(@"error%@",error);
        }];
    }];
}



#pragma mark -- 分段控制器View的代理
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.y = 50-ScreenHeight;
        self.bgImageView.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            BFLog(@"点击未付款");
            self.parameter[@"status"] = @"1";
            //self.parameter[@"refund_status"] = nil;
            [self getData];
            break;
        case 1:
            BFLog(@"点击已付款");
            self.parameter[@"status"] = @"2";
            //self.parameter[@"refund_status"] = nil;
            [self getData];
            break;
        case 2:
            BFLog(@"点击已完成");
            self.parameter[@"status"] = @"3";
            //self.parameter[@"refund_status"] = @"1";
            [self getData];
            break;
        default:
            break;
    }
    
}

#pragma mark -- 设置客服按钮
- (void)setUpNavigationBar {
    UIButton *telephone = [UIButton buttonWithType:0];
    //telephone.backgroundColor = [UIColor redColor];
    telephone.width = 30;
    telephone.height = 30;
    [telephone addTarget:self action:@selector(telephone) forControlEvents:UIControlEventTouchUpInside];
    [telephone setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
    [telephone setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateHighlighted];
    UIBarButtonItem *telephoneItem = [[UIBarButtonItem alloc] initWithCustomView:telephone];
    self.navigationItem.rightBarButtonItem = telephoneItem;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    
    //self.navigationItem.leftBarButtonItems = @[backItem];

}

#pragma mark --返回按钮点击事件
- (void)back {
    self.tabBarController.selectedIndex = 2;
 
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



#pragma mark --客服图标点击事件
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
            [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"暂不支持，尽请期待"];
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
    detailVC.block = ^(BOOL isOperated) {
        if (isOperated) {
            [self.oderArray removeObjectAtIndex:indexPath.row];
            if (self.oderArray.count == 0) {
                self.bgImageView.hidden = NO;
            }
            [self.tableView reloadData];
        }
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleWidth(130);
}


@end
