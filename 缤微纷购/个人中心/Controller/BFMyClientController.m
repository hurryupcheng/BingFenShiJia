//
//  BFMyClientController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyClientController.h"
#import "BFMyCustomerCell.h"
#import "BFMyCustomerModel.h"
#import "BFCustomerServiceView.h"

@interface BFMyClientController ()<UITableViewDelegate, UITableViewDataSource, BFSegmentViewDelegate, BFCustomerServiceViewDelegate>

/**底部tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;
/**参数字典*/
@property (nonatomic, strong) NSMutableDictionary *parameter;
/**客户数组*/
@property (nonatomic, strong) NSMutableArray *customerArray;
/**BFMyCustomerModel*/
@property (nonatomic, strong) BFMyCustomerModel *model;
/**分页数*/
@property (nonatomic, assign) NSUInteger page;
/**页数label*/
@property (nonatomic, strong) UILabel *pageLabel;
/**判断是不是第一次加载数据*/
@property (nonatomic, assign) BOOL isFirstTime;

@end

@implementation BFMyClientController





- (NSMutableArray *)customerArray {
    if (!_customerArray) {
        _customerArray = [NSMutableArray array];
    }
    return _customerArray;
}

- (NSMutableDictionary *)parameter {
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionary];
    }
    return _parameter;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50-ScreenHeight, ScreenWidth, ScreenHeight-116) style:UITableViewStylePlain];
        _tableView.backgroundColor = BFColor(0xEBEBEB);
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
        _segment.delegate = self;
        _segment.titleArray = @[@"已关注", @"未关注", @"直推人数", @"团队人数"];
        [self.view addSubview:_segment];
    }
    return _segment;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的客户";
    self.view.backgroundColor = BFColor(0xEBEBEB);
    self.page = 1;
    self.isFirstTime = YES;
    //添加navigationbar
    [self setUpNavigationBar];
    //添加底部tableView
    [self tableView];
    //添加分段控制器
    [self segment];
    self.segment.segmented.selectedSegmentIndex = 0;
    [self.segment click];
    //上啦刷新
    [self setupUpRefresh];
    //添加页数
   
    
}

#pragma mark --获取数据
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

// 集成上拉刷新控件
- (void)setupUpRefresh {
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadMoreData {
    self.page++;
    if (self.page > self.model.page_count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"没有更多数据"];
        return;
    }else {
        [self getData];
    }
}

#pragma mark -- getData
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=my_customers"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    self.parameter[@"page"] = @(self.page);
    //判断是不是第一次加载，第一次加载就有弹窗
    if (self.isFirstTime) {
        [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
            [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
        } dispatch_get_main_queue:^{
            [BFHttpTool POST:url params:self.parameter success:^(id responseObject) {
            
                if (responseObject) {
                    self.model = [BFMyCustomerModel parse:responseObject];
                    if ([self.model.sub_list isKindOfClass:[NSArray class]]) {
                        NSArray *array = [BFCustomerList parse:self.model.sub_list];
                        if (array.count != 0) {
                            [self.customerArray addObjectsFromArray:array];
                            [self showPage];
                        } else {
                            [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"数据为空"];
                        }
                    }else {
                        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"数据为空"];
                    }
                }
                [self.tableView reloadData];
                self.isFirstTime = NO;
                BFLog(@"%@,%@",responseObject,self.parameter);
                [self animation];
                [self.tableView.mj_footer endRefreshing];
            } failure:^(NSError *error) {
                [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络异常"];
                [self.tableView.mj_footer endRefreshing];
                self.page--;
                BFLog(@"%@", error);
            }];
        }];
    }else {
        [BFHttpTool POST:url params:self.parameter success:^(id responseObject) {
            if (responseObject) {
                
                self.model = [BFMyCustomerModel parse:responseObject];
                NSArray *array = [BFCustomerList parse:self.model.sub_list];
                [self.customerArray addObjectsFromArray:array];
                [self showPage];
            }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络异常"];
            [self.tableView.mj_footer endRefreshingWithNoNoHTTP];
            self.page--;
            BFLog(@"%@", error);
        }];

    }
}

- (void)animation {
       [UIView animateWithDuration:0.5 animations:^{
        self.tableView.y = 50;
    }];
}

- (void)showPage {
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(110), BF_ScaleHeight(450), BF_ScaleWidth(100), BF_ScaleHeight(20))];
    _pageLabel.text = [NSString stringWithFormat:@"%lu / %ld",(unsigned long)self.page, (long)self.model.page_count];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    _pageLabel.textColor = BFColor(0xffffff);
    //_pageLabel.hidden = YES;
    _pageLabel.backgroundColor = BFColor(0x000000);
    _pageLabel.alpha = 0;
    [self.view addSubview:_pageLabel];
}

#pragma mark --BFSegmentView代理方法
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    self.page = 1;
    self.isFirstTime = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.y = 50-ScreenHeight;
    }];
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:{
            self.parameter[@"status"] = @"1";
             [self.customerArray removeAllObjects];
            [self getData];
            
            BFLog(@"点击已关注");
            break;
        }
        case 1:{
            self.parameter[@"status"] = nil;
             [self.customerArray removeAllObjects];
            [self getData];
            
            BFLog(@"点击未关注");
            break;
        }
        case 2:{
            
            self.parameter[@"status"] = @"2";
             [self.customerArray removeAllObjects];
            [self getData];
            BFLog(@"点击直推人数");
            break;
        }
        case 3:
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:[NSString stringWithFormat:@"团队人数%@",self.model.team_num]];
            BFLog(@"点击团队人数");
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

#pragma mark --tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.customerArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyCustomerCell *cell = [BFMyCustomerCell cellWithTabelView:tableView];
    cell.model = self.customerArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(110);
}



//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [UIView animateWithDuration:0.2 animations:^{
//        self.pageLabel.alpha = 0;
//    }];
//}
//
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [UIView animateWithDuration:0.2 animations:^{
//        self.pageLabel.alpha = 0.6;
//    }];
//}
//
//
////减速停止了时执行，手触摸时执行执行
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
//{
//    [UIView animateWithDuration:0.2 animations:^{
//        self.pageLabel.alpha = 0;
//    }];
//
//}





@end
