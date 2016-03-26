//
//  XQViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "XQModel.h"
#import "ViewController.h"
#import "ShoppingViewController.h"
#import "FXQViewController.h"
#import "XQCollectionViewCell.h"
#import "Header.h"
#import "XQViewController.h"

@interface XQViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain)UICollectionView *collectionView;
@property (nonatomic,retain)UIView *segmented;
@property (nonatomic,retain)XQModel *xqModel;
@property (nonatomic,retain)NSMutableArray *dataArr;
@property (nonatomic,retain)NSMutableArray *moneyArr;
@property (nonatomic,retain)NSMutableArray *titleArr;
@property (nonatomic,retain)NSMutableArray *imgArr;
@property (nonatomic,retain)NSMutableArray *idArr;
@property (nonatomic,retain)NSMutableArray *dataArray;

@property (nonatomic)BOOL sorke;
@property (nonatomic,retain)UIButton *selectend;
@property (nonatomic,retain)UIButton *segmentBut;
@property (nonatomic,retain)UIImageView *priceimg;

@end

@implementation XQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(245, 245, 245, 1.0);

    self.sorke = 1;
    self.title = self.titles;
    
    [self initWithSegmented];
    [self getDataids:self.ID number:0];
}

- (void)initWithSegmented{
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-htmal5icon37.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_02.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButton)];
    
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
//    self.segmented = [[UISegmentedControl alloc]initWithItems:arr];
//    self.segmented.frame = CGRectMake(5, 5, kScreenWidth-10, 30);
//    self.segmented.tintColor = rgb(0, 0, 205, 1.0);
//    self.segmented.selectedSegmentIndex = 0;
//    
//    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:CGFloatY(16)], NSForegroundColorAttributeName: [UIColor whiteColor]};
//    self.segmented.tintColor = [UIColor blueColor];
//    [self.segmented setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
//    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:CGFloatY(16)],NSForegroundColorAttributeName: [UIColor blueColor]};
//    [self.segmented setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
//    [self.segmented addTarget:self action:@selector(segmented:) forControlEvents:UIControlEventValueChanged];

}

- (void)initWithCollectionView{
    
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

#pragma  mark  CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XQCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   
    [cell setXQModel:self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FXQViewController *fxq = [[FXQViewController alloc]init];
    fxq.ID = self.idArr[indexPath.row];
    [self.navigationController pushViewController:fxq animated:YES];
    
}

#pragma  mark 请求数据
- (void)getDataids:(NSString *)ids number:(NSInteger )number{
  NSString *string = [NSString stringWithFormat:@"?m=Json&a=item_cate&id=%@&sort=%ld",ids,(long)number];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,string]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:5];
//    [request setHTTPMethod:@"post"];
//    NSString *string = [NSString stringWithFormat:@"?m=Json&a=item_cate&id=%@&sorte=%d",self.ID,self.number];
//    request.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (data != nil) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.moneyArr = [NSMutableArray array];
            self.titleArr = [NSMutableArray array];
            self.imgArr = [NSMutableArray array];
            self.idArr = [NSMutableArray array];
            self.dataArray = [NSMutableArray array];
            
            [self.dataArray removeAllObjects];
          
            NSArray *array = [dic valueForKey:@"title"];
            for (NSDictionary *dis in array) {

                for (NSDictionary *dics in dis[@"item"]) {
                  self.xqModel = [[XQModel alloc]init];
                  self.xqModel.ID = dics[@"id"];
                  self.xqModel.img = dics[@"img"];
                  self.xqModel.title = dics[@"title"];
                  self.xqModel.price = dics[@"price"];

                [self.moneyArr addObject:self.xqModel.price];
                [self.titleArr addObject:self.xqModel.title];
                [self.imgArr addObject:self.xqModel.img];
                [self.idArr addObject:self.xqModel.ID];
                    
                [self.dataArray addObject:self.xqModel];
                }
            }
         
        }
        [self initWithCollectionView];
        [self.collectionView reloadData];
        
    }];
    
}

- (void)segmented:(UIButton *)seg{
    self.selectend.selected = NO;
    seg.selected = YES;
    self.selectend = seg;
    switch (seg.tag) {
        case 0:
        {
            [self getDataids:self.ID number:1];
        }
            break;
        case 1:{

            [self getDataids:self.ID number:2];
        }
            break;
        case 2:{
            
            __block CGAffineTransform temp;
            
            if (self.sorke == YES) {
              [self getDataids:self.ID number:4];
              [UIView animateWithDuration:0.4 delay:0 options:0 animations:^{
                  temp = CGAffineTransformMakeTranslation(0, 0);
                  self.priceimg.transform = CGAffineTransformRotate(temp, 179.001);
              } completion:^(BOOL finished) {
                  
              }];
                self.sorke = NO;
            }else{
            [self getDataids:self.ID number:3];
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

//  导航栏左按钮点击事件
//- (void)leftButton{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}
//  导航栏右按钮点击事件
- (void)rightButton{
    self.tabBarController.selectedIndex = 1;
    self.tabBarController.tabBar.hidden = NO;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
