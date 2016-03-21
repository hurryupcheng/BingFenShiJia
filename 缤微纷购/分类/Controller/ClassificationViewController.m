//
//  ClassificationViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
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
}

- (void)updateViewCtrl{

    [self initWithLeftView];
    [self initWithCollectionView];
}

#pragma mark 左边菜单栏
- (void)initWithLeftView{
   
    if (self.scrollV) {
        return;
    }
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, fen_x, self.view.bounds.size.height-50)];
    self.scrollV.contentSize = CGSizeMake(0, self.dataSourceArray.count*40);
    self.scrollV.showsHorizontalScrollIndicator = NO;
    self.scrollV.showsVerticalScrollIndicator = NO;
    self.scrollV.backgroundColor = rgb(211, 211, 211, 1.0);
    [self.view addSubview:self.scrollV];
    
    for (int i = 0; i < self.dataSourceArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 40*i, fen_x+1, 40);
        button.backgroundColor = rgb(211, 211, 211, 1.0);
        button.tag = i;
        button.layer.borderColor = rgb(190, 190, 190, 1.0).CGColor;
        button.layer.borderWidth = 0.5;
        if (i == 0) {
            button.selected = YES;
            self.selectedButton = button;
        }
        
        Classification * model = self.dataSourceArray[i];
        
        [button setTitle:model.name forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"12.png"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(14)];
        
        [button addTarget:self action:@selector(buttontag:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollV addSubview:button];
    }

}
#pragma  mark UICollectionView初始化
- (void)initWithCollectionView{
  
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
    [cell setClassifcationOther:_currentModel.sub_catesArr[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XQViewController *xq = [[XQViewController alloc]init];
    xq.ID = _currentModel.idArr[indexPath.row];
    xq.titles = _currentModel.nameArr[indexPath.row];
    [self.navigationController pushViewController:xq animated:YES];
}

- (void)getDate{

    NSURL *url = [NSURL URLWithString:@"http://bingo.luexue.com/index.php?m=Json&a=cate"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (data != nil) {
            NSArray * dataSourceArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    
            for (NSDictionary * dic in dataSourceArr) {
               Classification *class = [[Classification alloc]initWithDictionary:dic];
                [array addObject:class];
            }
            self.dataSourceArray = [array copy];
        }
        if (self.dataSourceArray.count) {
          self.currentModel = self.dataSourceArray[0];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViewCtrl];

        });
       
    }];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
@end
