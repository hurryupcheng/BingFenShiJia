//
//  MyViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "LogViewController.h"
#import "Header.h"
#import "MyViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIButton *DLButton;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    
    [self initWithNagion];
    [self initWithTabView];
    [self initWithDL];
}

- (void)initWithNagion{

    self.title = @"个人信息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-htmal5icon37.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton)];
}

- (void)initWithTabView{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-200) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
}

- (void)initWithDL{

    self.DLButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.DLButton.frame = CGRectMake(kScreenWidth/2-((kScreenWidth/2)/2), CGRectGetMaxY(self.tableView.frame)+15, kScreenWidth/2, 40);
    self.DLButton.backgroundColor = [UIColor orangeColor];
    [self.DLButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.DLButton addTarget:self action:@selector(DLButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.DLButton];
}

#pragma  mark TabView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 15;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 1;
    }else if(section == 2){
        return 3;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            NSArray *arr = @[@"头像",@"推荐人",@"昵称"];
            cell.textLabel.text = arr[indexPath.row];
        }
            break;
        case 1:{
            cell.textLabel.text = @"广告主";
            break;
        }
        case 2:{
            NSArray *arr = @[@"地址管理",@"我的名片",@"绑定手机"];
            cell.textLabel.text = arr[indexPath.row];
            break;
        }
        case 3:{
            cell.textLabel.text = @"余额";
        }
        default:
            break;
    }
    return cell;

}

// 返回按钮点击方法
- (void)backButton{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark  登陆点击事件
- (void)DLButtonSelected{

    LogViewController *log = [[LogViewController alloc]init];
    [self.navigationController pushViewController:log animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{

//    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
