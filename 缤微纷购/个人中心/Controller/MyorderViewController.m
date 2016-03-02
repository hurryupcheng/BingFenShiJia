//
//  MyorderViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "MyorderTableViewCell.h"
#import "MyorderViewController.h"

@interface MyorderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain)UITableView *tableV;
@property (nonatomic,retain)UISegmentedControl *segmented;

@end

@implementation MyorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titles;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithSegmented];
    [self initWithTableView];
}

- (void)initWithSegmented{
 
    NSArray *arr = @[@"未付款",@"已付款",@"我的售后"];
    self.segmented = [[UISegmentedControl alloc]initWithItems:arr];
    
    self.segmented.frame = CGRectMake(5, 10, kScreenWidth-10, 30);
    [self.segmented setTintColor:[UIColor orangeColor]];
    self.segmented.selectedSegmentIndex = 0;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],UITextAttributeTextColor, nil];
    [self.segmented setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    [self.view addSubview:self.segmented];
}

- (void)initWithTableView{

    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.segmented.frame)+10, kScreenWidth, kScreenHeight)];
    
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 150;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableV registerClass:[MyorderTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    [self.view addSubview:self.tableV];
}

#pragma  mark 表视图代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    MyorderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
@end
