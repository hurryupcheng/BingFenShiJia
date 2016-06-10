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
//返回顶部按钮
@property (nonatomic, strong) UIButton *TopButton;
//偏移量
@property (nonatomic, assign) CGFloat contentOffSetY;

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
        [self.tableView.mj_footer endRefreshing];
        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,没有更多的客户了哦!"];
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
//        [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
//            [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
//        } dispatch_get_main_queue:^{
        [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
            
            [BFHttpTool POST:url params:self.parameter success:^(id responseObject) {
            
                if (responseObject) {
                    self.model = [BFMyCustomerModel parse:responseObject];
                    [self.customerArray removeAllObjects];
                    if ([responseObject[@"sub_list"] isKindOfClass:[NSArray class]]) {
                        NSArray *array = [BFCustomerList parse:self.model.sub_list];
                        if (array.count != 0) {
                            [self.customerArray addObjectsFromArray:array];
                        } else {
                            [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有客户哦!"];
                        }
                    }else {
                        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时还没有客户哦!"];
                    }
                }
                [hud hideAnimated:YES];
                [self.tableView reloadData];
                self.isFirstTime = NO;
                BFLog(@"%@,%@",responseObject,self.parameter);
                [self animation];
                [self.tableView.mj_footer endRefreshing];
            } failure:^(NSError *error) {
                [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络异常"];
                [hud hideAnimated:YES];
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


#pragma mark --BFSegmentView代理方法
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    self.page = 1;
    self.isFirstTime = YES;
    [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.y = 50-ScreenHeight;
    }];
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:{
            self.parameter[@"status"] = @"1";
            [self getData];
            
            BFLog(@"点击已关注");
            break;
        }
        case 1:{
            self.parameter[@"status"] = nil;
            [self getData];
            
            BFLog(@"点击未关注");
            break;
        }
        case 2:{
            self.parameter[@"status"] = @"2";
            [self getData];
            BFLog(@"点击直推人数");
            break;
        }
        case 3:
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:[NSString stringWithFormat:@"亲,团队有%@人哦!",self.model.team_num]];
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
