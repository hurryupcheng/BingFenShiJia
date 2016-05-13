//
//  XQViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "LogViewController.h"
#import "CXArchiveShopManager.h"
#import "BFStorage.h"
#import "XQModel.h"
#import "ViewController.h"
#import "ShoppingViewController.h"
#import "FXQViewController.h"
#import "XQCollectionViewCell.h"
#import "Header.h"
#import "XQViewController.h"
#import "BFCategoryNavigationView.h"

@interface XQViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,XQViewCellDelegate, BFShopCartAnimationDelegate>

@property (nonatomic,retain)UICollectionView *collectionView;
@property (nonatomic,retain)UIView *segmented;
@property (nonatomic,retain)XQModel *xqModel;
@property (nonatomic,retain)XQSubModel *xqSubModel;
@property (nonatomic,retain)XQSubOtherModel *xqOtherModel;
@property (nonatomic,retain)NSMutableArray *dataArr;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)NSMutableArray *selectGoods;

@property (nonatomic)BOOL sorke;
@property (nonatomic,retain)UIButton *selectend;
@property (nonatomic,retain)UIButton *segmentBut;
@property (nonatomic,retain)UIImageView *priceimg;
@property (nonatomic,retain)BFUserInfo *userInfo;
@property (nonatomic,retain)UILabel *numLabel;//购物车数量
@property (nonatomic,assign)NSInteger sumNumber;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,assign)NSInteger sort;

@property (nonatomic, strong) UIButton *rightBut;

@property (nonatomic, strong) NSMutableArray<CALayer *> *redLayers;

@property (nonatomic, strong) BFCategoryNavigationView *navigationView;

@property (nonatomic,assign)NSInteger sumNum;//加入的数量

@property (nonatomic)BOOL isEnding;
@end

@implementation XQViewController

- (NSMutableArray<CALayer *> *)redLayers {
    if (!_redLayers) {
        _redLayers = [NSMutableArray array];
    }
    return _redLayers;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(245, 245, 245, 1.0);

    self.sorke = 1;
    self.page = 1;
    self.sort = 0;
    self.sumNum = 0;
    self.title = self.titles;
    
    [self initWithSegmented];
    [self getUpNewDate];
    [self getDownDate];
}

- (void)initWithSegmented{
    
    
    self.navigationView = [[BFCategoryNavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.navigationView.titleLabel.text = self.titles;
    [self.view addSubview:self.navigationView];
    
    
    
    UIButton *rightBut = [[UIButton alloc]initWithFrame:CGRectMake(BF_ScaleWidth(260), 22, 40, 40)];
    //rightBut.backgroundColor = [UIColor blueColor];
    self.rightBut = rightBut;
    [rightBut setImage:[UIImage imageNamed:@"ff1.png"] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(rightButton) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:rightBut];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(BF_ScaleWidth(260)+22, 23, 18, 18)];
    _numLabel.backgroundColor = [UIColor redColor];
    _numLabel.layer.cornerRadius = 9;
    _numLabel.layer.masksToBounds = YES;
    
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.font = [UIFont systemFontOfSize:13];
    _numLabel.textColor = [UIColor whiteColor];
    [self.navigationView addSubview:_numLabel];
    
    
    UIButton *back = [UIButton buttonWithType:0];
    back.frame = CGRectMake(5, 22, 35, 40);
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:back];
 
    NSArray *arr = @[@"新品",@"热卖",@"价格"];
    self.segmented = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.navigationView.frame)+5 , kScreenWidth-10, 30)];
    _segmented.layer.cornerRadius = 6;
    _segmented.layer.masksToBounds = YES;
    _segmented.layer.borderWidth = 1;
    _segmented.layer.borderColor = rgb(0, 0, 205, 1.0).CGColor;
    
    [self.view addSubview:_segmented];
    for (int i = 0; i < 3; i++) {
        self.segmentBut = [[UIButton alloc]initWithFrame:CGRectMake((_segmented.width)/3*i, 0, (_segmented.width)/3, 30)];
        
        self.segmentBut.tag = i;
        [self.segmentBut setTitle:arr[i] forState:UIControlStateNormal];
        [self.segmentBut setTitleColor:rgb(0, 0, 205, 1.0) forState:UIControlStateNormal];
        [self.segmentBut setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.segmentBut addTarget:self action:@selector(segmented:) forControlEvents:UIControlEventTouchUpInside];
        [self.segmentBut setBackgroundImage:[UIImage imageNamed:@"blues.png"] forState:UIControlStateSelected];
        self.segmentBut.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(16)];
        
        if (self.segmentBut.tag == 0) {
            self.selectend.selected = NO;
            self.segmentBut.selected = YES;
            self.selectend = self.segmentBut;
        }
        
        if (self.segmentBut.tag == 2) {
            self.segmentBut.titleEdgeInsets = UIEdgeInsetsMake(0, CGFloatX(-30), 0, 0);
        }
        
        [_segmented addSubview:self.segmentBut];
     
    }
    
    self.priceimg = [[UIImageView alloc]initWithFrame:CGRectMake((_segmented.width)/3-35, 0, 30, 30)];
    [self.segmentBut addSubview:self.priceimg];
    self.priceimg.image = [UIImage imageNamed:@"dm04.png"];

    for (int j = 1; j <= 2; j++) {
        UIView *color = [[UIView alloc]initWithFrame:CGRectMake((_segmented.width)/3*j, 0, 1, 30)];
        color.backgroundColor = rgb(0, 0, 205, 1.0);
        [_segmented addSubview:color];
    }

}



- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
    CGFloat x = (kScreenWidth-10-10-10)/2;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake(x, x+75);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmented.frame), kScreenWidth, kScreenHeight-100) collectionViewLayout:flowLayout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.multipleTouchEnabled = YES;
    self.collectionView.backgroundColor = rgb(245, 245, 245, 1.0);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerClass:[XQCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
    }
    return _collectionView;
}

#pragma  mark  CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XQCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

     cell.butDelegate = self;
     cell.shopp.tag = indexPath.row;
     [cell setXQModel:self.dataArray[indexPath.row]];
    
    return cell;
}

#pragma mark -- 返回
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark 直接添加购物车代理方法
- (void)xqViewDelegate:(XQCollectionViewCell *)cell index:(NSInteger)index{
    if (self.userInfo == nil) {
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录,正在跳转..."];
        LogViewController *log = [LogViewController new];
        [self.navigationController pushViewController:log animated:YES];
    }else{
        [self sss];
        _xqOtherModel = self.dataArray[index];
        NSLog(@"index = %@",_xqOtherModel.ID);
        if ([_xqOtherModel.stock integerValue] <= 0) {
            [BFProgressHUD MBProgressOnlyWithLabelText:@"商品已经售罄"];
        }else{
            self.sumNum++;
            BFStorage *stor = [[CXArchiveShopManager sharedInstance]screachDataSourceWithItem:_xqOtherModel.ID];
        
            if (stor.numbers >= [_xqOtherModel.stock integerValue]) {
                [BFProgressHUD MBProgressOnlyWithLabelText:@"没有更多库存"];
        }else{
            [self animationStart:cell];
            if (stor == nil) {
                self.sumNumber++;
                self.numLabel.alpha = 1;
        
                self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)self.sumNumber];
                [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%lu",(unsigned long)self.sumNumber]];
            }

            BFStorage *storage = [[BFStorage alloc]initWithTitle:_xqOtherModel.title img:_xqOtherModel.img money:_xqOtherModel.thisprice
                                                          number:1 shopId:_xqOtherModel.ID stock:_xqOtherModel.stock choose:_xqOtherModel.size color:_xqOtherModel.color];
    
            [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:storage];
            [[CXArchiveShopManager sharedInstance]startArchiveShop];
            }
        }
    }
}

- (void)sss{

    self.dataArr = [NSMutableArray array];
    [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
    self.dataArr = [[[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop] mutableCopy];
    
    if (self.userInfo == nil || self.dataArr == nil) {
        _numLabel.alpha = 0;
    }else{
        _numLabel.alpha = 1;
        _sumNumber = self.dataArr.count;
        
        _numLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.dataArr.count];
    }

}


//购物车动画
- (void)animationStart:(XQCollectionViewCell *)cell{

    //获取动画起点
    CGPoint start = [cell convertPoint:cell.shopp.center toView:self.view];
    //获取动画终点

    CGPoint end = [self.navigationView convertPoint:self.rightBut.center toView:self.view];
    
    //创建layer
    CALayer *chLayer = [[CALayer alloc] init];
    chLayer.contents = (UIImage *)cell.imageView.image.CGImage;
    [self.redLayers addObject:chLayer];
    chLayer.frame = CGRectMake(cell.imageView.centerX, cell.imageView.centerY, BF_ScaleHeight(50), BF_ScaleHeight(50));
    chLayer.cornerRadius = BF_ScaleHeight(20);
    chLayer.masksToBounds = YES;
    chLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:chLayer];
    
    
    BFShopCartAnimation *animation = [[BFShopCartAnimation alloc]init];
    animation.delegate = self;
    [animation shopCatrAnimationWithLayer:chLayer startPoint:start endPoint:end changeX:start.x-BF_ScaleWidth(50) changeY:start.y-BF_ScaleHeight(100) endScale:0.20f  duration:1 isRotation:NO];
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
        if (array.count == 0) {
            self.numLabel.hidden = YES;
        }else {
            self.numLabel.hidden = NO;
            self.numLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            
        }

    }else {
        self.numLabel.hidden = YES;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.rightBut.frame = CGRectMake(BF_ScaleWidth(250), 17, 60, 50);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.rightBut.frame = CGRectMake(BF_ScaleWidth(260), 22, 40, 40);
        }];
    }];

    [self.redLayers[0] removeFromSuperlayer];
    [self.redLayers removeObjectAtIndex:0];
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XQSubOtherModel *model = self.dataArray[indexPath.row];
    FXQViewController *fxq = [[FXQViewController alloc]init];
    fxq.ID = model.ID;
    [self.navigationController pushViewController:fxq animated:YES];
    
}

