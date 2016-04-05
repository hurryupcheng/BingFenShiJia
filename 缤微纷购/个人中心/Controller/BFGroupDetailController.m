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
            NSArray *array = [TeamList parse:self.model.thisteam];
            [self.teamArray addObjectsFromArray:array];
            //给头部视图模型赋值
            self.headerView.model = self.model;
            //给底部视图模型赋值
            self.footerView.model = self.model;
            //返回的高度赋值
            [UIView animateWithDuration:0.5 animations:^{
                self.headerView.height = self.headerView.headerViewH;
                self.tableView.tableHeaderView = self.headerView;
                self.tableView.tableFooterView = self.footerView;
            }];
            
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
        self.tabbar.y = ScreenHeight - 64 - BF_ScaleHeight(70);
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
