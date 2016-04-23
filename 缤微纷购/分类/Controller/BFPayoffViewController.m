//
//  BFPayoffViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088221439311985"
//收款支付宝账号
#define SellerID  @"3188373025@qq.com"
//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @""
//商户私钥，自助生成
#define PartnerPrivKey @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAJw+8QlbW6nYVO9NaEyxbTvD/ySRezvbBlckQz0oXIXyKqC7n2dkAtx3oxGQuumQ0N2iXOrUbsgTRAjIRQS6XYvCuovV+wNCwxF5YBYr8Pry9fSkbAMeCZpbR2PaeHKV8PpFDPsCo+5JFg5ckqROvV3HzNccKXn6DvzRMNjipLM3AgMBAAECgYBV1sqLrnJUhHJdKjTD9bIiZJJ236pJfxIjq9t47QSv3hSHS6zOm4Zq4xtmmhHmIdZt/TZ5GQ5nwxXckVJBv7WGKCo0IYaLRhGF90vSwf6Ec4HXRRfjCcit0Aghs1x8CC8HUyB49Uw4DBFx6MKO7sAYYv88oDL+Kx5Jj6cwjnMUEQJBAM759evQ9ARwvHSidQmLBIPd+3zsv3ZALRUyADwJvfd0Z2la8W0QV+luvwXOFHvbNCgglCFphlwbDHBXf/YKUQ8CQQDBQO2n0nFjIdVtuvZ22bKz50GbXqRgc/V8BXbgbzUjDe/AN12pwsn/iuJBA76bLrsEmpE1hlmTTHZZAiEpfytZAkBLlZLOLD+Ag57+xPkSpBbhBSa7B0YgK+2KyPi29CPQg0zkd5ak6owALjZKK2jlljZk1QjjbsLnTeVr/Tg4pKnXAkAM0XyyBABnXeglNiCA86Gp0y4D2zw19ZsT1dzzuAyjPZpoeoOo7fWuEI0/WLs82dWn0YTOMxIf9hNnhf+jG/9JAkAV+AGrJjXLrHF7eC4IArAhSvuDFB1JN8KAo4DMAY5y5D0G/z4nUewKds0ZTjg8bC9DgaH3W+lUH9Wy4T9SAPoO"
//支付宝公钥
#define AlipayPubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCcPvEJW1up2FTvTWhMsW07w/8kkXs72wZXJEM9KFyF8iqgu59nZALcd6MRkLrpkNDdolzq1G7IE0QIyEUEul2LwrqL1fsDQsMReWAWK/D68vX0pGwDHgmaW0dj2nhylfD6RQz7AqPuSRYOXJKkTr1dx8zXHCl5+g780TDY4qSzNwIDAQAB"

#define AppScheme   @"bwPay"

#import "BFPayoffHeader.h"
#import "BFFootViews.h"
#import "Header.h"
#import "ViewController.h"
#import "BFPayoffViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "WXApiObject.h"
#import "payRequsestHandler.h"
#import "WXApi.h"


@interface BFPayoffViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *tableV;

@property (nonatomic,retain)BFPayoffHeader *header;//头视图

@property (nonatomic,assign)NSInteger height;

@property (nonatomic, strong) BFFootViews *foot;

@property (nonatomic,retain)NSString *price;
@end

@implementation BFPayoffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self initWithTableView];
    [self initWithFoot];
    //倒计时通知，关闭订单
    [BFNotificationCenter addObserver:self selector:@selector(cancleOrder) name:@"cancleOrder" object:nil];
    
    //微信支付成功
    [BFNotificationCenter addObserver:self selector:@selector(paySuccess) name:@"paySuccess" object:nil];
    
    //微信支付失败
    [BFNotificationCenter addObserver:self selector:@selector(payFail) name:@"payFail" object:nil];
    
    NSLog(@"%@",self.header.number.text);
    
    
}

- (void)dealloc {
    [BFNotificationCenter removeObserver:self];
}

- (void)cancleOrder {
    [UIView animateWithDuration:2 animations:^{
        self.foot.buyButton.hidden = YES;
        self.header.now.text = @"已关闭";
        self.header.name.text = @"由于您在30分钟内未付款";
        self.header.title.text = @"订单已关闭";
        self.header.name.textColor = BFColor(0xFF212F);
        self.header.now.textColor = BFColor(0xFF212F);
        self.header.title.textColor = BFColor(0xFF212F);
    }];
    [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"订单超过有效时间,已自动取消"];
    //[self.tableV reloadData];
}


- (void)paySuccess {
   self.foot.buyButton.hidden = YES;
    [BFProgressHUD MBProgressOnlyWithLabelText:@"订单支付成功"];
    self.header.name.text = @"我们以后到你的付款";
    self.header.title.text = @"将尽快发货";
    self.header.now.text = @"待发货";
}

- (void)payFail {
    [BFProgressHUD MBProgressOnlyWithLabelText:@"订单支付失败"];
    self.foot.buyButton.hidden = NO;
}

