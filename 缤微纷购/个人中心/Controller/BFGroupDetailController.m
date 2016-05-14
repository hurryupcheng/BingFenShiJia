//
//  BFGroupDetailController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/30.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFPTDetailModel.h"
#import "BFZFViewController.h"
#import "BFPayoffViewController.h"
#import "BFPTDetailViewController.h"
#import "BFPTViewController.h"
#import "BFMyGroupPurchaseController.h"
#import "PTStepViewController.h"
#import "BFGroupDetailController.h"
#import "BFGroupDetailTabbar.h"
#import "BFGroupDetailModel.h"
#import "BFShareView.h"
#import "BFHeadPortraitView.h"
#import "BFGroupDetailHeaderView.h"
#import "BFGroupDetailFooterView.h"
#import "BFGroupDetailTeamCell.h"
#import "BFGroupDetailCaptainCell.h"
#import "BFSettingController.h"

@interface BFGroupDetailController ()<BFGroupDetailTabbarDelegate, UITableViewDelegate, UITableViewDataSource, BFShareViewDelegate>{
    __block int         leftTime;
    __block NSTimer     *timer;
}
/**自定义tabbar*/
@property (nonatomic, strong) BFGroupDetailTabbar *tabbar;
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**BFGroupDetailModel*/
@property (nonatomic, strong) BFGroupDetailModel *model;
/**团购数组*/
@property (nonatomic, strong) NSMutableArray *teamArray;
/**tableViewHeaderView*/
@property (nonatomic, strong) BFGroupDetailHeaderView *headerView;
/**tableViewFooterView*/
@property (nonatomic, strong) BFGroupDetailFooterView *footerView;
@end

@implementation BFGroupDetailController


#pragma mark -- 懒加载
- (NSMutableArray *)teamArray {
    if (!_teamArray) {
        _teamArray = [NSMutableArray array];
    }
    return _teamArray;
}

- (BFGroupDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFGroupDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        
    }
    return _headerView;
}

- (BFGroupDetailFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[BFGroupDetailFooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(400))];
        
    }
    return _footerView;
}

