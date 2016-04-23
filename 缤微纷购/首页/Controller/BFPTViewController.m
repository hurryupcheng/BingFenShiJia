//
//  BFPTViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Height.h"
#import "UIImageView+WebCache.h"

#import "PTModel.h"
#import "BFPTDetailViewController.h"
#import "LBView.h"
#import "Header.h"
#import "ViewController.h"
#import "PTTableViewCell.h"
#import "BFPTViewController.h"

@interface BFPTViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *tableV;
@property (nonatomic,assign)NSInteger cellHeight;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)NSMutableArray *ptLBView;
@property (nonatomic,retain)PTModel *pt;


@end

@implementation BFPTViewController

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setDownDate];
}

- (UITableView *)tableV{
    if (!_tableV) {
        self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, -30, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        
        self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableV.showsHorizontalScrollIndicator = NO;
        self.tableV.showsVerticalScrollIndicator = NO;
        self.tableV.backgroundColor = BFColor(0xD4D4D4);
        self.tableV.delegate = self;
        self.tableV.dataSource = self;
//        self.tableV.backgroundColor = [UIColor greenColor];
        [self.tableV registerClass:[PTTableViewCell class] forCellReuseIdentifier:@"reuse"];
        //        [self setDownDate];
//        CGRect rect = _tableV.frame;
//        rect.size.height += 10;
//        _tableV.frame = rect;
        
        [self.view addSubview:self.tableV];
        
    }
    return _tableV;
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
//    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.ptLBView == nil) {
        return 0;
    }else{
        return kScreenWidth/2;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor redColor];
    LBView *lb = [[LBView alloc]init];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *str in self.ptLBView) {
        [arr addObject:str];
    }
    lb.isServiceLoadingImage = YES;
    lb.dataArray = [arr copy];
    
    [view addSubview:lb];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == self.dataArray.count) {
//        return self.cellHeight+15*self.dataArray.count;
//    }else {
        return self.cellHeight+15;
//    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFPTDetailViewController *ptxq = [[BFPTDetailViewController alloc]init];
    self.pt = self.dataArray[indexPath.row];
    ptxq.ID = self.pt.ID;
    ptxq.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ptxq animated:NO];
}

#pragma  mark 拼团解析
- (void)tableViewgetDate{
    
    //    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //    parameters[@"m"] = @"Json";
    //    parameters[@"a"] = @"team_buy";
    //
    //    [BFHttpTool GET:BF_URL params:parameters success:^(id responseObject) {
    //        NSArray *array = [BFDataTool getPTArrayWithDic:responseObject];
    //        [self.dataArray addObjectsFromArray:array];
    //        [self initWithTabView];
    //        [self.tableV reloadData];
    //
    //    } failure:^(NSError *error) {
    //
    //    }];
    
    
    NSURL *url = [NSURL URLWithString:@"http://bingo.luexue.com/index.php?m=Json&a=team_buy"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (data != nil) {
            [self.dataArray removeAllObjects];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *array = [dic valueForKey:@"ads"];
            NSArray *arr = [dic valueForKey:@"item"];
            self.ptLBView = [NSMutableArray array];
            
            if (![dic[@"ads"] isKindOfClass:[NSNull class]]) {
                for (NSDictionary *dices in array) {
                    _pt = [[PTModel alloc]init];
                    _pt.content = [dices valueForKey:@"content"];
                    [self.ptLBView addObject:_pt.content];
                }
            }else {
                self.ptLBView = nil;
            }
            
            for (NSDictionary *dics in arr) {
                _pt = [[PTModel alloc]init];
                _pt.ID = [dics valueForKey:@"id"];
                _pt.img = [dics valueForKey:@"img"];
                _pt.title = [dics valueForKey:@"title"];
                _pt.intro = [dics valueForKey:@"intro"];
                _pt.team_num = [dics valueForKey:@"team_num"];
                _pt.team_price = [dics valueForKey:@"team_price"];
                _pt.team_discount = [dics valueForKey:@"team_discount"];
                
                [self.dataArray addObject:_pt];
                
            }
            
        }
        [self.tableV reloadData];
        [self.tableV.mj_header endRefreshing];
    }];
    
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setDownDate{
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self tableViewgetDate];
    }];
    [self.tableV.mj_header beginRefreshing];
}


@end