#pragma  mark 数据请求
- (void)getNewDate{
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=item_cate"];
    NSMutableDictionary *date = [NSMutableDictionary dictionary];
  
    date[@"sort"] = @(self.sort);
    date[@"p"] = @(self.page);
    if (self.allItem == YES) {
        date[@"cate_id"] = self.ID;
    }else{
        date[@"id"] = self.ID;
    }
    
    [BFHttpTool POST:url params:date success:^(id responseObject) {
        NSLog(@"%@===%@",date,responseObject);
        self.xqModel = [XQModel parse:responseObject];
        NSArray *array = [XQSubModel parse:self.xqModel.items];
        for (XQSubModel *xqsubModel in array) {
            NSArray *array = [XQSubOtherModel parse:xqsubModel.item];
            [self.dataArray addObjectsFromArray:array];
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.isEnding = NO;
        NSLog(@".>>>>>>>>%lu,,%@",(unsigned long)self.dataArray.count, responseObject);
        
    } failure:^(NSError *error) {
        self.page--;
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"网络异常 请检测网络"];
        [self.collectionView.mj_footer endRefreshingWithNoNoHTTP];
        
    }];
}

- (void)times:(UIButton *)seg{
    
    [self performSelector:@selector(segs:) withObject:seg afterDelay:0.5];
}

- (void)segs:(UIButton *)but{
    self.segmented.userInteractionEnabled = YES;
    but.userInteractionEnabled = YES;
}

- (void)segmented:(UIButton *)seg{
    self.selectend.selected = NO;
    seg.selected = YES;
    self.selectend = seg;
    self.page = 1;
    
    switch (seg.tag) {
        case 0:
        {
            self.sort = 1;
            seg.userInteractionEnabled = NO;
            self.segmented.userInteractionEnabled = NO;
            [self times:seg];
            [self getUpNewDate];
        }
            break;
        case 1:{
            self.sort = 2;
            seg.userInteractionEnabled = NO;
            self.segmented.userInteractionEnabled = NO;
            [self times:seg];
            [self getUpNewDate];
        }
            break;
        case 2:{
            
            __block CGAffineTransform temp;
            
            if (self.sorke == YES) {
                self.sort = 4;
                seg.userInteractionEnabled = NO;
                self.segmented.userInteractionEnabled = NO;
                [self times:seg];
                [self getUpNewDate];
              [UIView animateWithDuration:0.4 delay:0 options:0 animations:^{
                  temp = CGAffineTransformMakeTranslation(0, 0);
                  self.priceimg.transform = CGAffineTransformRotate(temp, 179.001);
              } completion:^(BOOL finished) {
                  
              }];
                self.sorke = NO;
            }else{
            self.sort = 3;
                seg.userInteractionEnabled = NO;
                self.segmented.userInteractionEnabled = NO;
                [self times:seg];
            [self getUpNewDate];
            [UIView animateWithDuration:0.4 delay:0 options:0 animations:^{
                temp = CGAffineTransformMakeTranslation(0, 0);
                self.priceimg.transform = CGAffineTransformRotate(temp, 0);
            } completion:^(BOOL finished) {
                
            }];
                self.sorke = YES;
            }
        }
            break;
        default:
            break;
    }
    if (seg.tag == 2) {
        self.priceimg.image = [UIImage imageNamed:@"dm03.png"];
    }else{
        self.priceimg.image = [UIImage imageNamed:@"dm04.png"];
    }
}

//  导航栏右按钮点击事件
- (void)rightButton{
    self.tabBarController.selectedIndex = 1;
    self.tabBarController.tabBar.hidden = NO;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)selectGoods{
    if (!_selectGoods) {
        _selectGoods = [NSMutableArray array];
    }
    return _selectGoods;
}

#pragma  mark 刷新数据
- (void)getUpNewDate{
    
  self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//     [self getDataids:ids number:num];
      self.page = 1;
      [self.dataArray removeAllObjects];
      [self getNewDate];
  }];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma  mark 上拉加载
- (void)getDownDate{
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
}

- (void)downRefresh{
    self.page++;
    if (self.page > [self.xqModel.page_num integerValue]) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
    [self getNewDate];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    self.userInfo = [BFUserDefaluts getUserInfo];
    self.sumNumber = 0;
    self.numLabel.alpha = 0;
    if (self.userInfo != nil) {
        [self sss];
    }
    
    self.tabBarController.tabBar.hidden = YES;
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
