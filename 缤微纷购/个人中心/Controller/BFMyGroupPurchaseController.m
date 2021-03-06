//
//  BFMyGroupPurchaseController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyGroupPurchaseController.h"
#import "BFMyGroupPurchaseCell.h"
#import "BFMyGroupPurchaseModel.h"
#import "BFGroupOrderDetailController.h"
#import "BFGroupDetailController.h"
#import "BFCustomerServiceView.h"

@interface BFMyGroupPurchaseController ()<UITableViewDelegate, UITableViewDataSource, BFMyGroupPurchaseCellDelegate, BFCustomerServiceViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**拼团数组*/
@property (nonatomic, strong) NSMutableArray *groupArray;
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
//返回顶部按钮
@property (nonatomic, strong) UIButton *TopButton;
//偏移量
@property (nonatomic, assign) CGFloat contentOffSetY;

@end

@implementation BFMyGroupPurchaseController

- (NSMutableArray *)groupArray {
    if (!_groupArray) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
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

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"我的拼团";
    //添加背景图
    [self bgImageView];
    //添加tableView;
    [self tableView];
    //请求数据
    [self getData];
    //设置导航栏
    [self setUpNavigationBar];
    // 集成下拉刷新控件
    [self setupDownRefresh];
    //
    [BFNotificationCenter addObserver:self selector:@selector(changeGroupStatus) name:@"changeGroupStatus" object:nil];
}


#pragma mark --集成下拉刷新
- (void)setupDownRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    //[self.tableView.mj_header beginRefreshing];
}


- (void)loadNewData {

    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=team_order"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        BFLog(@"我的订单%@,",responseObject);
        if (responseObject) {
            if ([responseObject[@"team"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFMyGroupPurchaseModel parse:responseObject[@"team"]];
                if ([[BFUserDefaluts getSwitchInfo] intValue] == 1) {
                    [BFSoundEffect playSoundEffect:@"paopao.wav"];
                }
                [self showNewStatusCount:array.count - self.groupArray.count];
                [self.groupArray removeAllObjects];
                [self.groupArray addObjectsFromArray:array];
                self.bgImageView.hidden = YES;
    
            }else {
                [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有参团哦!快去参团吧!"];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题..."];
        BFLog(@"error:%@",error);
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
        label.text = @"亲,没有更多的参团订单哦!";
    } else {
        label.text = [NSString stringWithFormat:@"共有%zd条新的团购订单", count];
    }
    label.textColor = BFColor(0xffffff);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    
    // 3.添加
    label.y = - label.height;
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


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}



- (void)dealloc {
    [BFNotificationCenter removeObserver:self];
}




- (void)changeGroupStatus {
//    [UIView animateWithDuration:0.5 animations:^{
//        self.tableView.y = -ScreenHeight;
//    } completion:nil];

    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=team_order"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        if (responseObject) {
            
            if ([responseObject[@"team"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFMyGroupPurchaseModel parse:responseObject[@"team"]];
                if (array.count != 0) {
                    [self.groupArray removeAllObjects];
                    [self.groupArray addObjectsFromArray:array];
                    BFLog(@"我的订单%@,",responseObject);
                }else {
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有参团哦!快去参团吧!"];
                }
            }else {
                [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有参团哦!快去参团吧!"];
            }
            [self.tableView reloadData];
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.y = 0;
            } completion:nil];
        }
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题..."];
        BFLog(@"error:%@",error);
    }];
}


#pragma mark -- 请求数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=team_order"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            if (responseObject) {
                if ([responseObject[@"team"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = [BFMyGroupPurchaseModel parse:responseObject[@"team"]];
                    if (array.count != 0) {
                        [self.groupArray addObjectsFromArray:array];
                        //延迟0.2秒隐藏
                        double delayTime = 0.2;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^{
                            self.bgImageView.hidden = YES;
                        });
                        BFLog(@"我的订单%@,",responseObject);
                    }else {
                        self.bgImageView.hidden = NO;
                        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有参团哦!快去参团吧!"];
                    }
                }else {
                    self.bgImageView.hidden = NO;
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有参团哦!快去参团吧!"];
                }
                [hud hideAnimated:YES];
                [self.tableView reloadData];
                [UIView animateWithDuration:0.5 animations:^{
                    self.tableView.y = 0;
                } completion:nil];
            }
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressOnlyWithLabelText:@"网络问题"];
            BFLog(@"error:%@",error);
        }];
    }];
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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

#pragma mark --返回按钮点击事件
- (void)back {
    self.tabBarController.selectedIndex = 2;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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





#pragma mark -- tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyGroupPurchaseCell *cell = [BFMyGroupPurchaseCell cellWithTableView:tableView];
    cell.model = self.groupArray[indexPath.row];
    cell.delegate = self;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BF_ScaleHeight(133);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 13;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
#pragma mark --BFMyGroupPurchaseCell代理方法
/**BFMyGroupPurchaseCell代理方法*/
- (void)clickToGotoCheckDetailWithButtonType:(MyGroupPurchaseCellCheckButtonType)type model:(BFMyGroupPurchaseModel *)model{
    switch (type)  {
            
        case MyGroupPurchaseCellCheckButtonTypeGroup:{
            BFGroupDetailController *groupDetailVC = [[BFGroupDetailController alloc] init];
            groupDetailVC.itemid = model.ID;
            groupDetailVC.teamid = [model.parent_id isEqualToString:@"0"] ? model.tid : model.parent_id;
            [self.navigationController pushViewController:groupDetailVC animated:YES];
            BFLog(@"团详情");
            break;
        }
        case MyGroupPurchaseCellCheckButtonTypeOrder:{
            BFGroupOrderDetailController *groupOrderDetailVC = [[BFGroupOrderDetailController alloc] init];
            groupOrderDetailVC.itemid = model.ID;
            groupOrderDetailVC.teamid = model.tid;
            BFLog(@"====%@,,%@",model.ID, model.tid);
            [self.navigationController pushViewController:groupOrderDetailVC animated:YES];
            BFLog(@"订单详情");
            break;
        }
    }
}

#pragma mark -- 添加返回顶部的按钮
- (UIButton *)TopButton{
    if (!_TopButton) {
        _TopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _TopButton.frame = CGRectMake(ScreenWidth - BF_ScaleWidth(60),ScreenHeight-BF_ScaleHeight(190), BF_ScaleWidth(50), BF_ScaleWidth(50));
        _TopButton.layer.cornerRadius = BF_ScaleWidth(25);
        _TopButton.layer.masksToBounds = YES;
        _TopButton.backgroundColor = BFColor(0x1dc3ff);
        [_TopButton setTitle:@"TOP" forState:UIControlStateNormal];
        [self.TopButton addTarget:self action:@selector(TopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TopButton;
}
- (void)TopButtonAction:(UIButton *)sender{
    
    //self.tableView.contentOffset = CGPointMake(0, 0);
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    [self.TopButton removeFromSuperview];
}
//开始拖动scrollV
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _contentOffSetY = scrollView.contentOffset.y;
}

//只要偏移量发生改变就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currcontentOffSetY = scrollView.contentOffset.y;
    if (_contentOffSetY > currcontentOffSetY && currcontentOffSetY > 0) {
        [self.view addSubview:self.TopButton];
        //        [self.view bringSubviewToFront:self.TopButton];
    }else{
        [self.TopButton removeFromSuperview];
    }
}



@end
