//
//  BFHomeCollentionView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "AFNTool.h"
#import "BFHomeModel.h"
#import "BFPTViewController.h"
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
#import "BFHomeFunctionView.h"
#import "BFDailySpecialController.h"
#import "BFBestSellingController.h"
#import "BFPanicBuyingController.h"
#import "BFTastingExperienceController.h"
#import "BFHomeWebViewController.h"

@interface BFHomeCollentionView ()<UICollectionViewDataSource,UICollectionViewDelegate,LBViewDelegate,UICollectionViewDelegateFlowLayout, BFHomeFunctionViewDelegate>

@property (nonatomic,retain)UICollectionView *collentionView;
@property (nonatomic,retain)UIView *butView;
@property (nonatomic,retain)UIButton *selectButton;

@property (nonatomic,retain)HeaderCollectionReusableView *headerView;
@property (nonatomic,retain)FooterCollectionReusableView *footerView;
@property (nonatomic,retain)LBView *lbView;
@property (nonatomic,retain)UIScrollView *scrollV;
@property (nonatomic,retain)UIView *viewBut;

@property (nonatomic,retain)HomeSubModel *homeSubModel;
@property (nonatomic,retain)HomeModel *homeModel;
@property (nonatomic,retain)HomeOtherModel *homeOtherModel;
@property (nonatomic,retain)UIButton *button;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)NSArray *titleArr;
@property (nonatomic,assign)NSInteger headerSection;

@property (nonatomic,retain)UIButton *footImageView;
@property (nonatomic,retain)UIButton *upImageView;
@property (nonatomic,retain)UIView *upBackView;

/***/
@property (nonatomic, strong) BFHomeFunctionView *functionView;
/**首页模型类*/
@property (nonatomic, strong) BFHomeModel *model;
//返回顶部按钮
@property (nonatomic, strong) UIButton *TopButton;
//偏移量
@property (nonatomic, assign) CGFloat contentOffSetY;
@end

@implementation BFHomeCollentionView

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    [self getDownDate];
    [self CollectionViewgetDate];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = rgb(69, 130, 242, 1.0);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
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
  
    self.lbView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/2);
    _lbView.pageC.frame = CGRectMake(kScreenWidth/2-10, CGRectGetHeight(self.lbView.frame)-30, 20, 20);
    self.lbView.isServiceLoadingImage = YES;
    self.lbView.dataArray = [arr copy];
    self.lbView.delegateLB = self;

    if (!_functionView) {
    
    _functionView = [[BFHomeFunctionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lbView.frame), ScreenWidth, BF_ScaleHeight(170)) model:self.model];
    _functionView.delegate = self;
//        _functionView.backgroundColor = [UIColor greenColor];
    }
    
}
#pragma mark 分类列表初始化
//- (void)initWithBut{

//    self.functionView = [[BFHomeFunctionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lbView.frame), ScreenWidth, BF_ScaleHeight(160))];
//    self.functionView.backgroundColor = [UIColor blueColor];
//    [self.headerView addSubview:self.functionView];
    
//    self.viewBut.backgroundColor = [UIColor whiteColor];
//    self.viewBut.frame = CGRectMake(0,  CGRectGetMaxY(self.lbView.frame), ScreenWidth, BF_ScaleHeight(160));
//    [self.headerView addSubview:self.viewBut];

    
    
    
    
//    if (self.titleArr.count <= 4) {
//        self.viewBut.frame = CGRectMake(0, CGRectGetMaxY(self.lbView.frame), kScreenWidth, (but_x)+20);
//    }else{
//        self.viewBut.frame = CGRectMake(0, CGRectGetMaxY(self.lbView.frame), kScreenWidth, ((but_x)*2)+20);
//    }
    
//    for (int i = 0; i < 8; i++) {
//        //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIView *backView = [[UIView alloc]init];
//        backView.frame = CGRectMake((i%4+1)*5+(i%4)* (but_x),(i/4+1)*5+(i/4)*(but_x), but_x, but_x);
//        
//        //        button.tag = 10 + i;
//        //        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, image_x-5, image_x-5)];
//        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"iicon0%d.png",i+1]];
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), but_x, 20)];
//        label.text = [NSString stringWithFormat:@"%@",self.titleArr[i]];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor blackColor];
//        label.font = [UIFont systemFontOfSize:CGFloatY(14)];
//        
//        [backView addSubview:image];
//        [backView addSubview:label];
//        [self.viewBut addSubview:backView];
//    }
    
