//
//  BFZFViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BForder.h"
#import "Header.h"
#import "BFZFViewController.h"

@interface BFZFViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)UITableView *tableV;
@end

@implementation BFZFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableView];
}

- (void)initWithTableView{

    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    
    self.tableV.rowHeight = 40;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    
    [self.view addSubview:self.tableV];
}

#pragma  mark 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if(section == 2){
        return 5;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 100;
    }else if(section == 2){
        return 300;
    }else{
        return 0;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imageV = [[UIImageView alloc]init];
    if (section == 0) {
        imageV.frame = CGRectMake(0, 0, kScreenWidth, 100);
        UIImageView *groubeImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, imageV.frame.size.height-10)];
        groubeImg.image = [UIImage imageNamed:@"1"];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, imageV.frame.size.height/4)];
        name.text = @"测试";
        
        UILabel *num = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(name.frame), kScreenWidth, imageV.frame.size.height/4)];
        num.text = @"11111111";
        
        UILabel *adds = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(num.frame), kScreenWidth/2, imageV.frame.size.height/2)];
        adds.text = self.titles;
        adds.numberOfLines = 2;
        
        [imageV addSubview:groubeImg];
        [imageV addSubview:name];
        [imageV addSubview:num];
        [imageV addSubview:adds];
      
    }else if(section == 2){
        imageV.frame = CGRectMake(0, 0, kScreenWidth, 300);
        UIImageView *groubeImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
        
        for (int i = 0; i < 3; i++) {
            BForder *order = [[BForder alloc]initWithFrame:CGRectMake(0,((kScreenWidth/4+10)*i)+(i*5), kScreenWidth, kScreenWidth/4+10) img:@"1" title:self.titles money:@"22" guige:@"33" number:@"22"];
            order.backgroundColor = [UIColor whiteColor];
            [imageV addSubview:order];
        }
        
        [imageV addSubview:groubeImg];
    }
    
    return imageV;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }

    switch (indexPath.section) {
        case 0:{
        cell.textLabel.text = @"配送方式";
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-100, 0, 60, 40)];
//            label.text = @"请选择";
//            [cell addSubview:label];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 1:{
            NSArray *arr = @[@"支付方式",@"积分抵扣"];
            cell.textLabel.text = arr[indexPath.row];
            
            if (indexPath.row != 1) {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-100, 0, 60, 40)];
                label.text = @"请选择";
                [cell addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
            break;
        case 2:{
            NSArray *array = @[@"商品总价",@"运费",@"积分抵扣",@"优惠卷抵扣",@"其他抵扣"];
            cell.textLabel.text = array[indexPath.row];
        }
            break;
        case 3:{
            cell.textLabel.text = @"发票";
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
