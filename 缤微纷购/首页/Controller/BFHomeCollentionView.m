//
//  BFHomeCollentionView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFPTDetailViewController.h"
#import "PTXQViewController.h"
#import "Height.h"
#import "FXQViewController.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "HomeModel.h"
#import "XCCollectionViewCell.h"
#import "XQViewController.h"
#import "LBView.h"
#import "Header.h"
#import "ViewController.h"
#import "HeaderCollectionReusableView.h"
#import "FooterCollectionReusableView.h"
#import "BFHomeCollentionView.h"

@interface BFHomeCollentionView ()<UICollectionViewDataSource,UICollectionViewDelegate,LBViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain)UICollectionView *collentionView;
@property (nonatomic,retain)UIView *butView;
@property (nonatomic,retain)UIButton *selectButton;

@property (nonatomic,retain)HeaderCollectionReusableView *headerView;
@property (nonatomic,retain)FooterCollectionReusableView *footerView;
@property (nonatomic,retain)LBView *lbView;
@property (nonatomic,retain)UITableView *tableV;
@property (nonatomic,retain)UIScrollView *scrollV;
@property (nonatomic,retain)UIView *viewBut;

@property (nonatomic,retain)HomeSubModel *homeSubModel;
@property (nonatomic,retain)HomeModel *homeModel;
@property (nonatomic,retain)HomeOtherModel *homeOtherModel;
@property (nonatomic,retain)UIButton *button;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)NSArray *titleArr;

@property (nonatomic,retain)UIButton *footImageView;
@property (nonatomic,retain)UIButton *upImageView;
@property (nonatomic,retain)UIView *upBackView;

@end

@implementation BFHomeCollentionView

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getDownDate];
}

- (void)otherView{
    [self initWithScrollView];
    [self initWithBut];
    [self initWithUpView];
}

