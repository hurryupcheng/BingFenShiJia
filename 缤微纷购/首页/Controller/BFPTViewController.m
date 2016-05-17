//
//  BFPTViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Height.h"
#import "UIImageView+WebCache.h"
#import "AFNTool.h"
#import "BFPTDetailViewController.h"
#import "LBView.h"
#import "Header.h"
#import "ViewController.h"
#import "PTTableViewCell.h"
#import "BFPTViewController.h"
#import "BFPTHomeModel.h"
#import "BFPTHomeHeaderView.h"

@interface BFPTViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITableView *tableV;
/**返回高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/**产品数组*/
@property (nonatomic,retain) NSMutableArray *dataArray;
/**轮播图数组*/
@property (nonatomic,retain) NSArray *bannerArray;
/**缤纷拼团模型*/
@property (nonatomic, strong) BFPTHomeModel *model;
/**轮播图*/
@property (nonatomic, strong) BFPTHomeHeaderView *headerView;
@end

@implementation BFPTViewController


#pragma mark -- 懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSArray *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [NSArray array];
    }
    return _bannerArray;
}

- (BFPTHomeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFPTHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    }
    return _headerView;
}

- (UITableView *)tableV{
    if (!_tableV) {
        self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
        
        self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableV.showsHorizontalScrollIndicator = NO;
        self.tableV.showsVerticalScrollIndicator = NO;
        self.tableV.backgroundColor = BFColor(0xD4D4D4);
        self.tableV.delegate = self;
        self.tableV.dataSource = self;
        //        self.tableV.backgroundColor = [UIColor greenColor];
        [self.tableV registerClass:[PTTableViewCell class] forCellReuseIdentifier:@"reuse"];
        
        [self.view addSubview:self.tableV];
        
    }
    return _tableV;
}


#pragma  mark --viewDidLoad
- (void)viewDidLoad{
    self.title = @"缤纷拼团";
    self.view.backgroundColor = [UIColor whiteColor];
    //下拉刷新
    [self setDownDate];
    
}




#pragma mark -- 下拉刷新
- (void)setDownDate{
    
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self tableViewgetDate];
    }];
    [self.tableV.mj_header beginRefreshing];
}

#pragma  mark 拼团解析
- (void)tableViewgetDate{
    
    
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=team_buy"];
    [BFHttpTool GET:url params:nil success:^(id responseObject) {
        if (responseObject) {
            BFLog(@"--%@", responseObject);
            [self.dataArray removeAllObjects];
            self.model = [BFPTHomeModel parse:responseObject];
            self.headerView.model = self.model;
            self.headerView.height = self.headerView.headViewH;
            self.tableV.tableHeaderView = self.headerView;
            
            BFLog(@"===========%f,,,,%f", self.headerView.headViewH, self.headerView.height);
            
            if ([responseObject[@"item"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFPTItemList parse:self.model.item];
                for (BFPTItemList *itemList in array) {
                    itemList.nowtime = self.model.nowtime;
                }
                [self.dataArray addObjectsFromArray:array];
            }
            [self.tableV reloadData];
            [self.tableV.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressOnlyWithLabelText:@"网络问题"];
        BFLog(@"%@", error);
    }];
    
    
}





#pragma  mark UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    self.cellHeight = cell.cellHeight;
    cell.backgroundColor = BFColor(0xD4D4D4);
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    return self.cellHeight+20;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFPTDetailViewController *ptxq = [[BFPTDetailViewController alloc]init];
    BFPTItemList *list = self.dataArray[indexPath.row];
    ptxq.ID = list.ID;
    ptxq.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ptxq animated:NO];
}







@end