//}
#pragma  mark --BFHomeFunctionViewDelegate
- (void)clickToGotoDifferentViewWithType:(BFHomeFunctionViewButtonType)type list:(BFHomeFunctionButtonList *)list{
    BFLog(@"%d",type);
    if ([list.typeId isEqualToString:@"1"]) {
        FXQViewController  *fx = [[FXQViewController alloc]init];
        fx.ID = list.cid;
        [self.navigationController pushViewController:fx animated:YES];

    }else if ([list.typeId isEqualToString:@"2"]){
        BFPTDetailViewController *pt = [[BFPTDetailViewController alloc]init];
        pt.ID = list.cid;
        [self.navigationController pushViewController:pt animated:YES];
    }else if ([list.typeId isEqualToString:@"3"]){
        XQViewController *xq = [[XQViewController alloc]init];
        xq.titles = list.title;
        xq.ID = list.cid;
        xq.allItem = YES;
        BFLog(@"BFHomeCollentionView---%@",xq.ID);
        [self.navigationController pushViewController:xq animated:YES];
    }


    
    
    
//    switch (type) {
//        case BFHomeFunctionViewButtonTypeFruitEating:{
//            BFLog(@"点击了果食");
//            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"活动暂未开启,敬请期待"];
//            break;
//        }
//        case BFHomeFunctionViewButtonTypeLocalSpeciality:{
//            BFLog(@"点击了地方特产");
//            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"活动暂未开启,敬请期待"];
//            break;
//        }
//        case BFHomeFunctionViewButtonTypeCasualSnacks:{
//            BFLog(@"点击了休闲零食");
//            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"活动暂未开启,敬请期待"];
//            break;
//        }
//        case BFHomeFunctionViewButtonTypeWineDrinking:{
//            BFLog(@"点击了酒水");
//            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"活动暂未开启,敬请期待"];
//            break;
//        }
//        case BFHomeFunctionViewButtonTypeDailySpecial:{
//            BFLog(@"点击了今日特价");
//            BFDailySpecialController *dailySpecialVC = [[BFDailySpecialController alloc] init];
//            [self.navigationController pushViewController:dailySpecialVC animated:YES];
//            break;
//        }
//        case BFHomeFunctionViewButtonTypeFirstPublish:{
//            BFLog(@"点击了新品首发");
//            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"活动暂未开启,敬请期待"];
//            break;
//        }
//        case BFHomeFunctionViewButtonTypeBestSelling:{
//            BFLog(@"点击了热销排行");
//            BFBestSellingController *bestSellingVC = [[BFBestSellingController alloc] init];
//            [self.navigationController pushViewController:bestSellingVC animated:YES];
//            break;
//        }
//        case BFHomeFunctionViewButtonTypeTastingExperience:{
//            BFLog(@"点击了试吃体验");
//            BFTastingExperienceController *tastingExperienceVC = [[BFTastingExperienceController alloc] init];
//            [self.navigationController pushViewController:tastingExperienceVC animated:YES];
//            break;
//        }
//    }
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
        [self.footImageView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",arr[i]]] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
        
        [self.footImageView addTarget:self action:@selector(footImageView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerView addSubview:self.footImageView];
    }
}


#pragma  mark 上方广告图
- (void)initWithUpView{
   
    NSInteger count = self.homeModel.oneDataArray.count;
    
    self.upBackView.frame = CGRectMake(0, CGRectGetMaxY(self.functionView.frame), kScreenWidth, kScreenWidth/2*count);
    
//    [self.headerView addSubview:self.upBackView];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < count; i++) {
        
        self.upImageView = [[UIButton alloc]initWithFrame:CGRectMake(0,((kScreenWidth/2)*i), kScreenWidth, kScreenWidth/2)];
        self.upImageView.tag = i;
        for (HomeOtherModel *home in self.homeModel.oneDataArray) {
            [arr addObject:home.content];
        }
        
        [self.upImageView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",arr[i]]] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
        [self.upImageView addTarget:self action:@selector(upImageView:) forControlEvents:UIControlEventTouchUpInside];

        [self.upBackView addSubview:self.upImageView];
    }
}
- (void)footImageView:(UIButton *)but{
//    if (but.tag == self.homeModel.footDataArray.count-1) {
//        self.tabBarController.selectedIndex = 3;
//    }else{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *IDArr = [NSMutableArray arrayWithCapacity:0];
    for (HomeOtherModel *model in self.homeModel.footDataArray) {
        [arr addObject:model.id_type];
        [IDArr addObject:model.url];
    }
    [self setIndex:but.tag arr:arr IDArr:IDArr];
//    }
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
        
//        BFPanicBuyingController *panicBuyingVC = [[BFPanicBuyingController alloc] init];
//        panicBuyingVC.ID = IDArr[index];
//        [self.navigationController pushViewController:panicBuyingVC animated:YES];
    }else if ([arr[index] isEqualToString:@"2"]){
        BFPTDetailViewController *pt = [[BFPTDetailViewController alloc]init];
        pt.ID = IDArr[index];
        [self.navigationController pushViewController:pt animated:YES];
    }else if ([arr[index] isEqualToString:@"3"]){
        XQViewController *xq = [[XQViewController alloc]init];
        xq.ID = IDArr[index];
        [self.navigationController pushViewController:xq animated:YES];
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
//        if (self.titleArr.count <= 4) {
//            return CGSizeMake(kScreenWidth, kScreenWidth+(kScreenWidth/2*(self.homeModel.oneDataArray.count))+(but_x)+10);
//        }else{
//            return CGSizeMake(kScreenWidth, kScreenWidth+(kScreenWidth/2*(self.homeModel.oneDataArray.count))+(but_x)*2+10);
//        }
    return CGSizeMake(kScreenWidth, kScreenWidth+(kScreenWidth/2*(self.homeModel.oneDataArray.count))+BF_ScaleHeight(170));
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
        
        self.headerSection = indexPath.row;
        
        if (indexPath.section == 0) {
            
            [self.headerView addSubview:_lbView];
            [self.headerView addSubview:_functionView];
            [self.headerView addSubview:self.upBackView];
        
            self.headerView.sectionImage.frame = CGRectMake(0, CGRectGetMaxY(self.upBackView.frame), kScreenWidth, kScreenWidth/2);
        }else{
            [self.functionView removeFromSuperview];
            [self.lbView removeFromSuperview];
            [self.upBackView removeFromSuperview];
            self.headerView.sectionImage.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/2);
            
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
    
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=index"];
    
    [BFHttpTool GET:url params:nil success:^(id responseObject) {
        BFLog(@"%@", responseObject);
        if (responseObject) {
            [self.dataArray removeAllObjects];
            //BFLog(@"%@",responseObject);
            HomeModel * homeModel = [[HomeModel alloc]initWithDictionary:responseObject];
            self.model = [BFHomeModel parse:responseObject];
//            self.functionView.model = self.model;
            self.homeModel = homeModel;
            
            [self initWithScrollView];
            if (!_upImageView) {
                [self initWithUpView];
            }
            if (!_functionView.btn) {
                [self initWithScrollView];
            }
            
            [self.collentionView.mj_header endRefreshing];
            [self.collentionView reloadData];
        }
    } failure:^(NSError *error) {
        [self.collentionView.mj_header endRefreshing];
//        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
        BFLog(@"%@", error);
    }];
    
    
//    NSURL *url = [NSURL URLWithString:[NET_URL stringByAppendingString:@"/index.php?m=Json&a=index"]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        
//        if (data != nil) {
//            [self.dataArray removeAllObjects];
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            BFLog(@"%@",dic);
//            HomeModel * homeModel = [[HomeModel alloc]initWithDictionary:dic];
//            self.homeModel = homeModel;
//            
//        }else{
////            [BFProgressHUD MBProgressFromWindowWithLabelText:@"当前网络异常"];
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.collentionView reloadData];
//            [self.collentionView.mj_header endRefreshing];
//        });
//        
//    }];
    
}




