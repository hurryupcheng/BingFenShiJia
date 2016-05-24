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
        self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-74) style:UITableViewStyleGrouped];
        
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
    //获取数据
    [self getData];
    //下拉刷新
    [self setDownDate];
    
}

- (void)getData{

    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=team_buy"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        if (responseObject) {
            BFLog(@"--%@", responseObject);
            self.model = [BFPTHomeModel parse:responseObject];
            self.headerView.model = self.model;
            self.headerView.height = self.headerView.headViewH;
            self.tableV.tableHeaderView = self.headerView;
            
            if ([responseObject[@"item"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFPTItemList parse:self.model.item];
                for (BFPTItemList *itemList in array) {
                    itemList.nowtime = self.model.nowtime;
                }
                [self.dataArray addObjectsFromArray:array];
            }
            [self.tableV reloadData];
        }
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressOnlyWithLabelText:@"网络问题"];
        BFLog(@"%@", error);
    }];
    
    
}



#pragma mark -- 下拉刷新
- (void)setDownDate{
    
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self tableViewgetDate];
    }];
  //[self.tableV.mj_header beginRefreshing];
}

#pragma  mark 拼团解析
- (void)tableViewgetDate{
    
    
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=team_buy"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        if (responseObject) {
            BFLog(@"--%@", responseObject);
            self.model = [BFPTHomeModel parse:responseObject];
            self.headerView.model = self.model;
            self.headerView.height = self.headerView.headViewH;
            self.tableV.tableHeaderView = self.headerView;
            
            if ([responseObject[@"item"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFPTItemList parse:self.model.item];
                for (BFPTItemList *itemList in array) {
                    itemList.nowtime = self.model.nowtime;
                }
                [BFSoundEffect playSoundEffect:@"paopao.wav"];
                [self showNewStatusCount:array.count - self.dataArray.count];
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:array];
            }
            [self.tableV reloadData];
            [self.tableV.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressOnlyWithLabelText:@"网络问题"];
        [self.tableV.mj_header endRefreshing];
        BFLog(@"%@", error);
    }];
    
    
}

#pragma mark -- 刷新看是否有数据更新
- (void)showNewStatusCount:(NSUInteger)count
{
    // 1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = label.backgroundColor = BFColor(0xFD8B2F);
    label.width = ScreenWidth;
    label.height = 35;
    // 2.设置其他属性
    if (count == 0) {
        label.text = @"亲,没有更多新的商品哦!";
    } else {
        label.text = [NSString stringWithFormat:@"共有%zd件新的团购商品", count];
    }
    label.textColor = BFColor(0xffffff);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    
    // 3.添加
    label.y = -label.height;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.view insertSubview:label aboveSubview:self.tableV];
    
    // 4.动画
    // 先利用1s的时间，让label往下移动一段距离
    CGFloat duration = 1.0; // 动画的时间
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        CGFloat delay = 1.0; // 延迟1s
        // UIViewAnimationOptionCurveLinear:匀速
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
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
    //ptxq.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ptxq animated:NO];
}







@end
