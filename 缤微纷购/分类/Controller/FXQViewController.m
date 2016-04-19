//
//  FXQViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFShareView.h"
#import "BFStorage.h"
#import "FXQViewController.h"
#import "LogViewController.h"
#import "BFProductDetailWebViewController.h"
#import "CXArchiveShopManager.h"
#import "BFProductDetialModel.h"
#import "BFProductDetailTabBar.h"
#import "BFProductDetailHeaderView.h"
#import "BFDetailCell.h"

@interface FXQViewController ()<UITableViewDelegate, UITableViewDataSource, BFProductDetailTabBarDelegate, BFShopCartAnimationDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**自定义tabBar*/
@property (nonatomic, strong) BFProductDetailTabBar *tabBar;
/**自定义头部视图*/
@property (nonatomic, strong) BFProductDetailHeaderView *headerView;
/**BFProductDetialModel*/
@property (nonatomic, strong) BFProductDetialModel *model;

@property (nonatomic, strong) NSMutableArray<CALayer *> *redLayers;
@end

@implementation FXQViewController

#pragma mark -- 懒加载

- (NSMutableArray<CALayer *> *)redLayers {
    if (!_redLayers) {
        _redLayers = [NSMutableArray array];
    }
    return _redLayers;
}

- (BFProductDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFProductDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    }
    return _headerView;
    
}

- (BFProductDetailTabBar *)tabBar {
    if (!_tabBar) {
        _tabBar = [[BFProductDetailTabBar alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, BF_ScaleHeight(50))];
        _tabBar.backgroundColor = BFColor(0xEFEFEF);
        _tabBar.delegate = self;
        [self.view addSubview:_tabBar];
    }
    return _tabBar;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight-BF_ScaleHeight(50)-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"商品详情";
    /**添加导航栏*/
    [self initWithNavigationItem];
    /**添加tableView*/
    [self tableView];
    /***/
    [self tabBar];
    /**获取数据*/
    [self getData];
}

#pragma mark --viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (userInfo) {
        [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:nil];
        NSMutableArray *array = [[[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop] mutableCopy];
        if (array == 0) {
            self.tabBar.shoppingCart.badge.hidden = YES;
        }else {
            self.tabBar.shoppingCart.badge.hidden = NO;
            BFLog(@"---%lu", (unsigned long)array.count);
            self.tabBar.shoppingCart.badge.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        }
    }else {
        self.tabBar.shoppingCart.badge.hidden = YES;
    }

    
}

#pragma mark --获取数据
- (void)getData {
    NSString *url = @"http://bingo.luexue.com/index.php?m=Json&a=item";
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"id"] = self.ID;
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        
        if (responseObject) {
            self.model = [BFProductDetialModel parse:responseObject];
            self.headerView.model = self.model;

            [UIView animateWithDuration:0.5 animations:^{
                self.headerView.height = self.headerView.headerHeight;
                self.tableView.tableHeaderView = self.headerView;
                self.tabBar.y = ScreenHeight - 64 - BF_ScaleHeight(50);
                self.tableView.y = 0;
    
            }];

            BFLog(@"%@", responseObject);
        }
    } failure:^(NSError *error) {
        BFLog(@"%@", error);
    }];
}


#pragma mark --添加导航栏
- (void)initWithNavigationItem{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-fenxiang-6.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(share)];
}

#pragma mark --分享按钮点击事件
- (void)share {
    id<ISSContent> publishContent = [ShareSDK content:self.model.intro
                                       defaultContent:nil
                                                image:[ShareSDK imageWithUrl:self.model.img]
                                                title:self.model.title
                                                  url:[NSString stringWithFormat:@"http://bingo.luexue.com/index.php?m=Item&a=index&id=%@", self.ID]
                                          description:self.model.title
                                            mediaType:SSPublishContentMediaTypeNews];
    //调用自定义分享
    BFShareView *share = [BFShareView shareView:publishContent];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:share];

}