- (void)getDownDate{
    
    self.collentionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self CollectionViewgetDate];
    }];
    //[self.collentionView.mj_header beginRefreshing];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (LBView *)lbView{
    if (!_lbView) {
      
        _lbView = [[LBView alloc]init];
        
    }
    return _lbView;
}

- (UIView *)upBackView{
    if (!_upBackView) {
        _upBackView = [[UIView alloc]init];
    }
    return _upBackView;
}

#pragma mark -- 添加返回顶部的按钮
- (UIButton *)TopButton{
    if (!_TopButton) {
        _TopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _TopButton.frame = CGRectMake(ScreenWidth - BF_ScaleWidth(60),ScreenHeight-BF_ScaleHeight(190), BF_ScaleWidth(50), BF_ScaleWidth(50));
        _TopButton.layer.cornerRadius = BF_ScaleWidth(25);
        _TopButton.layer.masksToBounds = YES;
        _TopButton.backgroundColor = BFColor(0x1dc3ff);
        [_TopButton setTitle:@"TOP" forState:UIControlStateNormal];
        [self.TopButton addTarget:self action:@selector(TopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TopButton;
}
- (void)TopButtonAction:(UIButton *)sender{
    
    //self.collentionView.contentOffset = CGPointMake(0, 0);
    [self.collentionView setContentOffset:CGPointMake(0,0) animated:YES];
    [self.TopButton removeFromSuperview];
}
//开始拖动scrollV
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _contentOffSetY = scrollView.contentOffset.y;
}

//只要偏移量发生改变就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currcontentOffSetY = scrollView.contentOffset.y;
    if (_contentOffSetY > currcontentOffSetY && currcontentOffSetY > 0) {
        [self.view addSubview:self.TopButton];
        //        [self.view bringSubviewToFront:self.TopButton];
    }else{
        [self.TopButton removeFromSuperview];
    }
}

@end
