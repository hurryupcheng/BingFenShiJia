
//
//  BFHotSoViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/5/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define SEARCH_HISTORY [[NSUserDefaults standardUserDefaults] arrayForKey:@"BFHistory"]

#import "BFURLEncodeAndDecode.h"
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

@interface BFHotSoViewController ()<UITableViewDataSource,UITableViewDelegate,BFHotViewButDelegate,BFResultDelegate, BFShopCartAnimationDelegate>

@property (nonatomic,retain)BFUserInfo *userInfo;
@property (nonatomic,retain)BFHotView *hotView;
@property (nonatomic,retain)BFSosoModel *model;
@property (nonatomic,retain)BFSosoSubModel *subModel;
@property (nonatomic,retain)BFSosoSubOtherModel *otherModel;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIScrollView *scrollV;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic)BOOL result;
@property (nonatomic,assign)NSInteger height;
@property (nonatomic,assign)NSInteger sumNumber;

@property (nonatomic, strong) UIButton *shopCartButton;

@property (nonatomic, strong) UILabel *badgeLable;

@property (nonatomic, strong) NSMutableArray<CALayer *> *redLayers;

@end

@implementation BFHotSoViewController

- (NSMutableArray<CALayer *> *)redLayers {
    if (!_redLayers) {
        _redLayers = [NSMutableArray array];
    }
    return _redLayers;
}



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


- (void)initWithTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-108) style:UITableViewStylePlain];
    self.tableView.backgroundColor = BFColor(0xffffff);
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[BFResultTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    [self.view addSubview:_tableView];
    
    
    self.shopCartButton = [[UIButton alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), ScreenHeight-108-BF_ScaleHeight(80), BF_ScaleWidth(60), BF_ScaleHeight(60))];
    //self.shopCartButton.backgroundColor = [UIColor redColor];
    self.shopCartButton.alpha = 0.3;
    [self.shopCartButton setImage:[UIImage imageNamed:@"cart_shopping"] forState:UIControlStateNormal];
    [self.shopCartButton addTarget:self action:@selector(gotoShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shopCartButton];
    
    self.badgeLable = [[UILabel alloc]initWithFrame:CGRectMake(BF_ScaleWidth(60), ScreenHeight-108-BF_ScaleHeight(75), BF_ScaleHeight(20), BF_ScaleHeight(20))];
    self.badgeLable.backgroundColor = [UIColor redColor];
    self.badgeLable.layer.cornerRadius = BF_ScaleHeight(10);
    self.badgeLable.layer.masksToBounds = YES;
    self.badgeLable.alpha = 0;
    self.badgeLable.textAlignment = NSTextAlignmentCenter;
    self.badgeLable.font = [UIFont systemFontOfSize:13];
    self.badgeLable.textColor = [UIColor whiteColor];
    [self.view addSubview:self.badgeLable];
    
}

#pragma mark --



#pragma mark -- 去购物车
- (void)gotoShoppingCart {
    //self.shopCartButton.alpha = 1;
    self.tabBarController.selectedIndex = 1;
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

}

- (void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(evend:) name:@"BFsoso" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(evend:) name:@"BFSosoBack" object:nil];
    self.userInfo = [BFUserDefaluts getUserInfo];
    
}

- (void)evend:(NSNotification *)not{
    [self getData:(NSString *)not.object];
    [self.tableView removeFromSuperview];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return _height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc]init];
    label.text = @"  搜索结果";
    label.font = [UIFont systemFontOfSize:CGFloatX(18)];
    label.backgroundColor = BFColor(0xEDEDED);
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    BFResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
//    NSLog(@"<<<<<<<%d<<<%@",self.dataArray.count,self.dataArray);
    [cell setmodel:self.dataArray[indexPath.row]];