#pragma mark --BFProductDetailTabBarDelegate
- (void)clickWithType:(BFProductDetailTabBarButtonType)type {
    switch (type) {
        case BFProductDetailTabBarButtonTypeGoCart:{
            self.tabBarController.selectedIndex = 1;
            [self.navigationController popToRootViewControllerAnimated:YES];
            BFLog(@"进入购物车");
            break;
        }
        case BFProductDetailTabBarButtonTypeAddCart:{
            BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
            if (userInfo == nil) {
                [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
                    LogViewController *logVC= [LogViewController new];
                    [self.navigationController pushViewController:logVC animated:YES];
                    self.navigationController.navigationBarHidden = NO;
                }];
                
            }else if ([self.model.first_stock integerValue] < 1) {
                [BFProgressHUD MBProgressOnlyWithLabelText:@"商品已经售罄"];
                return;
            }else if (userInfo != nil) {
                BFStorage *storage = [[BFStorage alloc]initWithTitle:self.model.title img:self.model.img money:self.model.price number:[self.headerView.stockView.countView.countTX.text integerValue] shopId:self.model.ID stock:self.model.first_stock choose:self.model.first_size color:self.model.first_color];
                
                [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:storage];
                [[CXArchiveShopManager sharedInstance]startArchiveShop];

     


                
                [self animationStart];
            }
            BFLog(@"加入购物车");
            break;
        }
    }
}


//购物车动画
- (void)animationStart{
    //获取动画起点
    CGPoint start = [self.headerView convertPoint:self.headerView.cycleScrollView.center toView:self.view];
    //获取动画终点
    CGPoint end = [self.tabBar convertPoint:self.tabBar.shoppingCart.center toView:self.view];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.img]];
    //创建layer
    CALayer *chLayer = [[CALayer alloc] init];
    NSURL *url = [NSURL URLWithString:self.model.img];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    chLayer.contents = (UIImage *)image.CGImage;
    [self.redLayers addObject:chLayer];
    chLayer.frame = CGRectMake(self.headerView.cycleScrollView.centerX, self.headerView.cycleScrollView.centerY, BF_ScaleHeight(100), BF_ScaleHeight(100));
    //chLayer.cornerRadius = BF_ScaleHeight(20);
    chLayer.masksToBounds = YES;
    chLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:chLayer];
    
    
    BFShopCartAnimation *animation = [[BFShopCartAnimation alloc]init];
    animation.delegate = self;
    [animation shopCatrAnimationWithLayer:chLayer startPoint:start endPoint:end changeX:start.x-BF_ScaleWidth(50) changeY:start.y-BF_ScaleHeight(100) endScale:0.20f  duration:1 isRotation:NO];
}


//动画代理动画结束移除layer
- (void)animationStop {
    BFStorage *storage = [[BFStorage alloc]initWithTitle:self.model.title img:self.model.img money:self.model.price number:[self.headerView.stockView.countView.countTX.text integerValue] shopId:self.model.ID stock:self.model.first_stock choose:self.model.first_size color:self.model.first_color];
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:storage];
    NSArray *array = [[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop];
    BFLog(@"---%lu", (unsigned long)array.count);
    UITabBarController *tabBar = [self.tabBarController viewControllers][1];
    tabBar.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
    if (array.count == 0 || userInfo == nil) {
        self.tabBar.shoppingCart.badge.hidden = YES;
    }else {
        self.tabBar.shoppingCart.badge.hidden = NO;
        self.tabBar.shoppingCart.badge.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        
    }
    [self.redLayers[0] removeFromSuperlayer];
    [self.redLayers removeObjectAtIndex:0];
}


#pragma mark --tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFDetailCell *cell = [BFDetailCell cellWithTableView:tableView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFProductDetailWebViewController *webVC = [[BFProductDetailWebViewController alloc] init];
    webVC.info = self.model.info;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(40);
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}





@end
