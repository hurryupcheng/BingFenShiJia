//
//  BFBestSellingController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFBestSellingController.h"
#import "BFBestSellingCell.h"
#import "BFBestSellingModel.h"
#import "BFStorage.h"
#import "CXArchiveShopManager.h"
#import "FXQViewController.h"
#import "LogViewController.h"
#import "BFCustomerServiceView.h"

@interface BFBestSellingController ()<UITableViewDelegate, UITableViewDataSource, BFBestSellingCellDelegate, BFCustomerServiceViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**模型*/
@property (nonatomic, strong) BFBestSellingModel *model;
/**热销商品数组*/
@property (nonatomic, strong) NSMutableArray *bestSellingArray;
/**请求数据的可变字典*/
@property (nonatomic, strong) NSMutableDictionary *parameter;
/**页数*/
@property (nonatomic, assign) NSInteger page;
@end

@implementation BFBestSellingController

#pragma mark -- 懒加载

- (NSMutableDictionary *)parameter {
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionary];
    }
    return _parameter;
}

- (NSMutableArray *)bestSellingArray {
    if (!_bestSellingArray) {
        _bestSellingArray = [NSMutableArray array];
    }
    return _bestSellingArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight-22)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BFColor(0xF4F4F4);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热销排行";
    self.view.backgroundColor = BFColor(0xffffff);
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
    self.page = 1;
    //添加tableView
    [self tableView];
    //加载数据
    [self getData];
    //集成上拉加载更多数据
    [self setupUpRefresh];
    //[添加导航栏]
    [self setUpNavigationBar];
}

#pragma mark -- 集成上拉加载更多数据
- (void)setupUpRefresh {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadMoreData {
    self.page++;
    if (self.page > self.model.page_num) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [self getData];
}

#pragma mark -- 获取数据
- (void)getData {
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=hot_buy"];
    self.parameter[@"page"] = @(self.page);
    [BFHttpTool GET:url params:self.parameter success:^(id responseObject) {
        BFLog(@"%@", responseObject);
        if (responseObject) {
            self.model = [BFBestSellingModel parse:responseObject];
            if ([responseObject[@"item"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFBestSellingList parse:self.model.item];
                [self.bestSellingArray addObjectsFromArray:array];
            }
            [self.tableView reloadData];
            //增加动画效果
            [self animate];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"请检查网络设置"];
        [self.tableView.mj_footer endRefreshingWithNoNoHTTP];
        self.page--;
        BFLog(@"%@", error);
    }];
}
#pragma mark -- 增加动画效果
- (void)animate{
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.y = 0;
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
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //添加取消按钮
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击");
            }];
            //添加电话按钮
            UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:@"020-38875719" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://020-38875719"]]];
            }];
            [alertC addAction:cancleAction];
            [alertC addAction:phoneAction];
            [self presentViewController:alertC animated:YES completion:nil];
            
            break;
        }
        case BFCustomerServiceViewButtonTypeWechat:
            BFLog(@"点击微信客服");
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"暂不支持，尽请期待"];
            break;
            
    }
}



#pragma mark -- viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark -- tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bestSellingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFBestSellingCell *cell = [BFBestSellingCell cellWithTableView:tableView];
    cell.model = self.bestSellingArray[indexPath.row];
    cell.shoppingCart.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFBestSellingList *list = self.bestSellingArray[indexPath.row];
    FXQViewController *fxqVC = [[FXQViewController alloc] init];
    fxqVC.ID = list.ID;
    [self.navigationController pushViewController:fxqVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(95);
}

#pragma mark -- BFBestSellingCellDelegate
- (void)addToShoppingCartWithButton:(UIButton *)button {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (userInfo) {
        BFBestSellingList *list = self.bestSellingArray[button.tag];
        BFLog(@"-----%@",list.title);
        BFStorage *storage = [[BFStorage alloc]initWithTitle:list.title img:list.img money:list.price number:1 shopId:list.ID stock:list.stock choose:list.size color:list.color];
        
        [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:storage];
        [[CXArchiveShopManager sharedInstance]startArchiveShop];
    }else {
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
            self.navigationController.navigationBarHidden = NO;
            LogViewController *logVC= [LogViewController new];
            [self.navigationController pushViewController:logVC animated:YES];
        }];
    }
    
    

}

@end
