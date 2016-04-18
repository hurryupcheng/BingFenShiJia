//
//  BFDailySpecialController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFDailySpecialController.h"
#import "BFPanicBuyingController.h"
#import "BFDailySpecialCell.h"
#import "BFDailySpecialModel.h"
#import "BFDailySpecialHeaderView.h"
#import "BFStorage.h"
#import "CXArchiveShopManager.h"
#import "LogViewController.h"
#import "BFNavigaitonShopCartIButton.h"

@interface BFDailySpecialController ()<UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**头部视图*/
@property (nonatomic, strong) BFDailySpecialHeaderView *headerView;
/**模型*/
@property (nonatomic, strong) BFDailySpecialModel *model;
/**导航栏购物车*/
@property (nonatomic, strong) BFNavigaitonShopCartIButton *shoppingCart;
/**产品可变数组*/
@property (nonatomic, strong) NSMutableArray *productArray;


@end

@implementation BFDailySpecialController




- (NSMutableArray *)productArray {
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}


- (BFDailySpecialHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFDailySpecialHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight-22)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.backgroundColor = BFColor(0xF4F4F4);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日特价";
    self.view.backgroundColor = BFColor(0xffffff);
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
    self.tabBarController.tabBar.hidden = YES;
    //添加tableview
    [self tableView];
    //添加navigationbar
    [self setUpNavigationBar];
    //加载数据
    [self getData];
    //接收通知
    [BFNotificationCenter addObserver:self selector:@selector(addToShoppingCart:) name:@"BFDailySpecialProductView" object:nil];
    //改变倒计时
    [BFNotificationCenter addObserver:self selector:@selector(changeView) name:@"changeView" object:nil];
    //去登陆
    [BFNotificationCenter addObserver:self selector:@selector(gotoLogin) name:@"gotoLogin" object:nil];
    //改变导航栏
    [BFNotificationCenter addObserver:self selector:@selector(navigationBarChange) name:@"navigationBarChange" object:nil];
    //登陆后改变导航栏数值
    [BFNotificationCenter addObserver:self selector:@selector(navigationBarBadge) name:@"navigationBarBadge" object:nil];

    
}

//移除通知
- (void)dealloc {
    [BFNotificationCenter removeObserver:self];
}

#pragma mark -- 加载数据
- (void)getData {
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=special_list"];
    [BFHttpTool GET:url params:nil success:^(id responseObject) {
        BFLog(@"%@", responseObject);
        if (responseObject) {
            self.model = [BFDailySpecialModel parse:responseObject];
            self.headerView.model = self.model;
            if ([self.model.item isKindOfClass:[NSArray class]]) {
                [self.productArray removeAllObjects];
                NSArray *array = [BFDailySpecialProductList parse:self.model.item];
                [self.productArray addObjectsFromArray:array];
                BFLog(@"===%lu",(unsigned long)self.productArray.count);
            }
            BFLog(@"+++%lu",(unsigned long)self.productArray.count);
            [self.tableView reloadData];
            [UIView animateWithDuration:0.5 animations:^{
                if (self.model.ads != nil) {
                    self.headerView.height = BF_ScaleHeight(200);
                    self.tableView.tableHeaderView = self.headerView;
                }else {
                    self.headerView.height = BF_ScaleHeight(0);
                }
                
                self.tableView.y = 0;
            }];
        }
    } failure:^(NSError *error) {
        BFLog(@"%@", error);
    }];
}



#pragma mark -- 设置客服按钮
- (void)setUpNavigationBar {
    BFNavigaitonShopCartIButton *shoppingCart = [BFNavigaitonShopCartIButton buttonWithType:0];
    self.shoppingCart = shoppingCart;
    //shoppingCart.backgroundColor = [UIColor redColor];
    shoppingCart.width = 40;
    shoppingCart.height = 40;
    [shoppingCart addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    //[shoppingCart setImage:[UIImage imageNamed:@"ff1"] forState:UIControlStateNormal];
    UIBarButtonItem *telephoneItem = [[UIBarButtonItem alloc] initWithCustomView:shoppingCart];
    UIBarButtonItem *leftSpace = [UIBarButtonItem leftSpace:BF_ScaleWidth(-15)];
    self.navigationItem.rightBarButtonItems = @[leftSpace, telephoneItem];
    

    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (userInfo) {
        [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:nil];
        NSArray *array = [[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop];
        BFLog(@"---%lu", (unsigned long)array.count);
        if (array.count == 0) {
            shoppingCart.badge.hidden = YES;
        }else {
            shoppingCart.badge.hidden = NO;
            shoppingCart.badge.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        }
    }else {
        shoppingCart.badge.hidden = YES;
    }
}

- (void)click {
    self.tabBarController.selectedIndex = 1;
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (userInfo) {
        [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:nil];
        NSMutableArray *array = [[[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop] mutableCopy];
        if (array == 0) {
            self.shoppingCart.badge.hidden = YES;
        }else {
            self.shoppingCart.badge.hidden = NO;
            BFLog(@"---%lu", (unsigned long)array.count);
            self.shoppingCart.badge.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        }
    }else {
        self.shoppingCart.badge.hidden = YES;
    }
}

#pragma mark -- tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFDailySpecialCell *cell = [BFDailySpecialCell cellWithTableView:tableView];
    cell.model = self.productArray[indexPath.row];
    cell.productView.shoppingCart.tag = indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFDailySpecialProductList *list = self.productArray[indexPath.row];
    BFPanicBuyingController *panicBuying = [[BFPanicBuyingController alloc] init];
    panicBuying.ID = list.ID;
    [self.navigationController pushViewController:panicBuying animated:YES];
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  BF_ScaleHeight(155);
}


#pragma mark -- 通知方法
- (void)addToShoppingCart:(NSNotification *)notification {
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    BFDailySpecialProductList *list = self.productArray[[notification.userInfo[@"tag"] integerValue]];

    BFStorage *storage = [[BFStorage alloc]initWithTitle:list.title img:list.img money:list.price number:1 shopId:list.ID stock:[NSString stringWithFormat:@"%ld", (long)list.stock] choose:list.size color:list.color];
    [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:storage];
    [[CXArchiveShopManager sharedInstance]startArchiveShop];
    
    NSArray *array = [[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop];
    UITabBarController *tabBar = [self.tabBarController viewControllers][1];
    tabBar.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
    
}

#pragma mark -- 改变导航栏图标
- (void)navigationBarChange {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (userInfo) {
        [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:nil];
        NSMutableArray *array = [[[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop] mutableCopy];
        if (array == 0) {
            self.shoppingCart.badge.hidden = YES;
        }else {
            self.shoppingCart.badge.hidden = NO;
            BFLog(@"---%lu", (unsigned long)array.count);
            self.shoppingCart.badge.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        }
    }else {
        self.shoppingCart.badge.hidden = YES;
    }
}




#pragma mark -- 去登录
- (void)gotoLogin {
    [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
        self.navigationController.navigationBarHidden = NO;
        LogViewController *logVC= [LogViewController new];
        [self.navigationController pushViewController:logVC animated:YES];
    }];

}



#pragma mark -- 通知方法重新加载数据
- (void)changeView {
    [self getData];
    
}

@end
