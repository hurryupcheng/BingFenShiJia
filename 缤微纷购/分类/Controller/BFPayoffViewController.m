//
//  BFPayoffViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.

#import "BFPayoffHeader.h"
#import "BFFootViews.h"
#import "Header.h"
#import "ViewController.h"
#import "BFPayoffViewController.h"

@interface BFPayoffViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *tableV;
@property (nonatomic,retain)BFPayoffHeader *header;//头视图
@property (nonatomic,assign)NSInteger height;

@end

@implementation BFPayoffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self initWithTableView];
    [self initWithFoot];
    
    NSLog(@"%@",self.header.number.text);
}

#pragma  mark 初始化底部视图
- (void)initWithFoot{
    BFFootViews *foot = [[BFFootViews alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-50, kScreenWidth, 50) money:nil home:@"返回首页" name:@"立即支付"];
    
    [foot.homeButton addTarget:self action:@selector(goToHome) forControlEvents:UIControlEventTouchUpInside];
    
    foot.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:foot];
}

- (void)goToHome{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma  mark 初始化表视图
- (void)initWithTableView{
    
    self.header = [[BFPayoffHeader alloc]init];
    self.height = self.header.height;
    
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50) style:UITableViewStyleGrouped];
    
    self.tableV.backgroundColor = rgb(255, 228, 225, 1.0);
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
  
    [self.view addSubview:self.tableV];
}

#pragma  mark 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.height;
    }else if(section == 2){
        return 70;
    }else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        self.header.backgroundColor = [UIColor whiteColor];
        return self.header;
    }else if(section == 2){
        UIView *groub = [[UIView alloc]init];
        groub.backgroundColor = [UIColor whiteColor];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-(kScreenWidth/4), 10, kScreenWidth/2, CGFloatY(25))];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-(kScreenWidth/4), CGRectGetMaxY(name.frame)+5, kScreenWidth/2, CGFloatY(25))];
        
        name.text = @"请您于30分钟内完成支付";
        name.font = [UIFont systemFontOfSize:CGFloatY(16)];
        name.textColor = [UIColor orangeColor];
        name.textAlignment = NSTextAlignmentCenter;
        
        title.text = @"否则订单将被取消";
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:CGFloatY(16)];
        title.textColor = [UIColor orangeColor];
        
        [groub addSubview:name];
        [groub addSubview:title];
        return groub;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *resue = @"resue";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resue];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:resue];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:CGFloatX(17)];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:CGFloatX(17)];
    
    NSArray *arr = @[@"配送时间",@"支付方式"];
    NSArray *array = @[@"2016-01-16发货(工作日配送)",self.pay];
    
    if (indexPath.section == 1) {
        cell.textLabel.text = arr[indexPath.row];
        cell.detailTextLabel.text = array[indexPath.row];
    }
    
    return cell;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
