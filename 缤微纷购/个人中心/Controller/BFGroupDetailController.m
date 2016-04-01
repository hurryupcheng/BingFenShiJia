//
//  BFGroupDetailController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/30.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailController.h"
#import "BFGroupDetailTabbar.h"
#import "BFGroupDetailModel.h"
#import "BFGroupDetailStatusView.h"
#import "BFGroupDetailProductView.h"
#import "BFShareView.h"
#import "BFHeadPortraitView.h"
#import "BFGroupDetailHeaderView.h"

@interface BFGroupDetailController ()<BFGroupDetailTabbarDelegate, UITableViewDelegate, UITableViewDataSource>
/**自定义tabbar*/
@property (nonatomic, strong) BFGroupDetailTabbar *tabbar;
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**BFGroupDetailModel*/
@property (nonatomic, strong) BFGroupDetailModel *model;
/**头部视图*/
@property (nonatomic, strong) NSMutableArray *itemArray;
/**tableViewHeaderView*/
@property (nonatomic, strong) BFGroupDetailHeaderView *headerView;

@end

@implementation BFGroupDetailController


#pragma mark -- 懒加载

- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (BFGroupDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFGroupDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        
    }
    return _headerView;
}


- (BFGroupDetailTabbar *)tabbar {
    if (!_tabbar) {
        _tabbar = [[BFGroupDetailTabbar alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 70)];
        _tabbar.delegate = self;
        [self.view addSubview:_tabbar];
    }
    return _tabbar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
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
    
    [BFHttpTool POST:url params:parameter success:^(id responseObject) {
       
        if (responseObject) {
            self.model = [BFGroupDetailModel parse:responseObject];
            //给头部视图模型赋值
            self.headerView.model = self.model;
            //返回的高度赋值
            self.headerView.height = self.headerView.headerViewH;
            self.tableView.tableHeaderView = self.headerView;
            //给状态栏赋值
            self.tabbar.model = self.model;
            BFLog(@"---%@,%@,,%f",responseObject,parameter,self.headerView.height);
            [self.tableView reloadData];
            [self animation];
        }
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
}

#pragma mark --添加动画效果
- (void)animation {
    [UIView animateWithDuration:0.5 animations:^{
        self.tabbar.y = ScreenHeight - 134;
    }];
}




- (void)setUpFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(400))];
    view.backgroundColor = BFColor(0xCACACA);
    self.tableView.tableFooterView = view;
    
//    self.headPortrait = [[BFHeadPortraitView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(20), ScreenWidth, 0)];
//    self.headPortrait.model = self.model;
//    self.headPortrait.height = self.headPortrait.headPortraitViewH;
//    BFLog(@"头像--%f,",self.headPortrait.height);
//    [view addSubview:self.headPortrait];
    
}

#pragma mark --tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
    }
    cell.textLabel.text = @"hahah";
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(44);
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
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            BFShareView *shareView = [BFShareView shareView];
            [window addSubview:shareView];
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
            BFLog(@"我也要参团");
            break;
        }
        case BFGroupDetailTabbarButtonTypeSuccess:{
            BFLog(@"组团成功，继续组团");
            break;
        }
        case BFGroupDetailTabbarButtonTypeFail:{
            BFLog(@"组团失败，继续组团");
            break;
        }
        case BFGroupDetailTabbarButtonTypeLack:{
            BFLog(@"还缺少几人");
            break;
        }
    }
}
@end
