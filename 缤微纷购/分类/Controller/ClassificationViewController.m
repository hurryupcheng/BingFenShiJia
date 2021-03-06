//
//  ClassificationViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "AFNTool.h"
#import "BFSosoViewController.h"
#import "Classification.h"
#import "ViewController.h"
#import "XQViewController.h"
#import "ClassCollectionViewCell.h"
#import "Header.h"
#import "ClassificationViewController.h"

@interface ClassificationViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,retain)UICollectionView *collectionView;

@property (nonatomic,strong) NSArray * dataSourceArray;
@property (nonatomic,retain)Classification *currentModel; //当前的model；
@property (nonatomic,retain)ClassificationSubModel *classSubModel;

@property (nonatomic,retain)UIScrollView *scrollV;
@property (nonatomic,retain)UIButton *selectedButton;
@property (nonatomic,assign)NSInteger itemNumber;


@end

@implementation ClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分类";
    [self getDate];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(SOSO)];
    
    
}

- (void)SOSO{
    BFSosoViewController *soso = [[BFSosoViewController alloc]init];

    [self.navigationController pushViewController:soso animated:YES];
}

#pragma mark 左边菜单栏
- (void)initWithLeftView{
    
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, fen_x, self.view.bounds.size.height)];
    self.scrollV.contentSize = CGSizeMake(0, self.dataSourceArray.count*40);
    self.scrollV.showsHorizontalScrollIndicator = NO;
    self.scrollV.showsVerticalScrollIndicator = NO;
    self.scrollV.backgroundColor = BFColor(0xF2F4F5);
    [self.view addSubview:self.scrollV];
    
    for (int i = 0; i < self.dataSourceArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 40*i, fen_x+1, 40);
        button.backgroundColor = BFColor(0xF2F4F5);
        button.tag = i;
        button.layer.borderColor = BFColor(0xD1D3D4).CGColor;
        button.layer.borderWidth = 0.25;
        if (i == 0) {
            button.selected = YES;
            self.selectedButton = button;
        }
        
        Classification * model = self.dataSourceArray[i];
        
        [button setTitle:model.name forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"12.png"] forState:UIControlStateSelected];
        [button setTitleColor:BFColor(0x000000) forState:UIControlStateNormal];
        [button setTitleColor:BFColor(0x0977ca) forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(14)];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(buttontag:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollV addSubview:button];
    }

}
#pragma  mark UICollectionView初始化
- (void)initWithCollectionView{
  
    [self initWithLeftView];
    CGFloat x = ((kScreenWidth-fen_x)-5-5-5-5)/3;
   
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.itemSize = CGSizeMake(x, x+30);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
   _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.scrollV.frame), 0, kScreenWidth-(fen_x), kScreenHeight) collectionViewLayout:flowLayout];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.multipleTouchEnabled = YES;
    
    [self.collectionView registerClass:[ClassCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
   
}

- (void)buttontag:(UIButton *)butt{
    
    self.selectedButton.selected = NO;
    butt.selected = YES;
    self.selectedButton = butt;
    
    self.currentModel = [self.dataSourceArray objectAtIndex:butt.tag];
    [self.collectionView reloadData];
}

#pragma  mark  collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _currentModel.sub_catesArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == _currentModel.sub_catesArr.count-1) {
    [cell setClassifcationOther:_currentModel.sub_catesArr[indexPath.row] index:1];
    }else{
    [cell setClassifcationOther:_currentModel.sub_catesArr[indexPath.row] index:0];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    XQViewController *xq = [[XQViewController alloc]init];
    if (indexPath.row == _currentModel.sub_catesArr.count-1) {
        xq.titles = _currentModel.name;
        xq.ID = _currentModel.ID;
        xq.allItem = YES;
    }else{
    xq.allItem = NO;
    xq.ID = _currentModel.idArr[indexPath.row];
    xq.titles = _currentModel.nameArr[indexPath.row];
    }
    BFLog(@"----%@",xq.ID);
    [self.navigationController pushViewController:xq animated:YES];
}

- (void)getDate{

    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=cate"];
    [AFNTool postJSONWithUrl:url parameters:nil success:^(id responseObject) {
        NSLog(@"=====%@",responseObject);
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    
        for (NSDictionary * dic in responseObject) {
            Classification *class = [[Classification alloc]initWithDictionary:dic];
            if (class.sub_catesArr.count != 0) {
                [array addObject:class];
            }
        }

        self.dataSourceArray = [array copy];
        
        if (self.dataSourceArray.count) {
            self.currentModel = self.dataSourceArray[0];
        }
        [self initWithLeftView];
        [self initWithCollectionView];
        [self.collectionView reloadData];
        
    } fail:^{
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
@end
