//
//  XQViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "CXArchiveShopManager.h"
#import "BFStorage.h"
#import "XQModel.h"
#import "ViewController.h"
#import "ShoppingViewController.h"
#import "FXQViewController.h"
#import "XQCollectionViewCell.h"
#import "Header.h"
#import "XQViewController.h"

@interface XQViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,XQViewCellDelegate>

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
@property (nonatomic,assign)NSInteger number;

@end

@implementation XQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(245, 245, 245, 1.0);

    self.sorke = 1;
    self.title = self.titles;
    
    [self initWithSegmented];
    [self getNewDateNumber:0];
}

- (void)initWithSegmented{
    
    UIView *butView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-50, 0, 44, 44)];
    UIButton *rightBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBut setImage:[UIImage imageNamed:@"ff1.png"] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(rightButton) forControlEvents:UIControlEventTouchUpInside];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rightBut.frame)-10, 0, 18, 18)];
    _numLabel.backgroundColor = [UIColor redColor];
    _numLabel.layer.cornerRadius = 9;
    _numLabel.layer.masksToBounds = YES;
   
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.font = [UIFont systemFontOfSize:13];
    _numLabel.textColor = [UIColor whiteColor];
    
    [butView addSubview:rightBut];
    [rightBut addSubview:_numLabel];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = right;
    
    NSArray *arr = @[@"新品",@"热卖",@"价格"];
    self.segmented = [[UIView alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth-10, 30)];
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

- (void)xqViewDelegate:(UICollectionViewCell *)cell index:(NSInteger)index{
    self.number++;
    self.numLabel.alpha = 1;
     _numLabel.text = [NSString stringWithFormat:@"%d",self.number];
    XQSubOtherModel *model = self.dataArray[index];
    BFStorage *storage = [[BFStorage alloc]initWithTitle:model.title img:model.img money:model.price number:1 shopId:model.ID stock:model.stock choose:model.size color:model.color];

    [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:storage];
    [[CXArchiveShopManager sharedInstance]startArchiveShop];
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XQSubOtherModel *model = self.dataArray[indexPath.row];
    FXQViewController *fxq = [[FXQViewController alloc]init];
    fxq.ID = model.ID;
    [self.navigationController pushViewController:fxq animated:YES];
    
}

#pragma  mark 数据请求
- (void)getNewDate:(NSInteger)num page:(NSInteger)page{
    NSString *url = [BF_URL stringByAppendingString:@"/index.php?m=Json&a=item_cate"];
    NSMutableDictionary *date = [NSMutableDictionary dictionary];
    date[@"id"] = self.ID;
    date[@"sort"] = @(num);
    date[@"p"] = @(page);
    [BFHttpTool POST:url params:date success:^(id responseObject) {
        [self.dataArray removeAllObjects];
        self.xqModel = [XQModel parse:responseObject];
        NSArray *array = [XQSubModel parse:self.xqModel.items];
        for (XQSubModel *xqsubModel in array) {
            NSArray *array = [XQSubOtherModel parse:xqsubModel.item];
            [self.dataArray addObjectsFromArray:array];
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        NSLog(@"%@",self.dataArray);
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"网络异常"];
    }];
}

- (void)segmented:(UIButton *)seg{
    self.selectend.selected = NO;
    seg.selected = YES;
    self.selectend = seg;
    switch (seg.tag) {
        case 0:
        {   [self getNewDateNumber:1];
        }
            break;
        case 1:{
            [self getNewDateNumber:2];
        }
            break;
        case 2:{
            
            __block CGAffineTransform temp;
            
            if (self.sorke == YES) {
                [self getNewDateNumber:4];
              [UIView animateWithDuration:0.4 delay:0 options:0 animations:^{
                  temp = CGAffineTransformMakeTranslation(0, 0);
                  self.priceimg.transform = CGAffineTransformRotate(temp, 179.001);
              } completion:^(BOOL finished) {
                  
              }];
                self.sorke = NO;
            }else{
            [self getNewDateNumber:3];
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
- (void)getNewDateNumber:(NSInteger)num{
  self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//     [self getDataids:ids number:num];
      [self getNewDate:num page:0];
  }];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.userInfo = [BFUserDefaluts getUserInfo];
    
    self.dataArr = [NSMutableArray array];
    [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
    self.dataArr = [[[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop] mutableCopy];
    
    if (self.userInfo == nil || self.dataArr == nil) {
        _numLabel.alpha = 0;
        _number = 0;
    }else{
        _numLabel.alpha = 1;
        _numLabel.text = [NSString stringWithFormat:@"%d",self.dataArr.count];
    }
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
