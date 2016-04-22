//
//  BFTastingExperienceController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFTastingExperienceController.h"
#import "BFShareView.h"
#import "BFTastingExperienceModel.h"
#import "BFTastingExperienceHeaderView.h"
#import "BFTastingExperienceFooterView.h"
#import "BFTastingExperienceCell.h"

@interface BFTastingExperienceController ()<UITableViewDelegate, UITableViewDataSource, BFTastingExperienceFooterViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**数组*/
@property (nonatomic, strong) NSArray *listArray;
/**免费试吃数据模型*/
@property (nonatomic, strong) BFTastingExperienceModel *model;
/**头部视图*/
@property (nonatomic, strong) BFTastingExperienceHeaderView *headerView;
/**底部视图*/
@property (nonatomic, strong) BFTastingExperienceFooterView *footerView;
@end

@implementation BFTastingExperienceController

#pragma mark --懒加载

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = @[@"图文详情", @"试吃规则", @"试吃体验"];
    }
    return _listArray;
}

- (BFTastingExperienceFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[BFTastingExperienceFooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(115))];
        _footerView.delegate = self;
    }
    return _footerView;
}

- (BFTastingExperienceHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFTastingExperienceHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(395))];
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

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"免费试吃";
    self.view.backgroundColor = BFColor(0xffffff);
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
    self.tabBarController.tabBar.hidden = YES;
    //添加tableviewView
    [self tableView];
    //添加navigationbar
    [self setUpNavigationBar];
    //加载数据
    [self getData];
}

#pragma mark -- 加载数据
- (void)getData {
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=item"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"id"] = @"2989";
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"%@", responseObject);
            if (responseObject) {
                self.model = [BFTastingExperienceModel parse:responseObject];
                self.tableView.tableHeaderView = self.headerView;
                self.tableView.tableFooterView = self.footerView;
                self.headerView.model = self.model;
                self.footerView.model = self.model;
                [UIView animateWithDuration:0.5 animations:^{
                    self.tableView.y = 0;
                }];
            }
        } failure:^(NSError *error) {
            BFLog(@"%@", error);
        }];

    }];
//    [BFProgressHUD MBProgressFromView:self.navigationController.view LabelText:@"正在请求" dispatch_get_main_queue:^{
//            }];
}

#pragma mark -- 设置客服按钮
- (void)setUpNavigationBar {
    UIButton *share = [UIButton buttonWithType:0];
    //telephone.backgroundColor = [UIColor redColor];
    share.width = 30;
    share.height = 30;
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [share setImage:[UIImage imageNamed:@"iconfont-fenxiang-6"] forState:UIControlStateNormal];
    UIBarButtonItem *telephoneItem = [[UIBarButtonItem alloc] initWithCustomView:share];
    self.navigationItem.rightBarButtonItem = telephoneItem;
}

#pragma mark -- 分享事件
- (void)share {
    id<ISSContent> publishContent = [ShareSDK content:@"测试测试"
                                       defaultContent:@"ddsf"
                                                image:nil
                                                title:@"这是一个分享测试"
                                                  url:@"www.baidu.com"
                                          description:@"哈哈哈"
                                            mediaType:SSPublishContentMediaTypeNews];
    //调用自定义分享
    BFShareView *share = [BFShareView shareView:publishContent];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:share];
}

#pragma mark -- 申请按钮
- (void)gotoApply {
    BFLog(@"去申请");
}


#pragma mark -- tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFTastingExperienceCell *cell = [BFTastingExperienceCell cellWithTableView:tableView];
    cell.titleLabel.text = self.listArray[indexPath.row];
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return BF_ScaleHeight(44);

}


@end