//    _otherModel = self.dataArray[indexPath.row];
//    NSLog(@"%d==>>>>>%@",self.dataArray.count,_otherModel.shopID);
    _height = cell.cellHeigh;
    cell.delegate = self;
    cell.buy.tag = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FXQViewController *fx = [[FXQViewController alloc]init];
    _otherModel = self.dataArray[indexPath.row];
    fx.ID = _otherModel.shopID;
    [self.navigationController pushViewController:fx animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma  mark 加入购物车代理方法
- (void)delegateWithCell:(BFResultTableViewCell *)cell index:(NSInteger)index{
    if (self.userInfo == nil) {
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录,正在跳转..."];
        LogViewController *log = [LogViewController new];
        [self.navigationController pushViewController:log animated:YES];
    }else{

        _otherModel = self.dataArray[index];
        NSLog(@"index = %@",_otherModel.shopID);
        if ([_otherModel.stock integerValue] <= 0) {
            [BFProgressHUD MBProgressOnlyWithLabelText:@"商品已经售罄"];
        }else{
            BFStorage *stor = [[CXArchiveShopManager sharedInstance]screachDataSourceWithItem:_otherModel.shopID];
            
            if (stor.numbers >= [_otherModel.stock integerValue]) {
                [BFProgressHUD MBProgressOnlyWithLabelText:@"没有更多库存"];
            }else{
                [self animationStart:cell];
                if (stor == nil) {
                    self.sumNumber++;
    
                    [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%lu",(unsigned long)self.sumNumber]];
                }
                
                BFStorage *storage = [[BFStorage alloc]initWithTitle:_otherModel.title img:_otherModel.img money:_otherModel.price number:1 shopId:_otherModel.shopID stock:_otherModel.stock choose:_otherModel.choose color:_otherModel.color];
                
                [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:storage];
                [[CXArchiveShopManager sharedInstance]startArchiveShop];
            }
        }
    }
}

//购物车动画
- (void)animationStart:(BFResultTableViewCell *)cell{
    
    //获取动画起点
    CGPoint start = [cell convertPoint:cell.buy.center toView:self.view];
    //获取动画终点
    
    CGPoint end = [self.view convertPoint:self.shopCartButton.center toView:self.view];
    
    //创建layer
    CALayer *chLayer = [[CALayer alloc] init];
    chLayer.contents = (UIImage *)cell.img.image.CGImage;
    [self.redLayers addObject:chLayer];
    chLayer.frame = CGRectMake(cell.img.centerX, cell.img.centerY, BF_ScaleHeight(50), BF_ScaleHeight(50));
    //chLayer.cornerRadius = BF_ScaleHeight(20);
    chLayer.masksToBounds = YES;
    chLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:chLayer];
    
    BFShopCartAnimation *animation = [[BFShopCartAnimation alloc]init];
    animation.delegate = self;
    [animation shopCatrAnimationWithLayer:chLayer startPoint:start endPoint:end changeX:start.x - BF_ScaleWidth(150) changeY:start.y - BF_ScaleHeight(50) endScale:0.30f  duration:1 isRotation:YES];
    
}


//动画代理动画结束移除layer
- (void)animationStop {
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (userInfo) {
        [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:nil];
        NSArray *array = [[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop];
        BFLog(@"---%lu", (unsigned long)array.count);
        UITabBarController *tabBar = [self.tabBarController viewControllers][1];
        tabBar.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        if (array.count == 0 || userInfo == nil) {
//            self.badgeLable.hidden = YES;
        }else {
//            self.numLabel.hidden = NO;
            self.badgeLable.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            
        }
        
    }else {
//        self.numLabel.hidden = YES;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.shopCartButton.alpha = 1;
        self.badgeLable.alpha = 1;
        self.shopCartButton.frame = CGRectMake(BF_ScaleWidth(10), ScreenHeight-108-BF_ScaleHeight(90), BF_ScaleWidth(80), BF_ScaleHeight(80));
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.shopCartButton.alpha = 0.3;
            self.badgeLable.alpha = 0;
            self.shopCartButton.frame = CGRectMake(BF_ScaleWidth(20), ScreenHeight-108-BF_ScaleHeight(80), BF_ScaleWidth(60), BF_ScaleHeight(60));
        }];
    }];
    
    [self.redLayers[0] removeFromSuperlayer];
    [self.redLayers removeObjectAtIndex:0];
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
            _otherModel = [[BFSosoSubOtherModel alloc]init];
            NSArray *other = [BFSosoSubOtherModel parse:dataArr];
            [self.dataArray addObjectsFromArray:other];
           
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
        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
    }];
}

- (void)write:(NSString *)str{
    NSLog(@"搜索记录===%@",str);
    /*********************************/
    NSMutableArray *searchArray = [[NSMutableArray alloc]initWithArray:SEARCH_HISTORY];
    if (searchArray == nil) {
        searchArray = [[NSMutableArray alloc]init];
    } else{
        if ([searchArray containsObject:str]) {
            [searchArray removeObject:str];
        }
    };
    [searchArray insertObject:str atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:searchArray forKey:@"BFHistory"];
    
    /********************************/
    
    //通知刷新历史纪录
    [[NSNotificationCenter defaultCenter]postNotificationName:@"newHistory" object:str];  
}

- (void)dealloc
{    NSLog(@"========通知销毁=====");
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
