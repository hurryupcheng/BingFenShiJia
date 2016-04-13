//
//  BFPanicBuyingController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPanicBuyingController.h"
#import "BFCustomerServiceView.h"
#import "BFPanicBuyingCell.h"
#import "BFPanicBuyingTabBar.h"
#import "BFPanicBuyingModel.h"
#import "BFPanicBuyingHeaderView.h"
@interface BFPanicBuyingController ()<UITableViewDelegate, UITableViewDataSource, BFCustomerServiceViewDelegate, BFPanicBuyingTabBarDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**数组*/
@property (nonatomic, strong) NSArray *listArray;
/**tabbar*/
@property (nonatomic, strong) BFPanicBuyingHeaderView *headerView;
/**tabbar*/
@property (nonatomic, strong) BFPanicBuyingTabBar *tabBar;
/**BFPanicBuyingModel*/
@property (nonatomic, strong) BFPanicBuyingModel *model;
@end

@implementation BFPanicBuyingController

#pragma mark -- 懒加载
- (BFPanicBuyingHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFPanicBuyingHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    }
    return _headerView;
    
}


- (BFPanicBuyingTabBar *)tabBar {
    if (!_tabBar) {
        _tabBar = [[BFPanicBuyingTabBar alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, BF_ScaleHeight(50))];
        _tabBar.delegate = self;
        [self.view addSubview:_tabBar];
    }
    return _tabBar;
}

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = @[@"商品详情", @"抢购说明"];
    }
    return _listArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight- BF_ScaleHeight(50)-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"抢购";
    self.view.backgroundColor = BFColor(0xffffff);
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
    self.tabBarController.tabBar.hidden = YES;
    //添加tableView
    [self tableView];
    //添加navigationbar
    [self setUpNavigationBar];
    //添加tabbar
    [self tabBar];
    //请求数据
    [self getData];
    
}

#pragma mark -- 请求数据
- (void)getData {
    NSString *url = @"http://bingo.luexue.com/index.php?m=Json&a=item";
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"id"] = self.ID;
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        
        if (responseObject) {
            self.model = [BFPanicBuyingModel parse:responseObject];
            self.headerView.model = self.model;
            
            [UIView animateWithDuration:0.5 animations:^{
                self.headerView.height = BF_ScaleHeight(500);
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

#pragma mark -- 自定义tabbar代理
- (void)clickToPanic {
    BFLog(@"立即抢购");
}

#pragma mark -- 设置客服按钮
- (void)setUpNavigationBar {
    UIButton *telephone = [UIButton buttonWithType:0];
    //telephone.backgroundColor = [UIColor redColor];
    telephone.width = 30;
    telephone.height = 30;
    [telephone addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [telephone setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
    UIBarButtonItem *telephoneItem = [[UIBarButtonItem alloc] initWithCustomView:telephone];
    self.navigationItem.rightBarButtonItem = telephoneItem;
}

- (void)click {
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



#pragma mark -- tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFPanicBuyingCell *cell = [BFPanicBuyingCell cellWithTableView:tableView];
    cell.textLabel.text = self.listArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(40);
}

@end
