//
//  BFZFViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFAddressController.h"
#import "BFPaymentViewController.h"
#import "BFPayoffViewController.h"
#import "BFFootViews.h"
#import "ViewController.h"
#import "BForder.h"
#import "Header.h"
#import "BFZFViewController.h"

@interface BFZFViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)UITableView *tableV;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UIImageView *groubeImg;
@property (nonatomic,retain)UILabel *name;
@property (nonatomic,retain)UILabel *photo;
@property (nonatomic,retain)UILabel *adds;
@property (nonatomic,retain)UIImageView *img;
@property (nonatomic,retain)BFFootViews *footView;

@end

@implementation BFZFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"确认支付";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self initWithFootView];
    [self initWithTableView];
    [self addsView];
    
}

- (void)initWithFootView{
    self.footView = [[BFFootViews alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-114, kScreenWidth, 50) money:@"合计:¥ 0.00" home:nil name:@"提交订单"];
    self.footView.backgroundColor = [UIColor whiteColor];
    [self.footView.buyButton addTarget:self action:@selector(payoff) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.footView];
}

//  跳转支付
- (void)payoff{
    BFPayoffViewController *pay = [[BFPayoffViewController alloc]init];
    
    [self.navigationController pushViewController:pay animated:YES];
}


- (void)addsView{

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_01.png"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoHomeController)];
    
    self.groubeImg = [[UIImageView alloc]init];
    self.groubeImg.image = [UIImage imageNamed:@"adds.png"];
    self.groubeImg.backgroundColor = [UIColor whiteColor];
    
    self.name = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, kScreenWidth, CGFloatY(30))];
    _name.text = @"测试";
    self.name.font = [UIFont systemFontOfSize:CGFloatX(17)];
//    self.name.backgroundColor = [UIColor grayColor];
    
    self.photo = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_name.frame), kScreenWidth, CGFloatY(30))];
    _photo.text = @"11111111";
    _photo.font = [UIFont systemFontOfSize:CGFloatX(17)];
//    _photo.backgroundColor = [UIColor greenColor];
    
    self.adds = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_photo.frame), kScreenWidth-50, CGFloatY(50))];
    _adds.text = self.titles;
    _adds.numberOfLines = 2;
    _adds.font = [UIFont systemFontOfSize:CGFloatX(17)];
//    _adds.backgroundColor = [UIColor redColor];
    
    self.groubeImg.frame = CGRectMake(0, 15, kScreenWidth, CGRectGetMaxY(_adds.frame));
//    self.groubeImg.backgroundColor = [UIColor orangeColor];
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-30, self.groubeImg.height/2, 15, 15)];
    _img.image = [UIImage imageNamed:@"jianjiao.png"];
    
}

- (void)gotoHomeController{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)initWithTableView{

    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.footView.height-64) style:UITableViewStyleGrouped];
    
//    self.tableV.rowHeight = 40;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.showsHorizontalScrollIndicator = NO;
    self.tableV.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableV];
}

#pragma  mark 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 4;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.groubeImg.height+30;
    }else if(section == 1){
        return kScreenWidth/4+20*self.count;
    }else{
        return 7;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.imageV = [[UIImageView alloc]init];
    self.imageV.userInteractionEnabled = YES;
    if (section == 0) {
        [_imageV addSubview:self.groubeImg];
        [_imageV addSubview:_name];
        [_imageV addSubview:_photo];
        [_imageV addSubview:_adds];
        [_imageV addSubview:_img];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerDid)];
        [_imageV addGestureRecognizer:tap];
        
    }else if(section == 1){
        
        for (int i = 0; i < self.count; i++) {
            BForder *order = [[BForder alloc]initWithFrame:CGRectMake(0,((kScreenWidth/4+10)*i)+(i*5), kScreenWidth, kScreenWidth/4+10) img:@"1" title:self.titles money:@"22" guige:@"33" number:@"22"];
            order.backgroundColor = [UIColor whiteColor];
            
            [_imageV addSubview:order];
        }
     
    }
    
    return _imageV;
}

- (void)headerDid{
    NSLog(@"地址点击");
    BFAddressController *addVC = [BFAddressController new];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuse];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:CGFloatX(17)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0){
        switch (indexPath.row) {
            case 0:{
                cell.textLabel.text = @"支付方式*";
                UILabel *rigt = [[UILabel alloc]initWithFrame:CGRectMake(CGFloatX(CGRectGetMaxX(cell.frame)-50), 0, kScreenWidth/4, cell.height)];
                rigt.text = @"请选择";
                rigt.font = [UIFont systemFontOfSize:CGFloatX(16)];
                [cell addSubview:rigt];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 1:{
            cell.textLabel.text = @"积分抵扣";
            cell.accessoryView = [[UISwitch alloc] init];
            }
                break;
            default:
                break;
        }
            
    }else if (indexPath.section == 1){
     
            NSArray *array = @[@"商品总价",@"运费",@"积分抵扣",@"优惠卷抵扣"];
            cell.textLabel.text = array[indexPath.row];
        UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-kScreenWidth/4-20, 0, kScreenWidth/3, cell.height)];
        
        money.textAlignment = NSTextAlignmentCenter;
        switch (indexPath.row) {
            case 0:
            money.text = [NSString stringWithFormat:@"¥ %@",self.sum];
            money.textColor = [UIColor orangeColor];
                break;
              case 1:
            money.text = @"¥ 9990.00";
            money.textColor = [UIColor orangeColor];
                break;
                case 2:
                money.text = @"¥ 0.00";
                money.textColor = [UIColor grayColor];
                break;
                case 3:
                money.text = @"¥ 0.00";
                money.textColor = [UIColor grayColor];
                break;
            default:
                break;
        }
        [cell addSubview:money];
        
    }else if (indexPath.section == 2){
            cell.textLabel.text = @"发票";
        }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BFPaymentViewController *payment = [[BFPaymentViewController alloc]init];
            [self.navigationController pushViewController:payment animated:YES];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