- (BFGroupDetailTabbar *)tabbar {
    if (!_tabbar) {
        _tabbar = [[BFGroupDetailTabbar alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, BF_ScaleHeight(70))];
        _tabbar.delegate = self;
        [self.view addSubview:_tabbar];
    }
    return _tabbar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"团详情";
    
    self.view.backgroundColor = BFColor(0xffffff);
    //添加tableView
    [self tableView];
    //添加tabbar
    [self tabbar];
    //获取数据
    [self getData];
    //接收footerView的拼团玩法的点击事件
    [BFNotificationCenter addObserver:self selector:@selector(clickToLookDetail) name:@"lookDetail" object:nil];
    //接收footerView的缤纷世家按钮的点击事件
    [BFNotificationCenter addObserver:self selector:@selector(goToHome) name:@"homeButtonClick" object:nil];
    //接收footerView的我的团按钮的点击事件
    [BFNotificationCenter addObserver:self selector:@selector(goToGroupDetail) name:@"myGroupClick" object:nil];
    //点击商品跳转
    [BFNotificationCenter addObserver:self selector:@selector(clickToDetail) name:@"clickToDetail" object:nil];
    //从本页面进入支付页面，支付成功接受通知
    [BFNotificationCenter addObserver:self selector:@selector(changeOrderStatus) name:@"changeOrderStatus" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}


//移除通知
- (void)dealloc {
    [BFNotificationCenter removeObserver:self];
}

#pragma mark -- 支付成功改变状态
- (void)changeOrderStatus {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=team"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"itemid"] = self.itemid;
    parameter[@"teamid"] = self.teamid;
    [BFHttpTool POST:url params:parameter success:^(id responseObject) {
        
        if (responseObject) {
            [self.teamArray removeAllObjects];
            self.model = [BFGroupDetailModel parse:responseObject];
            if ([responseObject[@"thisteam"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [TeamList parse:self.model.thisteam];
                [self.teamArray addObjectsFromArray:array];
                if (self.teamArray.count > 1) {
                    for (TeamList *list in self.teamArray) {
                        if ([list.status isEqualToString:@"1"]) {
                            [self.teamArray removeObject:list];
                        }
                    }
                }
            }
            //给头部视图模型赋值
            self.headerView.model = self.model;
            //给底部视图模型赋值
            self.footerView.model = self.model;
            //返回的高度赋值
            [self animation];
            
            
            //给状态栏赋值
            self.tabbar.model = self.model;
            BFLog(@"---%@,%@,,%f",responseObject,parameter,self.headerView.height);
            [self.tableView reloadData];
            
        }
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
}

#pragma mark -- 拼团玩法的通知事件
- (void)clickToLookDetail {
    PTStepViewController *pt = [[PTStepViewController alloc]init];
    [self.navigationController pushViewController:pt animated:YES];
}

#pragma mark -- 缤纷世家按钮的通知事件
- (void)goToHome {
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -- 我的团按钮的通知事件
- (void)goToGroupDetail {
    NSArray *vcsArray = [self.navigationController viewControllers];
    for (UIViewController *lastVC in vcsArray) {
        if ([lastVC isKindOfClass:[BFMyGroupPurchaseController class]]) {
            [self.navigationController popToViewController:lastVC animated:YES];
        }
    }
}

#pragma mark -- 点击商品跳转
- (void)clickToDetail {
    BFPTDetailViewController *detailVC = [[BFPTDetailViewController alloc] init];
    ItemModel *itemModel = [ItemModel parse:self.model.item];
    detailVC.ID = itemModel.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -- 获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=team"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"itemid"] = self.itemid;
    parameter[@"teamid"] = self.teamid;
    
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            
            if (responseObject) {
                self.model = [BFGroupDetailModel parse:responseObject];
                if ([responseObject[@"thisteam"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = [TeamList parse:self.model.thisteam];
                    [self.teamArray addObjectsFromArray:array];
                    if (self.teamArray.count > 1) {
                        for (TeamList *list in self.teamArray) {
                            if ([list.status isEqualToString:@"1"]) {
                                [self.teamArray removeObject:list];
                            }
                        }
                    }
                }
                //给头部视图模型赋值
                self.headerView.model = self.model;
                //给底部视图模型赋值
                self.footerView.model = self.model;
                //返回的高度赋值
                [self animation];
                //给状态栏赋值
                self.tabbar.model = self.model;
                BFLog(@"---%@,%@,,%f",responseObject,parameter,self.headerView.height);
                [self.tableView reloadData];
                
            }
        } failure:^(NSError *error) {
            BFLog(@"%@",error);
        }];
    }];
}

#pragma mark --添加动画效果
- (void)animation {
    [UIView animateWithDuration:0.5 animations:^{
        
        self.headerView.height = self.headerView.headerViewH;
        self.tableView.tableHeaderView = self.headerView;
        self.tableView.tableFooterView = self.footerView;
        self.tabbar.y = ScreenHeight - 60 - BF_ScaleHeight(70);
        self.tableView.y = 0;
    }];
}





#pragma mark --tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.teamArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.teamArray.count == 1) {
        BFGroupDetailCaptainCell *cell = [BFGroupDetailCaptainCell cellWithTableView:tableView];
        cell.model = self.teamArray[indexPath.row];
        cell.detailModel = self.model;
        return cell;
    }else {
        if (indexPath.row == 0) {
            BFGroupDetailCaptainCell *cell = [BFGroupDetailCaptainCell cellWithTableView:tableView];
            cell.model = self.teamArray[indexPath.row];
            cell.detailModel = self.model;
            return cell;
        }else {
            BFGroupDetailTeamCell *cell = [BFGroupDetailTeamCell cellWithTableView:tableView];
            cell.model = self.teamArray[indexPath.row];
            return cell;
        }
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.teamArray.count == 1) {
        return BF_ScaleHeight(70);
    } else if (self.teamArray.count == 2) {
        switch (indexPath.row) {
            case 0:
                return BF_ScaleHeight(90);
                break;
            case 1:
                return BF_ScaleHeight(45);
                break;
        }
    } else if (self.teamArray.count >= 3) {
        if (indexPath.row == 0) {
            return BF_ScaleHeight(90);
        } else if (indexPath.row == self.teamArray.count-1) {
            return BF_ScaleHeight(45);
        } else {
            return BF_ScaleHeight(65);
        }
    }
    return 0;
}



#pragma mark --BFGroupDetailTabbarDelegate
- (void)clickEventWithType:(BFGroupDetailTabbarButtonType)type {
    
    switch (type) {
        case BFGroupDetailTabbarButtonTypeHome:{
            self.tabBarController.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
            BFLog(@"回答主页");
            break;
        }
        case BFGroupDetailTabbarButtonTypeShare:{
            //分享好友来参团
            [self gotoShare];
            BFLog(@"分享");
            break;
        }
        case BFGroupDetailTabbarButtonTypePay:{
            [self gotoPay];
            BFLog(@"立即支付");
            break;
        }
        case BFGroupDetailTabbarButtonTypePayToJoin:{
            [self gotoPay];
            BFLog(@"立即支付参团");
            break;
        }
        case BFGroupDetailTabbarButtonTypeJoin:{
            BFZFViewController *zfVC = [[BFZFViewController alloc] init];
            ItemModel *itemModel = [ItemModel parse:self.model.item];
            zfVC.ID = itemModel.ID;
            zfVC.isPT = YES;
            BFPTDetailModel *model = [[BFPTDetailModel alloc] init];
            model.img = itemModel.img;
            model.shopID = itemModel.ID;
            model.title = itemModel.title;
            model.team_price = itemModel.team_price;
            model.team_num = itemModel.team_num;
            model.team_cycle = itemModel.team_cycle;
            model.intro = itemModel.intro;
            model.numbers = 1;
            model.choose = @"";
            model.color = @"";
            NSMutableArray *mutableArray = [NSMutableArray array];
            [mutableArray addObject:model];
            zfVC.modelArr = mutableArray;
            [self.navigationController pushViewController:zfVC animated:YES];

            BFLog(@"我也要参团");
            break;
        }
        case BFGroupDetailTabbarButtonTypeSuccess:{
            BFPTViewController *ptVC = [[BFPTViewController alloc] init];
            [self.navigationController pushViewController:ptVC animated:YES];
            BFLog(@"组团成功，继续组团");
            break;
        }
        case BFGroupDetailTabbarButtonTypeFail:{
            BFPTDetailViewController *detailVC = [[BFPTDetailViewController alloc] init];
            ItemModel *itemModel = [ItemModel parse:self.model.item];
            detailVC.ID = itemModel.ID;
            [self.navigationController pushViewController:detailVC animated:YES];
            BFLog(@"组团失败，继续组团");
            break;
        }
        case BFGroupDetailTabbarButtonTypeLack:{
            //分享好友来参团
            [self gotoShare];
            BFLog(@"还缺少几人");
            break;
        }
    }
}

#pragma mark --跳转到支付页面
- (void)gotoPay {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=re_order_pay"];
    NSMutableDictionary *paramerer = [NSMutableDictionary dictionary];
    paramerer[@"uid"] = userInfo.ID;
    paramerer[@"token"] = userInfo.token;
    paramerer[@"orderId"] = self.model.user_self.orderid;
//    [BFProgressHUD MBProgressFromView:self.navigationController.view LabelText:@"正在跳转支付页面..." dispatch_get_main_queue:^{
        [BFHttpTool POST:url params:paramerer success:^(id responseObject) {
            if (responseObject) {
                BFLog(@"---%@,,%@",responseObject, paramerer);
                BFLog(@"支付");
                BFGenerateOrderModel *orderModel = [BFGenerateOrderModel parse:responseObject];
                BFPayoffViewController *payVC = [[BFPayoffViewController alloc] init];
                if ([self.model.user_self.pay_type isEqualToString:@"2"]) {
                    payVC.pay = @"支付宝";
                }else {
                    payVC.pay = @"微信支付";
                }
                payVC.orderModel = orderModel;
                payVC.totalPrice = self.model.user_self.order_sumPrice;
                payVC.orderid = self.model.user_self.orderid;
                payVC.addTime = self.model.user_self.addtime;
                payVC.img = [@[self.model.item.img] mutableCopy];
                [BFProgressHUD MBProgressFromView:self.navigationController.view LabelText:@"正在跳转到支付页面..." dispatch_get_main_queue:^{
                    [self.navigationController pushViewController:payVC animated:YES];
                }];
            }
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
            BFLog(@"%@", error);
        }];
//    }];
    //倒计时
    leftTime = Countdown;
    [self.tabbar.payButton setEnabled:NO];
    [self.tabbar.payToJoinButton setEnabled:NO];
    [self.tabbar.payButton setBackgroundColor:BFColor(0xD5D8D1)];
    [self.tabbar.payToJoinButton setBackgroundColor:BFColor(0xD5D8D1)];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

#pragma mark -- 倒计时方法
- (void)timerAction {
    BFLog(@"--------");
    leftTime--;
    if(leftTime<=0)
    {
        [self.tabbar.payButton setEnabled:YES];
        [self.tabbar.payToJoinButton setEnabled:YES];
        self.tabbar.payButton.backgroundColor = BFColor(0xD4041E);
        self.tabbar.payToJoinButton.backgroundColor = BFColor(0xD4041E);
        //倒计时完取消倒计时
        [timer invalidate];
        timer = nil;
    } else
    {
        [self.tabbar.payButton setEnabled:NO];
        [self.tabbar.payToJoinButton setEnabled:NO];
        self.tabbar.payButton.backgroundColor = BFColor(0xD5D8D1);
        self.tabbar.payToJoinButton.backgroundColor = BFColor(0xD5D8D1);

    }
}





#pragma mark -- 去分享
- (void)gotoShare {

    //调用自定义分享
    BFShareView *share = [BFShareView shareView];
    share.delegate = self;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:share];

}


#pragma mark -- 分享页面代理方法

- (void)shareView:(BFShareView *)shareView type:(BFShareButtonType)type {
    
    switch (type) {
        case BFShareButtonTypeQQZone:{
            [self shareWithType:ShareTypeQQSpace];
            break;
        }
        case BFShareButtonTypeQQFriends:{
            [self shareWithType:ShareTypeQQ];
            break;
        }
        case BFShareButtonTypeWechatFriends:{
            [self shareWithType:ShareTypeWeixiSession];
            break;
        }
        case BFShareButtonTypeMoments:{
            [self shareWithType:ShareTypeWeixiTimeline];
            break;
        }
        case BFShareButtonTypeSinaBlog:{
            [self shareWithType:ShareTypeSinaWeibo];
            break;
        }
    }
}


- (void)shareWithType:(ShareType)shareType {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    ItemModel *itemModel = [ItemModel parse:self.model.item];
    if (shareType == ShareTypeSinaWeibo) {
        id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@http://bingo.luexue.com/index.php?m=Teambuy&a=openteam&itemid=%@&teamid=%@&u_id=%@",itemModel.title, self.itemid, self.teamid, userInfo.ID]
                                           defaultContent:itemModel.intro
                                                    image:[ShareSDK imageWithUrl:itemModel.img]
                                                    title:itemModel.title
                                                      url:nil
                                              description:itemModel.title
                                                mediaType:SSPublishContentMediaTypeNews];
        [ShareSDK shareContent:publishContent type:shareType authOptions:nil shareOptions:nil statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            if (state == SSResponseStateSuccess) {
                [BFProgressHUD MBProgressFromView:self.view rightLabelText: @"分享成功"];
                
            }else if (state == SSResponseStateFail) {
                [BFProgressHUD MBProgressFromView:self.view wrongLabelText: @"分享失败"];
                NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
                if ([error errorCode] == 20012) {
                    [BFProgressHUD MBProgressFromView:self.view wrongLabelText: @"分享内容过长,请少于140个字节"];
                }
            }else if (state == SSResponseStateCancel) {
                //[BFProgressHUD MBProgressFromView:self wrongLabelText: @"分享失败"];
            }
            BFLog(@"---%d",state);
        }];
        
    }else {
        id<ISSContent> publishContent = [ShareSDK content:itemModel.intro
                                           defaultContent:itemModel.intro
                                                    image:[ShareSDK imageWithUrl:itemModel.img]
                                                    title:itemModel.title
                                                      url:[NSString stringWithFormat:@"http://bingo.luexue.com/index.php?m=Teambuy&a=openteam&itemid=%@&teamid=%@&u_id=%@", self.itemid, self.teamid, userInfo.ID]
                                              description:itemModel.intro
                                                mediaType:SSPublishContentMediaTypeNews];
        [ShareSDK showShareViewWithType:shareType container:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            BFLog(@"---%d",type);
            if (state == SSResponseStateSuccess) {
                //[self hideShareView];
                [BFProgressHUD MBProgressFromView:self.view rightLabelText: @"分享成功"];
                
            }else if (state == SSResponseStateFail) {
                //[self hideShareView];
                [BFProgressHUD MBProgressFromView:self.view wrongLabelText: @"分享失败"];
                NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
            }else if (state == SSResponseStateCancel) {
                //[self hideShareView];
                //[BFProgressHUD MBProgressOnlyWithLabelText: @"分享失败"];
            }
        }];
        
    }
}




@end
