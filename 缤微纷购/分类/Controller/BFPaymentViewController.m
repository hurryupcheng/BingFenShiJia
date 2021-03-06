//
//  BFPaymentViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "ViewController.h"
#import "BFPaymentViewController.h"

@interface BFPaymentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign)double lastPrice;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSString *pay;

@end

@implementation BFPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付方式";
   
    [self initWithTableView];
}

- (void)initWithTableView{
  
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
}

#pragma  mark  表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = rgb(220, 220, 220, 1.0);
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth, 40)];
    NSArray *arr = @[@"在线支付"];
    name.text = arr[section];
    name.font = [UIFont systemFontOfSize:CGFloatX(17)];
    name.textColor = [UIColor grayColor];
    
    [view addSubview:name];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:CGFloatX(17)];
   
//    if (indexPath.section == 0) {
//        NSArray *name = @[@"浦发银行信用卡",@"交通银行信用卡",@"中国建设银行"];
//        NSArray *img = @[@"pufa.png",@"jiaotong.png",@"jianshe.png"];
//        cell.imageView.image = [UIImage imageNamed:img[indexPath.row]];
//        cell.textLabel.text = name[indexPath.row];
//    }else if (indexPath.section == 1){
        NSArray *name = @[@"支付宝",@"微信支付",@"银联在线支付"];
        NSArray *img = @[@"zhifubao.png",@"weixin.png",@"yinlian.png"];
        cell.imageView.image = [UIImage imageNamed:img[indexPath.row]];
        cell.textLabel.text = name[indexPath.row];
//    UIView *vle = [[UIView alloc]initWithFrame:CGRectMake(200, 0, 100, 100)];
//    vle.backgroundColor = [UIColor greenColor];
//    [cell.contentView addSubview:vle];
    
//    }else{
//        self.lastPrice = 200.00;
//        cell.imageView.image = [UIImage imageNamed:@"geren.png"];
//        cell.textLabel.text = [NSString stringWithFormat:@"账户余额支付(当前余额%.2f元)",self.lastPrice];
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
   NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
    self.pay = cell.textLabel.text;
    if (indexPath.section == 2) {
        if (self.lastPrice < self.price) {
            
            UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"当前余额不足" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            
            [aler addAction:action];
            
            [self presentViewController:aler animated:YES completion:nil];
            
        }else{
        NSString *str = @"余额支付";
        _payBlock(str);
        [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
    _payBlock(self.pay);
    [self.navigationController popViewControllerAnimated:YES];
    }
    
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
