//
//  ShoppingViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "SPTableViewCell.h"
#import "Header.h"
#import "ShoppingViewController.h"

@interface ShoppingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)SPTableViewCell *sp;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)UITableView *tabView;
@property (nonatomic,retain)UIButton *rightBut;
@property (nonatomic,assign)NSInteger number;
@property (nonatomic,retain)UIView *otherView;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(220, 220, 220, 1.0);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_01.png"] style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    
    [self initView];
}

- (void)initView{
    [self initWithHeader];
    [self initWithTabView];
    [self initWithOther];
}

- (void)initWithTabView{

    self.title = @"购物车";
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageV.frame), kScreenWidth, kScreenHeight-205-self.otherView.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+162);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    
    self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    self.tabView.dataSource = self;
    self.tabView.delegate = self;
    self.tabView.showsHorizontalScrollIndicator = NO;
    self.tabView.showsVerticalScrollIndicator = NO;
    self.tabView.rowHeight = 100;
    
    [self.tabView registerClass:[SPTableViewCell class] forCellReuseIdentifier:@"shangpin"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-160, kScreenWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = rgb(220, 220, 220, 1.0).CGColor;
    view.layer.borderWidth = 1;
    
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    money.text = @"  合计:¥ 999.00";
    money.textColor = [UIColor orangeColor];
    
    UIButton *sum = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view.frame)-130, 10, 100, 30)];
    sum.backgroundColor = [UIColor orangeColor];
    [sum setTitle:@"马上结算" forState:UIControlStateNormal];
    sum.layer.cornerRadius = 12;
    sum.layer.masksToBounds = YES;
    [sum addTarget:self action:@selector(jiesuan) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view];
    [view addSubview:money];
    [view addSubview:sum];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.tabView];
}

- (void)initWithOther{

    self.otherView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tabView.frame)+10, kScreenWidth, kScreenWidth/4+50)];
    self.otherView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, kScreenWidth/3-20, 1)];
    lab.backgroundColor = [UIColor grayColor];
    
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 0, kScreenWidth/3, 30)];
    labe.text = @"你可能还要买";
    labe.textAlignment = NSTextAlignmentCenter;
    labe.textColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labe.frame)+5, 15, kScreenWidth/3-20, 1)];
    label.backgroundColor = [UIColor grayColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(labe.frame)+10, kScreenWidth-60, kScreenWidth/4)];
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((i*(kScreenWidth/4)+(i*10)), 0, kScreenWidth/4, kScreenWidth/4)];
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 3;
        button.tag = i;
        
        [view addSubview:button];
    }
    
    [self.scrollView addSubview:self.otherView];
    [self.otherView addSubview:view];
    [self.otherView addSubview:lab];
    [self.otherView addSubview:labe];
    [self.otherView addSubview:label];

}

- (void)initWithHeader{

    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    self.imageV.backgroundColor = rgb(220, 220, 220, 1.0);
    self.imageV.userInteractionEnabled = YES;
    
    CGFloat x = self.imageV.frame.size.height;
    
    self.rightBut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, x-22, x-22)];
    self.rightBut.layer.cornerRadius = (x-22)/2;
    self.rightBut.layer.masksToBounds = YES;
    [self.rightBut setBackgroundImage:[UIImage imageNamed:@"0"] forState:UIControlStateNormal];
    [self.rightBut setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateSelected];
    [self.rightBut addTarget:self action:@selector(selectedbut) forControlEvents:UIControlEventTouchUpInside];
    self.number = 1;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.rightBut.frame), 0, x, x)];
    label.text = @"全选";
    label.textAlignment = NSTextAlignmentCenter;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-((kScreenWidth/3)/2), 0, kScreenWidth/3, x)];
    title.text = @"商品信息";
    title.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.imageV];
    [self.imageV addSubview:self.rightBut];
    [self.imageV addSubview:label];
    [self.imageV addSubview:title];

}

#pragma  mark tabView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
//    SPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shangpin" forIndexPath:indexPath];
    
    SPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[SPTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    return cell;
}

- (void)selectedbut{
    self.number++;
    if (self.number%2 == 0) {
        self.rightBut.selected = YES;
        self.sp.needV.selected = YES;
    }else{
        self.rightBut.selected = NO;
        self.sp.needV.selected = NO;
    }
}

- (void)jiesuan{


}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
