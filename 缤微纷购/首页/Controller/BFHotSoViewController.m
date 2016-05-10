
//
//  BFHotSoViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/5/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "LogViewController.h"
#import "FXQViewController.h"
#import "PrefixHeader.pch"
#import "BFHttpTool.h"
#import "Header.h"
#import "ViewController.h"
#import "BFHotView.h"
#import "BFSosoModel.h"
#import "BFResultTableViewCell.h"
#import "BFHotSoViewController.h"

@interface BFHotSoViewController ()<UITableViewDataSource,UITableViewDelegate,BFHotViewButDelegate,BFResultDelegate>

@property (nonatomic,retain)BFUserInfo *userInfo;
@property (nonatomic,retain)BFHotView *hotView;
@property (nonatomic,retain)BFSosoModel *model;
@property (nonatomic,retain)BFSosoSubModel *subModel;
@property (nonatomic,retain)BFSosoSubOtherModel *otherModel;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIScrollView *scrollV;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)NSMutableArray *otherModelArr;
@property (nonatomic)BOOL result;
@property (nonatomic,assign)NSInteger height;
@property (nonatomic,retain)NSUserDefaults *userDefas;
@property (nonatomic,retain)NSMutableArray *usesArr;

@end

@implementation BFHotSoViewController

- (BFHotView *)hotView{
    if (!_hotView) {
        _hotView = [[BFHotView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) model:_subModel other:_model];
        _hotView.delegate = self;
        [self.scrollV addSubview:_hotView];
    }
    return _hotView;
}
#pragma mark 热门搜索点击代理方法
- (void)selectedBut:(NSString *)text{
    
    [self getData:[text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (void)selectedButton:(NSInteger)index{
    FXQViewController *fx = [[FXQViewController alloc]init];
    fx.ID = _model.IDArr[index];
    [self.navigationController pushViewController:fx animated:YES];
}

- (UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
      
        _scrollV.contentSize = CGSizeMake(0, _hotView.cellHeight+110);
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_scrollV];
        
    }
    return _scrollV;
}

//- (UITableView *)tableView{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-108)];
//        
//        self.tableView.showsHorizontalScrollIndicator = NO;
//        self.tableView.showsVerticalScrollIndicator = NO;
//        self.tableView.delegate = self;
//        self.tableView.dataSource = self;
//        self.tableView.tableFooterView = [UIView new];
//        
//        [self.tableView registerClass:[BFResultTableViewCell class] forCellReuseIdentifier:@"reuse"];
//        [self.view addSubview:_tableView];
//    }
//    return _tableView;
//}

- (void)initWithTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-108)];
//    NSLog(@"3333333333333");
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[BFResultTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    [self.view addSubview:_tableView];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.result = YES;
    [self getData:nil];

    _userDefas = [NSUserDefaults standardUserDefaults];
    _usesArr = [_userDefas valueForKey:@"BFHistory"];
    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
//    tap1.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:tap1];
}
//#pragma  mark 回收键盘
//-(void)viewTapped:(UITapGestureRecognizer*)tap1
//{
//    [self.view endEditing:YES];
//    
//}

- (void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(evend:) name:@"BFsoso" object:nil];
    self.userInfo = [BFUserDefaluts getUserInfo];
    
}

- (void)evend:(NSNotification *)not{
    [self getData:(NSString *)not.object];
    [self.tableView removeFromSuperview];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"////////////%d",self.dataArray.count);
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return _height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    BFResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
//    NSLog(@"<<<<<<<%d<<<%@",self.dataArray.count,self.dataArray);
    [cell setmodel:self.dataArray[indexPath.row]];
    _height = cell.cellHeigh;
    cell.delegate = self;
    cell.buy.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FXQViewController *fx = [[FXQViewController alloc]init];
    _otherModel = self.dataArray[indexPath.row];
    fx.ID = _otherModel.shopID;
    [self.navigationController pushViewController:fx animated:YES];
}

#pragma  mark 加入购物车代理方法
- (void)resultDelegate:(NSInteger)index{
    if (self.userInfo == nil) {
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录,正在跳转..."];
        LogViewController *log = [LogViewController new];
        [self.navigationController pushViewController:log animated:YES];
    }else{
        _otherModel = self.dataArray[index];
         NSLog(@"%@  index = %@",_otherModel.shopID,self.dataArray[index]);
        if ([_otherModel.stock integerValue] <= 0) {
            [BFProgressHUD MBProgressOnlyWithLabelText:@"商品已经售罄"];
        }else{
            NSLog(@"id = %@",_otherModel.shopID);
            
            BFStorage *stor = [[CXArchiveShopManager sharedInstance]screachDataSourceWithItem:_otherModel.shopID];
            
            if (stor.numbers >= [_otherModel.stock integerValue]) {
                [BFProgressHUD MBProgressOnlyWithLabelText:@"没有更多库存"];
            }else{
//                if (stor == nil) {
//                    [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%lu",(unsigned long)self.sumNumber]];
//                }
                [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
                self.dataArray = [[[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop] mutableCopy];
                
                BFStorage *storage = [[BFStorage alloc]initWithTitle:_otherModel.title img:_otherModel.img money:_otherModel.price number:1 shopId:_otherModel.shopID stock:_otherModel.stock choose:_otherModel.choose color:_otherModel.color];
            
                [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:storage];
                [[CXArchiveShopManager sharedInstance]startArchiveShop];
                
            }
        }
    }
}


- (void)getData:(NSString *)data{

    if (data.length) {
       [self write:data];
    }
    NSString *url = [NET_URL stringByAppendingString:[NSString stringWithFormat:@"/index.php?m=Json&a=search&name=%@",data]];

    [BFHttpTool GET:url params:nil success:^(id responseObject) {
//                NSLog(@"responseObject=====%@",responseObject);
        _model = [[BFSosoModel alloc]init];
        _subModel = [[BFSosoSubModel alloc]init];
        
        NSMutableArray *dataArr = responseObject[@"search_item"];
        NSMutableArray *arr = responseObject[@"hot_item"];
        NSMutableArray *array = responseObject[@"like_item"];
        _subModel.titleArr = arr;
        for (NSDictionary *dic in array) {
            [_model.IDArr addObject:dic[@"id"]];
            [_model.imgArr addObject:dic[@"img"]];
        }
 
        if (![dataArr isKindOfClass:[NSNull class]]) {
            [self.dataArray removeAllObjects];
            NSArray *other = [BFSosoSubOtherModel parse:dataArr];
            [self.dataArray addObjectsFromArray:other];
            self.otherModelArr = [NSMutableArray array];
           
            for (NSDictionary *dic2 in dataArr) {
                [_otherModel.shopIDarray addObject:dic2[@"id"]];
            }
            
            [self initWithTableView];
            [self.tableView reloadData];
        }else{
            if (self.result) {
                [self hotView];
                [self scrollV];
                self.result = NO;
            }else{
            [BFProgressHUD MBProgressFromView:self.view wrongLabelText:@"没有相关搜索结果"];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)write:(NSString *)str{

    NSLog(@">>>>>>>>>>>%@",[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
 
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"BFHistory"];
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT addObject:str];
    if(searTXT.count > 5)
    {
        [searTXT removeObjectAtIndex:0];
    }
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searTXT forKey:@"BFHistory"];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
