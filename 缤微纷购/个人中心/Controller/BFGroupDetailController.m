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
#import "BFGroupDetailHeader.h"
#import "BFGroupDetailProductCell.h"
#import "BFShareView.h"
#import "BFHeadPortraitView.h"

@interface BFGroupDetailController ()<BFGroupDetailTabbarDelegate, UITableViewDelegate, UITableViewDataSource>
/**自定义tabbar*/
@property (nonatomic, strong) BFGroupDetailTabbar *tabbar;
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**头部视图*/
@property (nonatomic, strong) BFGroupDetailHeader *headerView;
/**BFGroupDetailModel*/
@property (nonatomic, strong) BFGroupDetailModel *model;
/**头部视图*/
@property (nonatomic, strong) NSMutableArray *itemArray;

@property (nonatomic, strong) BFHeadPortraitView *headPortrait;
@end

@implementation BFGroupDetailController


#pragma mark -- 懒加载

- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
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

- (BFGroupDetailHeader *)headerView {
    if (!_headerView) {
        _headerView = [[BFGroupDetailHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(70))];
        
        [self.view addSubview:_headerView];
    }
    return _headerView;
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
    //头部视图
    [self setUpHeaderView];
    //
    [self setUpFooterView];
    
    
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
            ItemModel *itemModel = [ItemModel parse:self.model.item];
            [self.itemArray addObject:itemModel];
            
            self.tabbar.model = self.model;
            self.headerView.model = self.model;
            BFLog(@"---%@,%@,,%lu",responseObject,parameter,(unsigned long)self.itemArray.count);
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

#pragma mark --添加头部视图
- (void)setUpHeaderView {
    self.tableView.tableHeaderView = self.headerView;
}

- (void)setUpFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(400))];
    view.backgroundColor = BFColor(0xeeeeee);
    self.tableView.tableFooterView = view;
    
    self.headPortrait = [[BFHeadPortraitView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), BF_ScaleHeight(20), BF_ScaleWidth(280), BF_ScaleHeight(200))];
    self.headPortrait.model = self.model;
    [view addSubview:self.headPortrait];
    
}

#pragma mark --tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BFLog(@"-------%lu",(unsigned long)self.itemArray.count);
    return self.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFGroupDetailProductCell *cell = [BFGroupDetailProductCell cellWithTableView:tableView];
    cell.model = self.itemArray[indexPath.row];
    cell.detailModel = self.model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(110);
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
