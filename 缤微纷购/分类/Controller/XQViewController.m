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
@property (nonatomic,retain)UISegmentedControl *segmented;
@property (nonatomic,retain)XQModel *xqModel;
@property (nonatomic,retain)NSMutableArray *dataArr;
@property (nonatomic,retain)NSMutableArray *moneyArr;
@property (nonatomic,retain)NSMutableArray *titleArr;
@property (nonatomic,retain)NSMutableArray *imgArr;
@property (nonatomic,retain)NSMutableArray *idArr;

@property (nonatomic,assign)NSInteger number;

@end

@implementation XQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(245, 245, 245, 1.0);

    self.number = 0;
    self.title = self.titles;
    
    [self initWithSegmented];
    [self getDataids:self.ID number:0];
}

- (void)initWithSegmented{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-htmal5icon37.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_02.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButton)];
    
    NSArray *arr = @[@"新品",@"热卖",@"价格"];
    self.segmented = [[UISegmentedControl alloc]initWithItems:arr];
    self.segmented.frame = CGRectMake(5, 5, kScreenWidth-10, 30);
    self.segmented.tintColor = rgb(0, 0, 205, 1.0);
    self.segmented.selectedSegmentIndex = 0;
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:CGFloatY(16)], NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.segmented.tintColor = [UIColor blueColor];
    [self.segmented setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:CGFloatY(16)],NSForegroundColorAttributeName: [UIColor blueColor]};
    [self.segmented setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [self.segmented addTarget:self action:@selector(segmented:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.segmented];

}

- (void)initWithCollectionView{
    
    CGFloat x = (kScreenWidth-10-10-10)/2;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake(x, x+75);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmented.frame), kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
    
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
    
    return self.xqModel.dateArr.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XQCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   
    [cell setXQModel:self.xqModel.dateArr[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FXQViewController *fxq = [[FXQViewController alloc]init];
    fxq.ID = self.idArr[indexPath.row];
    [self.navigationController pushViewController:fxq animated:YES];
    
}

#pragma  mark 请求数据
- (void)getDataids:(NSString *)ids number:(NSInteger )number{
  NSString *string = [NSString stringWithFormat:@"?m=Json&a=item_cate&id=%@&sorte=%ld",ids,(long)number];
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
            
            NSArray *array = [dic valueForKey:@"title"];
            for (NSDictionary *dis in array) {
                NSMutableArray *arr = [NSMutableArray array];
                for (NSDictionary *dics in dis[@"item"]) {
                  self.xqModel = [[XQModel alloc]init];
                  self.xqModel.ID = dics[@"id"];
                  self.xqModel.img = dics[@"img"];
                  self.xqModel.title = dics[@"title"];
                  self.xqModel.price = dics[@"price"];
            
                [arr addObject:self.xqModel];
                [self.moneyArr addObject:self.xqModel.price];
                [self.titleArr addObject:self.xqModel.title];
                [self.imgArr addObject:self.xqModel.img];
                [self.idArr addObject:self.xqModel.ID];
                }
                self.xqModel.dateArr = [arr copy];
                
            }
         
        }
        [self initWithCollectionView];
        
    }];
    
}

- (void)segmented:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
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
            [self getDataids:self.ID number:4];
        }
            break;
        default:
            break;
    }

}

//  导航栏左按钮点击事件
- (void)leftButton{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//  导航栏右按钮点击事件
- (void)rightButton{
    self.tabBarController.selectedIndex = 1;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