#pragma  mark 缤纷商城初始化
- (void)initWithScrollView{

#warning 契合度最高的话 最好时修改 LBView   直接传model进去
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
    if (_homeModel.bannerDataArray.count != 0) {
        for (HomeOtherModel * model in _homeModel.bannerDataArray) {
            [arr addObject:model.content];
        }
    }else{
        return;
    }
    
    self.lbView = [[LBView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
    self.lbView.isServiceLoadingImage = YES;
    self.lbView.dataArray = [arr copy];
    self.lbView.delegateLB = self;
    
    
}
#pragma mark 分类列表初始化
- (void)initWithBut{
    self.titleArr = @[@"果实",@"地方特产",@"休闲零食",@"酒水",@"今日特价",@"新品首发",@"热销排行",@"试吃体验"];
    self.viewBut = [[UIView alloc]init];
    self.viewBut.backgroundColor = [UIColor whiteColor];
    
    if (self.titleArr.count <= 4) {
        self.viewBut.frame = CGRectMake(0, CGRectGetMaxY(self.lbView.frame), kScreenWidth, (but_x)+20);
    }else{
        self.viewBut.frame = CGRectMake(0, CGRectGetMaxY(self.lbView.frame), kScreenWidth, ((but_x)*2)+20);
    }
    
    for (int i = 0; i < 8; i++) {
        //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *backView = [[UIView alloc]init];
        backView.frame = CGRectMake((i%4+1)*5+(i%4)* (but_x),(i/4+1)*5+(i/4)*(but_x), but_x, but_x);
        
        //        button.tag = 10 + i;
        //        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, image_x-5, image_x-5)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"iicon0%d.png",i+1]];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), but_x, 20)];
        label.text = [NSString stringWithFormat:@"%@",self.titleArr[i]];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:CGFloatY(14)];
        
        [backView addSubview:image];
        [backView addSubview:label];
//        [self.headerView addSubview:self.viewBut];
        [self.viewBut addSubview:backView];
    }
}

#pragma  mark UICollectionView初始化
- (UICollectionView *)collentionView{
    if (!_collentionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 5;
        
        flowLayout.itemSize = CGSizeMake(item_x, item_x);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        self.collentionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
        
        self.collentionView.backgroundColor = [UIColor whiteColor];
        self.collentionView.dataSource = self;
        self.collentionView.delegate = self;
        self.collentionView.showsHorizontalScrollIndicator = NO;
        self.collentionView.showsVerticalScrollIndicator = NO;
        self.collentionView.multipleTouchEnabled = YES;
        
        [self.collentionView registerClass:[XCCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self.collentionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        [self.collentionView registerClass:[FooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        
        self.collentionView.allowsMultipleSelection = YES;
        
        [self.view addSubview:self.collentionView];
    }
    return _collentionView;
}

#pragma  mark 首页下方广告图
- (void)initWithOtherView{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.homeModel.footDataArray.count; i++) {
        self.footImageView = [[UIButton alloc]initWithFrame:CGRectMake(0, ((kScreenWidth/2)*i+(i*5)), kScreenWidth, kScreenWidth/2)];
        self.footImageView.tag = i;
        for (HomeOtherModel *home in self.homeModel.footDataArray) {
            [arr addObject:home.content];
        }
        [self.footImageView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",arr[i]]] placeholderImage:[UIImage imageNamed:@"750,jpg"]];
        
        [self.footImageView addTarget:self action:@selector(footImageView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerView addSubview:self.footImageView];
    }
}

#pragma  mark 上方广告图
- (void)initWithUpView{
    
    NSInteger count = self.homeModel.oneDataArray.count;
    
    self.upBackView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.viewBut.frame), kScreenWidth, kScreenWidth/2*count)];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < count; i++) {
        self.upImageView = [[UIButton alloc]initWithFrame:CGRectMake(0,((kScreenWidth/2)*i), kScreenWidth, kScreenWidth/2)];
        self.upImageView.tag = i;
        for (HomeOtherModel *home in self.homeModel.oneDataArray) {
            [arr addObject:home.content];
        }
        
        [self.upImageView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",arr[i]]] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
        [self.upImageView addTarget:self action:@selector(upImageView:) forControlEvents:UIControlEventTouchUpInside];
        
//        [self.headerView addSubview:self.upBackView];
        [self.upBackView addSubview:self.upImageView];
    }
    
}
- (void)footImageView:(UIButton *)but{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *IDArr = [NSMutableArray arrayWithCapacity:0];
    for (HomeOtherModel *model in self.homeModel.footDataArray) {
        [arr addObject:model.id_type];
        [IDArr addObject:model.url];
    }
    [self setIndex:but.tag arr:arr IDArr:IDArr];
}

- (void)upImageView:(UIButton *)but{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *IDArr = [NSMutableArray arrayWithCapacity:0];
    for (HomeOtherModel *model in self.homeModel.oneDataArray) {
        [arr addObject:model.id_type];
        [IDArr addObject:model.url];
    }
    
    [self setIndex:but.tag arr:arr IDArr:IDArr];
}
#pragma  mark  轮播点击方法
- (void)LBViewDelegate:(LBView *)lbView didSelected:(NSInteger)index{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *IDArr = [NSMutableArray arrayWithCapacity:0];
    for (HomeOtherModel *model in self.homeModel.bannerDataArray) {
        [arr addObject:model.id_type];
        [IDArr addObject:model.url];
    }
    [self setIndex:index arr:arr IDArr:IDArr];
}

- (void)setIndex:(NSInteger)index arr:(NSMutableArray *)arr IDArr:(NSMutableArray *)IDArr{
    
    if ([arr[index] isEqualToString:@"1"]) {
        FXQViewController  *fx = [[FXQViewController alloc]init];
        fx.ID = IDArr[index];
        [self.navigationController pushViewController:fx animated:YES];
    }else if ([arr[index] isEqualToString:@"2"]){
        BFPTDetailViewController *pt = [[BFPTDetailViewController alloc]init];
        pt.ID = IDArr[index];
        [self.navigationController pushViewController:pt animated:YES];
    }else if ([arr[index] isEqualToString:@"3"]){
        XQViewController *xq = [[XQViewController alloc]init];
        xq.ID = IDArr[index];
        [self.navigationController pushViewController:xq animated:YES];
    }else{
        return;
    }
}

#pragma  mark 分类列表点击事件
- (void)selectButton:(UIButton *)button{
    switch (button.tag) {
        case 10:{
            NSLog(@"首页分类点击有效");
        }
            break;
        case 11:{
            
        }
            break;
        case 12:{
            
        }
            break;
        case 13:{
            
        }
            break;
        case 14:{
            
        }
            break;
        case 15:{
            
        }
            break;
        case 16:{
            
        }
            break;
        case 17:{
            
        }
            break;
        case 18:{
            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma  mark  CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    HomeSubModel *model = self.homeModel.homeDataArray[section];
    return model.imageArray.count;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.homeModel.homeDataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    for (UIView *view in cell.contentView.subviews) {
//        if (view) {
//            [view removeFromSuperview];
//        }
//    }
    HomeSubModel *model = self.homeModel.homeDataArray[indexPath.section];
    
    [cell.imageView sd_setImageWithURL:[model.imageArray objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FXQViewController *fxq = [[FXQViewController alloc]init];
    HomeSubModel *model = self.homeModel.homeDataArray[indexPath.section];
    fxq.ID = model.idArray[indexPath.row];
    [self.navigationController pushViewController:fxq animated:YES];
    
    
}

#pragma  mark  分区头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
 
    if (section == 0) {
        if (self.titleArr.count <= 4) {
            return CGSizeMake(kScreenWidth, kScreenWidth+(kScreenWidth/2*(self.homeModel.oneDataArray.count))+(but_x)+20);
        }else{
            return CGSizeMake(kScreenWidth, kScreenWidth+(kScreenWidth/2*(self.homeModel.oneDataArray.count))+(but_x)*2+20);
        }
    }else{
        return CGSizeMake(kScreenWidth, kScreenWidth/2);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    NSInteger index = self.homeModel.homeDataArray.count;
    NSInteger number = self.homeModel.footDataArray.count;
    if (section == index-1) {
        
        return CGSizeMake(kScreenWidth, (kScreenWidth/2)*number+120);
    }else{
        return CGSizeMake(0, 0);
    }
}

#pragma  mark 分区头视图

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        HomeSubModel *homeModel = self.homeModel.homeDataArray[indexPath.section];
        
        [self.headerView.sectionImage setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:homeModel.upimg] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
        [self.headerView.sectionImage addTarget:self action:@selector(sectionImage:) forControlEvents:UIControlEventTouchUpInside];
        self.headerView.sectionImage.tag = indexPath.section;
        
        if (indexPath.section != 0) {
            
            self.viewBut.alpha = 0;
            self.lbView.alpha = 0;
            self.upBackView.alpha = 0;
            self.headerView.sectionImage.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/2);
        }else{
            [self.headerView addSubview:self.lbView];
            [self.headerView addSubview:self.viewBut];
            [self.headerView addSubview:self.upBackView];
            
            self.headerView.sectionImage.frame = CGRectMake(0, CGRectGetMaxY(self.upBackView.frame), kScreenWidth, kScreenWidth/2);
 
            }
        return self.headerView;
        
    }else{
        NSInteger index = self.homeModel.homeDataArray.count;
        if (indexPath.section == index-1) {
            
            self.footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
            
            [self initWithOtherView];
        }
        
        return self.footerView;
    }
    
}

#pragma  mark 分区头点击事件
- (void)sectionImage:(UIButton *)but{
    HomeSubModel *homeModel = self.homeModel.homeDataArray[but.tag];
    XQViewController *xq = [[XQViewController alloc]init];
    xq.ID = homeModel.upurl;
    [self.navigationController pushViewController:xq animated:YES];
}

#pragma  mark 获取数据
- (void)CollectionViewgetDate{
    
    NSURL *url = [NSURL URLWithString:@"http://bingo.luexue.com/index.php?m=Json&a=index"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (data != nil) {
            [self.dataArray removeAllObjects];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            HomeModel * homeModel = [[HomeModel alloc]initWithDictionary:dic];
            self.homeModel = homeModel;
            
        }else{
            [BFProgressHUD MBProgressFromWindowWithLabelText:@"当前网络异常"];
        }
        [self otherView];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collentionView reloadData];
            [self.collentionView.mj_header endRefreshing];
        });
        
    }];
    
}

- (void)getDownDate{
    
    self.collentionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self CollectionViewgetDate];
    }];
    [self.collentionView.mj_header beginRefreshing];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
