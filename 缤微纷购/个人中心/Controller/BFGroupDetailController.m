//
//  BFGroupDetailController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/30.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
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

@interface BFGroupDetailController ()<BFGroupDetailTabbarDelegate, UITableViewDelegate, UITableViewDataSource>
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
}


//移除通知
- (void)dealloc {
    [BFNotificationCenter removeObserver:self];
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
                NSArray *array = [TeamList parse:self.model.thisteam];
                [self.teamArray addObjectsFromArray:array];
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
            BFLog(@"立即支付");
            break;
        }
        case BFGroupDetailTabbarButtonTypePayToJoin:{
            
            BFLog(@"立即支付参团");
            break;
        }
        case BFGroupDetailTabbarButtonTypeJoin:{
            BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
            BFZFViewController *zfVC = [[BFZFViewController alloc] init];
            ItemModel *itemModel = [ItemModel parse:self.model.item];
            zfVC.ID = itemModel.ID;
            NSMutableArray *mutableArray = [NSMutableArray array];
            [mutableArray addObject:itemModel];
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

#pragma mark -- 去分享
- (void)gotoShare {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    ItemModel *itemModel = [ItemModel parse:self.model.item];
    id<ISSContent> publishContent = [ShareSDK content:itemModel.intro
                                       defaultContent:itemModel.intro
                                                image:[ShareSDK imageWithUrl:itemModel.img]
                                                title:itemModel.title
                                                  url:[NSString stringWithFormat:@"http://bingo.luexue.com/index.php?m=Teambuy&a=openteam&itemid=%@&teamid=%@&u_id=%@", self.itemid, self.teamid, userInfo.ID]
                                          description:itemModel.intro
                                            mediaType:SSPublishContentMediaTypeNews];
    //调用自定义分享
    BFShareView *share = [BFShareView shareView:publishContent];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:share];

}




@end