#pragma  mark 初始化底部视图
- (void)initWithFoot{
    BFFootViews *foot = [[BFFootViews alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-50, kScreenWidth, 50) money:nil home:@"返回首页" name:@"立即支付"];
    self.foot = foot;
    [foot.homeButton addTarget:self action:@selector(goToHome) forControlEvents:UIControlEventTouchUpInside];
    
    [foot.buyButton addTarget:self action:@selector(gotoPay) forControlEvents:UIControlEventTouchUpInside];
    foot.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:foot];
}

#pragma mark -- 返回首页
- (void)goToHome{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark --去支付
- (void)gotoPay {
    if ([self.pay isEqualToString:@"支付宝"]) {
        [self alipay];
    } else if ([self.pay isEqualToString:@"微信支付"])  {
        [self payForWechat];
    }
}

#pragma mark --支付宝支付
- (void)alipay{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    //商户的ID
    order.partner = PartnerID;
    //商户的账号
    order.seller = SellerID;
    order.tradeNO = self.orderid;       //订单ID（由商家自行制定）
    order.productName = @"缤微纷购水果商城";          //商品标题
    //order.productDescription = product.productDescription;//商品描述
    NSRange range = NSMakeRange(5, self.sum.length-5);
    _price = [self.sum substringWithRange:range];
    BFLog(@"--%@",_price);
    order.amount = @"0.01"; //商品价格
    
    order.notifyURL =  @"http://bingo.luexue.com/alipay_notify.php";     //我们服务器的回调地址,支付宝服务器会通过post请求，给我们服务器发送支付信息
    
    order.service = @"mobile.securitypay.pay";    //支付宝服务器的地址
    order.paymentType = @"1";                     // 商品支付填“1”
    order.inputCharset = @"utf-8";                // utf-8 （%1A%2f  NSUTF8encodeXXXX 边个格式
    order.itBPay = @"30m";                        // 30分钟内支付
    order.showUrl = @"m.alipay.com";              // 没有支付宝钱包时跳出的页面
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = AppScheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        NSLog(@"%@",orderString);
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                [BFProgressHUD MBProgressOnlyWithLabelText:@"订单支付成功"];
                self.foot.buyButton.hidden = YES;
                self.header.now.text = @"待发货";
                self.header.name.text = @"我们以后到你的付款";
                self.header.title.text = @"将尽快发货";
            } else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
                [BFProgressHUD MBProgressOnlyWithLabelText:@"订单支付失败"];
                self.foot.buyButton.hidden = NO;
            } else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {
                [BFProgressHUD MBProgressOnlyWithLabelText:@"订单支付失败"];
                self.foot.buyButton.hidden = NO;
            } else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {
                [BFProgressHUD MBProgressOnlyWithLabelText:@"网络链接超时,请重新支付"];
                self.foot.buyButton.hidden = NO;
            }
            NSLog(@"reslut = %@",resultDic);
        }];
        
        
    }
}

#pragma mark --支付宝支付
- (void)payForWechat
{
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    NSMutableDictionary *dict = [req sendPay_demo];
    
    if(dict != nil){
        self.foot.buyButton.hidden = YES;
        NSMutableString *retcode = [dict objectForKey:@"retcode"];
        if (retcode.intValue == 0){
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [dict objectForKey:@"appid"];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            [WXApi sendReq:req];
            //日志输出
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        }else{
            
            if (retcode.intValue == -2) {
                BFLog(@"hahah");
            }
            
            [self alert:@"---提示信息" msg:[dict objectForKey:@"retmsg"]];
        }
    }else{
        [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}

#pragma  mark 初始化表视图
- (void)initWithTableView{
    
    self.header = [[BFPayoffHeader alloc]initWithFrame:CGRectMake(0, 0, 0, 0) timeNum:self.orderid img:self.img];
    self.height = self.header.height;
    
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50) style:UITableViewStyleGrouped];
    
    self.tableV.backgroundColor = BFColor(0xFDF0E3);
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
  
    [self.view addSubview:self.tableV];
}

#pragma  mark 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1;
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *foot = [[UIView alloc]init];
    
    if (section == 0) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 40)];
        
        NSRange range = NSMakeRange(5, self.sum.length-5);
        _price = [self.sum substringWithRange:range];
        
        NSString *count = [NSString stringWithFormat:@"%d",[_img count]];
        lab.text = [NSString stringWithFormat:@"共%@件商品 实付金额: ¥%@",count,_price];
        lab.font = [UIFont systemFontOfSize:CGFloatX(15)];
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:lab.text];

        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(11+[count length],[_price length]+1)];
        [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:nil size:CGFloatX(25)] range:NSMakeRange(12+[count length], [_price length])];
        
        lab.attributedText = attr;
        lab.textAlignment = NSTextAlignmentRight;
        
        foot.backgroundColor = [UIColor whiteColor];
        [foot addSubview:lab];
    }
    return foot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else{
        return 0;
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
    
    NSArray *arr = @[@"支付方式"];
    NSArray *array = @[self.pay];
    
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



@end
