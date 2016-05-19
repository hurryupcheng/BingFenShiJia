 //
//  BFZFViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGenerateOrderModel.h"
#import "BFGroupDetailController.h"
#import "BFPTDetailViewController.h"
#import "BFGroupOrderDetailController.h"
#import "CXArchiveShopManager.h"
#import "BFCouponView.h"
#import "BFScoreView.h"
#import "BFPTDetailModel.h"
#import "BFPayoffModel.h"
#import "FXQModel.h"
#import "PrefixHeader.pch"
#import "Height.h"
#import "BFHttpTool.h"
#import "BFStorage.h"
#import "BFAddressController.h"
#import "BFPaymentViewController.h"
#import "BFPayoffViewController.h"
#import "BFFootViews.h"
#import "ViewController.h"
#import "BForder.h"
#import "Header.h"
#import "BFZFViewController.h"
#import "BFAddressModel.h"

@interface BFZFViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,BFCouponViewDelegate,UITextViewDelegate>{
    __block int         leftTime;
    __block NSTimer     *timer;
}
@property (nonatomic,retain)UITableView *tableV;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UIImageView *groubeImg;
@property (nonatomic,retain)UILabel *name;
@property (nonatomic,retain)UILabel *photo;
@property (nonatomic,retain)UILabel *adds;
@property (nonatomic,retain)UILabel *type;
@property (nonatomic,retain)UIImageView *img;
@property (nonatomic,retain)BFFootViews *footView;
@property (nonatomic,retain)BForder *order;
/**地址模型*/
@property (nonatomic, strong) BFAddressModel *model;
@property (nonatomic,retain)NSMutableArray *dataArr;
@property (nonatomic,retain)BFUserInfo *userInfo;

@property (nonatomic,retain)BFScoreView *scoreView;//积分视图
@property (nonatomic,retain)UIView *scoreBackView;
@property (nonatomic,retain)UILabel *scoreTitle;
@property (nonatomic,retain)UISwitch *swit;// 开启积分
@property (nonatomic,assign)float freeprice;//运费
@property (nonatomic,assign)NSInteger score;//总积分
@property (nonatomic,assign)NSInteger scores;// 可用积分
@property (nonatomic,assign)double sum_price; // 总价
@property (nonatomic,assign)double useScorePrice;// 抵扣金额
@property (nonatomic,retain)UILabel *everMoney;// cell中金额
@property (nonatomic,retain)UILabel *nullAdds;// 未添加地址
@property (nonatomic,assign)double lastPrice;//实际支付金额
@property (nonatomic,assign)double couponPrice;//优惠卷金额
@property (nonatomic,retain)UIImageView *wordesImg;
@property (nonatomic,retain)UIView *wordesBack;
@property (nonatomic,assign)NSInteger wordesNum;
@property (nonatomic)BOOL isWordes;
@property (nonatomic,retain)UITextView *textView;//留言输入
@property (nonatomic,retain)NSMutableArray *favourableArr;//优惠卷名字
@property (nonatomic,retain)NSMutableArray *favourablePrice;//优惠卷金额
@property (nonatomic,retain)NSMutableArray *favourableTime;//使用期限
@property (nonatomic,retain)NSMutableArray *favourableID;//id
@property (nonatomic,retain)UILabel *payTitle;//回调支付方式

@property (nonatomic,retain)BFCouponView *couponView;//弹出优惠卷视图
@property (nonatomic,assign)NSInteger couponHeight;// 视图高度
@property (nonatomic)BOOL isCoupon;//是否弹出视图
@property (nonatomic,assign)NSInteger nums;//cell点击次数

@property (nonatomic,retain)NSMutableArray *addressArray;

@property (nonatomic)BOOL hidden;
@property (nonatomic,retain)NSString *coupon_id;//优惠卷id
@property (nonatomic,retain)NSString *addressID;//地址ID
@property (nonatomic,retain)NSString *itemDate;//产品数据拼接
@property (nonatomic,retain)NSMutableArray *itemImg;//商品图片

@end

@implementation BFZFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"确认支付";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
   
    self.isCoupon = NO;
    self.isWordes = NO;
    self.coupon_id = @"0";
    
    [self initWithFootView];
    [self getData];
//    [self getNewData];
}

- (void)initWithFootView{

    self.footView = [[BFFootViews alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-114, kScreenWidth, 50) money:@"合计:¥ 0.00" home:nil name:@"提交订单"];
    self.footView.backgroundColor = [UIColor whiteColor];
    [self.footView.buyButton addTarget:self action:@selector(payoff) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.footView];
}

#pragma  mark  跳转支付
- (void)payoff{
    
    if (self.name.text == nil) {
        [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"请选择地址"];
    }else if([self.payTitle.text isEqualToString:@"请选择"]){
        [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"请选择支付方式"];
    }else{
        [self postPayoffNews];
    }
}

#pragma  mark 提交订单信息
- (void)postPayoffNews{

    if (self.isPT) {
        [self groupOrder];
        BFLog(@"----------");
    }else {
        [self singleProductOrder];
    }
    //点击按钮倒计时
    leftTime = Countdown;
    [self.footView.buyButton setEnabled:NO];
    [self.footView.buyButton setBackgroundColor:BFColor(0xD5D8D1)];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

#pragma mark -- 倒计时
- (void)timerAction {
    leftTime--;
    if(leftTime<=0)
    {
        [self.footView.buyButton setEnabled:YES];
        self.footView.buyButton.backgroundColor = BFColor(0xFD8627);
        //倒计时完取消倒计时
        [timer invalidate];
        timer = nil;
    } else
    {
        
        [self.footView.buyButton setEnabled:NO];
        [self.footView.buyButton setBackgroundColor:BFColor(0xD5D8D1)];
    }

}


#pragma mark -- 拼团订单
- (void)groupOrder {
    [BFProgressHUD MBProgressWithLabelText:@"正在跳转支付页面..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        _userInfo = [BFUserDefaluts getUserInfo];
        NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=do_team_order"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"uid"] = _userInfo.ID;
        parameter[@"token"] = _userInfo.token;
        parameter[@"itemid"] = self.ID;
        parameter[@"coupon_id"] = self.coupon_id;
        parameter[@"pay_score"] = @(self.useScorePrice);
        parameter[@"postscript"] = _textView.text;
        parameter[@"address_id"] = self.addressID;
        
        if ([self.payTitle.text isEqualToString:@"支付宝"]) {
            parameter[@"pay_type"] = @"2";
        }else {
            parameter[@"pay_type"] = @"1";
        }
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            NSLog(@"////%@==%@",parameter,responseObject);
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                
                NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=re_order_pay"];
                NSMutableDictionary *paramerer = [NSMutableDictionary dictionary];
                paramerer[@"uid"] = self.userInfo.ID;
                paramerer[@"token"] = self.userInfo.token;
                paramerer[@"orderId"] = responseObject[@"orderid"];
                [BFHttpTool POST:url params:paramerer success:^(id responseObject) {
                    BFLog(@"++++++++++%@", responseObject);
                    
                    
                    BFGenerateOrderModel *orderModel = [BFGenerateOrderModel parse:responseObject];
                    BFPayoffViewController *pay = [[BFPayoffViewController alloc]init];
                    pay.pay = self.payTitle.text;
                    pay.orderid = orderModel.orderid;
                    pay.orderModel = orderModel;
                    pay.img = _itemImg;
                    pay.isPT = self.isPT;
                    BFLog(@"++++++++%d,,,%d", pay.isPT, self.isPT);
                    NSRange range = NSMakeRange(5, self.footView.money.text.length-5);
                    pay.totalPrice = [self.footView.money.text substringWithRange:range];
                    
//                    [BFProgressHUD MBProgressFromView:self.navigationController.view LabelText:@"正在跳转到支付页面..." dispatch_get_main_queue:^{
                    [hud hideAnimated:YES];
                        [self.navigationController pushViewController:pay animated:YES];
//                    }];
                    //订单生成修改积分数量
                    //[BFAvailablePoints updateAvailablePoints];
                    
                    
                } failure:^(NSError *error) {
                    BFLog(@"%@",error);
                }];
            }else if ([responseObject[@"msg"] isEqualToString:@"库存不足"]){
                [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"库存不足,订单提交失败"];
            }else{
                [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"订单提交失败"];
            }
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
            BFLog(@"%@", error);
            
        }];

    }];
    
}

#pragma mark -- 单品订单
- (void)singleProductOrder {

    [BFProgressHUD MBProgressWithLabelText:@"正在跳转支付页面..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        _userInfo = [BFUserDefaluts getUserInfo];
        NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=order_pay"];
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        data[@"uid"] = _userInfo.ID;
        data[@"token"] = _userInfo.token;
        data[@"coupon_id"] = self.coupon_id;
        data[@"pay_score"] = @(self.useScorePrice);
        data[@"postscript"] = _textView.text;
        data[@"address_id"] = self.addressID;
        data[@"data"] = self.itemDate;
        if ([self.payTitle.text isEqualToString:@"支付宝"]) {
            data[@"pay_type"] = @"2";
        }else {
            data[@"pay_type"] = @"1";
        }
        
        [BFHttpTool POST:url params:data success:^(id responseObject) {
            NSLog(@"////%@==%@",data,responseObject);
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=re_order_pay"];
                NSMutableDictionary *paramerer = [NSMutableDictionary dictionary];
                paramerer[@"uid"] = self.userInfo.ID;
                paramerer[@"token"] = self.userInfo.token;
                paramerer[@"orderId"] = responseObject[@"orderid"];
                [BFHttpTool POST:url params:paramerer success:^(id responseObject) {
                    BFLog(@"++++++++++%@", responseObject);
                    BFGenerateOrderModel *orderModel = [BFGenerateOrderModel parse:responseObject];
                    BFPayoffViewController *pay = [[BFPayoffViewController alloc]init];
                    pay.pay = self.payTitle.text;
                    pay.orderModel = orderModel;
                    pay.orderid = orderModel.orderid;
                    pay.addTime = orderModel.addtime;
                    pay.img = _itemImg;
                    NSRange range = NSMakeRange(5, self.footView.money.text.length-5);
                    pay.totalPrice = [self.footView.money.text substringWithRange:range];
    //                [BFProgressHUD MBProgressFromView:self.navigationController.view LabelText:@"正在跳转到支付页面..." dispatch_get_main_queue:^{
                    [hud hideAnimated:YES];
                        [self.navigationController pushViewController:pay animated:YES];

    //                }];
                } failure:^(NSError *error) {
                    BFLog(@"%@",error);
                }];

                for (BFPTDetailModel *model in self.modelArr){
                    [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
                    [[CXArchiveShopManager sharedInstance]removeItemKeyWithOneItem:model.shopID];
                    
                    NSArray *array = [[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop];
                    UITabBarController *tabBar = [self.tabBarController viewControllers][1];
                    if (array.count == 0) {
                        tabBar.tabBarItem.badgeValue = nil;
                    }else {
                        tabBar.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
                    }
                    
                }
                self.removeBlock();
                //订单生成修改积分数量
                //[BFAvailablePoints updateAvailablePoints];
                
                
            }else if ([responseObject[@"msg"] isEqualToString:@"库存不足"]){
                
                [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"库存不足,订单提交失败"];
            }else {
                [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"网络异常,订单提交失败"];
            }
        } failure:^(NSError *error) {
            BFLog(@"%@", error);
            
        }];
     }];
}



#pragma mark -- 倒计时1800，到时间取消订单
//- (void)timerAction {
//    leftTime--;
//    if (leftTime == 0) {
//        [BFNotificationCenter postNotificationName:@"cancleOrder" object:nil];
//    }
//}


- (void)addsView{
    
    UIButton *home = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [home setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [home addTarget:self action:@selector(gotoHomeController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:home];
    self.navigationItem.rightBarButtonItem = barItem;
    
    self.groubeImg = [[UIImageView alloc]init];
    self.groubeImg.image = [UIImage imageNamed:@"adds.png"];
    self.groubeImg.backgroundColor = [UIColor whiteColor];
    
    self.name = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, kScreenWidth/2, CGFloatY(25))];
    self.name.font = [UIFont systemFontOfSize:CGFloatX(17)];
//    self.name.backgroundColor = [UIColor grayColor];
    
    self.type = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.name.frame), 30, CGFloatX(60), CGFloatY(25))];
    self.type.layer.cornerRadius = 10;
    self.type.layer.borderWidth = 1;
    self.type.layer.borderColor = rgb(0, 0, 128, 1.0).CGColor;
    self.type.font = [UIFont systemFontOfSize:CGFloatX(15)];
    self.type.textColor = rgb(0, 0, 128, 1.0);
    self.type.textAlignment = NSTextAlignmentCenter;
    
    self.photo = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_name.frame), kScreenWidth, CGFloatY(25))];
    
    _photo.font = [UIFont systemFontOfSize:CGFloatX(17)];
    
//    _photo.backgroundColor = [UIColor greenColor];
    
    self.adds = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_photo.frame)+5, kScreenWidth-50, CGFloatY(50))];
    
    _adds.numberOfLines = 2;
    _adds.font = [UIFont systemFontOfSize:CGFloatX(17)];
    _adds.textColor = [UIColor grayColor];
//    _adds.backgroundColor = [UIColor redColor];
    
    self.groubeImg.frame = CGRectMake(0, 15, kScreenWidth, CGRectGetMaxY(_adds.frame));
//    self.groubeImg.backgroundColor = [UIColor orangeColor];
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-30, self.groubeImg.height/2, 15, 15)];
    _img.image = [UIImage imageNamed:@"jianjiao.png"];
    
    self.nullAdds = [[UILabel alloc]initWithFrame:CGRectMake(15, (_groubeImg.frame.size.height)/2, kScreenWidth, 30)];
    self.nullAdds.text = @"请添加地址";
    self.nullAdds.textColor = rgb(0, 0, 128, 1.0);
    
}

- (void)gotoHomeController{
    self.tabBarController.selectedIndex = 0;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (UITableView *)tableV{
    if (!_tableV) {
        self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.footView.height-64) style:UITableViewStyleGrouped];
//        [self.view addSubview:self.tableV];
    }
    return _tableV;
}
#pragma  mark 表视图初始化
- (void)initWithTableView{
 
//    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.footView.height-64) style:UITableViewStyleGrouped];

    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.showsHorizontalScrollIndicator = NO;
    self.tableV.showsVerticalScrollIndicator = NO;
    
// 积分抵扣控件
    self.swit = [[UISwitch alloc]init];
    
    _scoreTitle = [[UILabel alloc]init];
    NSInteger useScore = self.score;
//    NSInteger useScore = 100000/100;
    if (useScore > _sum_price/2) {
        self.scores = _sum_price/2;
    }else{
        self.scores = useScore;
    }

    _scoreTitle.text = [NSString stringWithFormat:@"积分抵扣(最多%ld元)",(long)self.scores];
     _scoreTitle.font = [UIFont systemFontOfSize:CGFloatX(17)];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:_scoreTitle.text];
    [str addAttribute:NSForegroundColorAttributeName value:rgb(0, 128, 0, 1.0) range:NSMakeRange(4, [_scoreTitle.text length]-4)];
    _scoreTitle.attributedText = str;
   
//  开启积分抵扣后控件
    _scoreBackView = [[UIView alloc]init];
    _scoreView = [[BFScoreView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) num:self.scores];
    
//
    _payTitle = [[UILabel alloc]init];
    _payTitle.text = @"请选择";
    _payTitle.font = [UIFont systemFontOfSize:CGFloatX(16)];
    CGFloat widths = [Height widthString:_payTitle.text font:[UIFont systemFontOfSize:16]];
    _payTitle.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-CGFloatX(widths)-CGFloatX(30), 0, CGFloatX(widths), 44);
   
    self.nums = 1;
    self.wordesNum = 1;
    
    _wordesImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-40, 13, CGFloatX(25), CGFloatX(25))];
    _wordesImg.image = [UIImage imageNamed:@"iconfont-xiajianhao.png"];
    
    [self addsView];
    [self.view addSubview:self.tableV];
}

#pragma  mark 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if(section == 1){
        return 4;
    }else if(section == 2){
        return 1;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (self.isCoupon == YES) {
            return (CGFloatX(90)*_favourableArr.count)+(10*(_favourableArr.count+1))+8;
        }else{
            return 0;
        }

    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.groubeImg.height+30;
    }else if(section == 1){
        return (kScreenWidth/4+10)*(self.modelArr.count)+(self.modelArr.count*5);
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *back = [[UIView alloc]init];
    if (section == 0) {
        if (self.isCoupon == YES) {
            
            _couponView = [[BFCouponView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, (CGFloatX(90)*_favourableArr.count)+(10*_favourableArr.count)) name:_favourableArr price:_favourablePrice end:_favourableTime];
            _couponHeight = _couponView.height;
            _couponView.couponDelegate = self;
            
            [back addSubview:_couponView];
        }

    }
    return back;
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
        [_imageV addSubview:_type];
        [_imageV addSubview:_nullAdds];
        
        if (self.addressArray.count == 0) {
            self.nullAdds.alpha = 1;
            self.type.alpha = 0;
        }else{
            self.nullAdds.alpha = 0;
            self.type.alpha = 1;
 
            _name.text = self.model.consignee;
            _photo.text = self.model.mobile;
            _adds.text = self.model.address;
            if ([self.model.type isEqualToString:@"0"]) {
                _type.text = @"家";
            }else if ([self.model.type isEqualToString:@"1"]){
                _type.text = @"公司";
            }else{
                _type.text = @"其他";
            }
    
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerDid)];
        [_imageV addGestureRecognizer:tap];
        
    }else if(section == 1){
        NSMutableArray *title = [NSMutableArray array];
        NSMutableArray *money = [NSMutableArray array];
        NSMutableArray *number = [NSMutableArray array];
        _itemImg = [NSMutableArray array];
        NSMutableArray *guige = [NSMutableArray array];
        NSMutableArray *color = [NSMutableArray array];
        
        for (BFPTDetailModel *model in self.modelArr) {
            [title addObject:model.title];
            if (_isPT == YES) {
                [money addObject:model.team_price];
            }else{
            [money addObject:model.price];
            }
            [_itemImg addObject:model.img];
            NSString *num = [NSString stringWithFormat:@"%ld",(long)model.numbers];
            [number addObject:num];
            if (model.choose) {
            [guige addObject:model.choose];
            }
            if (model.color) {
            [color addObject:model.color];
            }
        }
        for (int i = 0; i < self.modelArr.count; i++) {
            if (guige.count != 0 || color.count != 0) {
            _order = [[BForder alloc]initWithFrame:CGRectMake(0,-7+((kScreenWidth/4+10)*i)+(i*5), kScreenWidth, kScreenWidth/4+10) img:_itemImg[i] title:title[i] money:money[i] guige:guige[i] number:number[i] color:color[i]];
                
            }else{
            _order = [[BForder alloc]initWithFrame:CGRectMake(0,-7+((kScreenWidth/4+10)*i)+(i*5), kScreenWidth, kScreenWidth/4+10) img:_itemImg[i] title:title[i] money:money[i] guige:@"" number:number[i] color:@""];
            }
            _order.backgroundColor = [UIColor whiteColor];
            
            [_imageV addSubview:_order];
        }
    }
    return _imageV;
}

#pragma  mark 回调地址
- (void)headerDid{
    NSLog(@"地址点击");
//    self.model = nil;
    BFAddressController *addVC = [BFAddressController new];
    addVC.block = ^(BFAddressModel *model) {
        if (model != nil) {
            self.nullAdds.hidden = YES;
        }
        self.model = model;
        [self.addressArray addObject:model];
        _name.text = model.consignee;
         _photo.text = model.mobile;
        _adds.text = model.address;
        if ([model.type isEqualToString:@"0"]) {
            _type.text = @"家";
        }else if ([model.type isEqualToString:@"1"]){
        _type.text = @"公司";
        }else{
        _type.text = @"其他";
        }
        [self getNewData];
        BFLog(@".....%@",model.consignee);
    };
   
    [self.tableV reloadData];
    [self.navigationController pushViewController:addVC animated:YES];
    
}

#pragma  mark 表视图代理方法
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
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:cell.textLabel.text];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 1)];
                cell.textLabel.attributedText = attr;
                [cell addSubview:_payTitle];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 1:{
                if (self.swit.on == YES) {
                    _scoreBackView.frame = CGRectMake(0, 0, kScreenWidth, _scoreView.height+50);
                    _scoreView.frame = CGRectMake(0, CGRectGetMaxY(_scoreTitle.frame)+10, kScreenWidth, _scoreView.height);
                    
                    [_scoreBackView addSubview:_scoreView];
                }else{
                    _scoreBackView.frame = CGRectMake(0, 0, kScreenWidth, 44);
                    [_scoreView removeFromSuperview];
                }
                
            _scoreTitle.frame = CGRectMake(15, 5, kScreenWidth, 30);
            _swit.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-65, 5, 40, 30);
                
                [_scoreBackView addSubview:_swit];
                [_scoreBackView addSubview:_scoreTitle];
                [cell addSubview:_scoreBackView];
                if (self.scores == 0) {
                    self.swit.userInteractionEnabled = NO;
                }else{
                [self.swit addTarget:self action:@selector(scoreBut:) forControlEvents:UIControlEventValueChanged];
                }
            }
                break;
            case 2:{
            cell.textLabel.text = @"优惠券抵扣";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            default:
                break;
        }
            
    }else if (indexPath.section == 1){
     
            NSArray *array = @[@"商品总价",@"运费",@"积分抵扣",@"优惠券抵扣"];
            cell.textLabel.text = array[indexPath.row];
        
        switch (indexPath.row) {
            case 0:{
                [self getPrice:self.sum_price height:cell.height];
                _everMoney.textColor = [UIColor orangeColor];
                break;
            }case 1:{
                [self getPrice:self.freeprice height:cell.height];
            _everMoney.textColor = [UIColor orangeColor];
                break;
            }case 2:{
        
                [self getPrice:self.useScorePrice height:cell.height];
                _everMoney.textColor = [UIColor grayColor];
                break;
            }case 3:{
                [self getPrice:self.couponPrice height:cell.height];
//                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:cell.textLabel.text];
//                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 1)];
//                cell.textLabel.attributedText = attr;
                
                _everMoney.textColor = [UIColor grayColor];
                break;
        }
            default:
                break;
        }
          [cell addSubview:_everMoney];
        
    }else if (indexPath.section == 2){
        cell.textLabel.text = @"订单留言";
        [cell addSubview:_wordesImg];
    }
    return cell;
}

- (void)getPrice:(double)price height:(NSInteger)height{
    _everMoney = [[UILabel alloc]init];
    _everMoney.font = [UIFont systemFontOfSize:15];
    _everMoney.textAlignment = NSTextAlignmentCenter;
    if (price == 0.00) {
        _everMoney.text = @"¥ 0.00";
    }else{
    _everMoney.text = [NSString stringWithFormat:@"¥ %.2f",price];
    }
    CGFloat width = [Height widthString:_everMoney.text font:[UIFont systemFontOfSize:15]];
    _everMoney.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-width-10, 0, width, height);
}

#pragma  mark 开启积分抵扣
- (void)scoreBut:(UISwitch *)switc{
   _scoreView.price.text = nil;
    if (switc.on == YES) {
        if (_scoreView.price.text == nil) {

            _everMoney.text = @"¥ 0.00";
        }else{
            
            __block typeof(self) weak = self;
            _scoreView.scoreBlock = ^(NSString *str){
                weak.useScorePrice = [str doubleValue];

                    weak.footView.money.text = [NSString stringWithFormat:@"合计: ¥%.2f",weak.lastPrice-weak.useScorePrice-weak.couponPrice];

                [weak.tableV reloadData];
             
            };
        }
        
    }else{
        _useScorePrice = 0.00;
        _footView.money.text = [NSString stringWithFormat:@"合计: ¥%.2f",self.lastPrice-self.useScorePrice-self.couponPrice];
    }
    
    [self.tableV reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.swit.on == YES) {
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                return _scoreView.height+50;
            }
        }
    }
        return 44;
}

#pragma  mark cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BFPaymentViewController *payment = [[BFPaymentViewController alloc]init];
            payment.payBlock = ^(NSString *str){
                self.payTitle.text = str;
                CGFloat width = [Height widthString:str font:[UIFont systemFontOfSize:16]];
                _payTitle.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-CGFloatX(width)-CGFloatX(30), 0, CGFloatX(width), 44);
                [self.tableV reloadData];
            };
            NSString *strs = [self.footView.money.text substringFromIndex:5];
            payment.price = [strs doubleValue];
           
            [self.navigationController pushViewController:payment animated:YES];
        }
        
        if (indexPath.row == 2) {
            if (_favourableArr == nil) {
                self.isCoupon = NO;
                self.coupon_id = @"0";
                
            }else{
                self.nums++;
                if (self.nums%2 == 0) {
                    self.isCoupon = YES;
                }else{
                    self.isCoupon = NO;
                    self.couponPrice = 0.00;
                    self.coupon_id = @"0";
                    self.footView.money.text = [NSString stringWithFormat:@"合计: ¥%.2f",self.lastPrice-self.useScorePrice-self.couponPrice];
                }
                [self.tableV reloadData];
        }
    }
        
    }else if (indexPath.section == 2){
        self.wordesNum++;
        if (self.wordesNum%2 == 0) {
            self.isWordes = YES;
        }else{
            self.isWordes = NO;
        }
        if (self.isWordes == YES) {
            _wordesBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
            _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 50)];
            _textView.returnKeyType = UIReturnKeyDefault;
            [_wordesBack addSubview:_textView];
            _textView.delegate = self;
            _textView.returnKeyType = UIReturnKeyDone;
            self.tableV.tableFooterView = _wordesBack;
        }else{
//            [self.tableV.tableFooterView removeFromSuperview];
            self.tableV.tableFooterView = nil;
        }
    }
}
#pragma  mark 代理优惠卷选择
- (void)BFCouponViewDelegate:(BFCouponView *)view index:(NSInteger)index{

    self.nums = 1;
    self.isCoupon = NO;
    self.couponPrice = [_favourablePrice[index] doubleValue];
    self.coupon_id = [NSString stringWithFormat:@"%@",_favourableID[index]];
    self.footView.money.text = [NSString stringWithFormat:@"合计: ¥%.2f",self.lastPrice-self.couponPrice-self.useScorePrice];
    [self.tableV reloadData];
}

#pragma  mark 解析
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=check_address"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{

        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            
                NSArray *array = [BFAddressModel parse:responseObject[@"address"]];
            for (BFAddressModel *model in array) {
                if ([model.def isEqualToString:@"1"]) {
                    
                    self.model = model;
                [self.addressArray addObject:model];
                }
                
             }
            [self getNewData];
            } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"网络问题"];
            BFLog(@"%@", error);
        }];
        
    }];
}


- (void)getNewData{
    NSLog(@"数据请求了多少次");
    _dataArr = [NSMutableArray array];
    NSString *string;
    self.itemDate = @"";
    for (BFPTDetailModel *model in self.modelArr) {

        string = [NSString stringWithFormat:@"id=%@,",model.shopID];
        string = [string stringByAppendingString:[NSString stringWithFormat:@"num=%ld,",(long)model.numbers]];
        if (self.isPT == YES) {
        string = [string stringByAppendingString:[NSString stringWithFormat:@"price=%@;",model.team_price]];
        }else{
        string = [string stringByAppendingString:[NSString stringWithFormat:@"price=%@;",model.price]];
        }
        self.itemDate = [self.itemDate stringByAppendingString:[NSString stringWithFormat:@"%@",string]];
        NSLog(@"========%ld=========%@",(long)model.numbers,model.price);
    }

    self.userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=app_free"];
    NSMutableDictionary *boty = [NSMutableDictionary dictionary];
    boty[@"uid"] = self.userInfo.ID;
    boty[@"token"] = self.userInfo.token;
    boty[@"data"] = self.itemDate;
    boty[@"sheng"] = self.model.sheng;
    self.addressID = self.model.ID;

    [BFHttpTool POST:url params:boty success:^(id responseObject) {
        NSLog(@"...%@  %@",responseObject,boty);

       self.freeprice = [responseObject[@"freeprice"] floatValue];
        
        if (responseObject[@"score"]) {
            double score = [responseObject[@"score"] integerValue];
            self.score = score;
        }
    
        double price = [responseObject[@"sum_item_price"] doubleValue];
        self.sum_price = price;
        
        if ([responseObject[@"coupon_data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = [BFPayoffModel parse:responseObject[@"coupon_data"]];
            self.favourableArr = [NSMutableArray array];
            self.favourablePrice = [NSMutableArray array];
            self.favourableTime = [NSMutableArray array];
            self.favourableID = [NSMutableArray array];
            
            for (BFPayoffModel *model in data) {
                
                [_favourableArr addObject:model.name];
                [_favourablePrice addObject:model.money];
                [_favourableTime addObject:model.end_time];
                [_favourableID addObject:model.ID];
            }
        }
        
        
        
//        NSLog(@"////%@",_favourablePrice);
//        NSLog(@"====%@",_favourableID);
        [self initWithTableView];

        self.lastPrice = self.sum_price+self.freeprice;
        self.footView.money.text = [NSString stringWithFormat:@"合计: ¥%.2f",self.lastPrice];
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"请检查网络"];
    }];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
    //self.tabBarController.tabBar.hidden = YES;
}


-(void)hideKeyboard:(NSNotification *)noti{
    
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    //键盘弹起的时间
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect bottomViewFrame = _tableV.frame;
    bottomViewFrame.origin.y = self.view.frame.size.height-bottomViewFrame.size.height-50;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        _tableV.frame = bottomViewFrame;
    } completion:nil];
    //为了显示动画
    [self.view layoutIfNeeded];
    
}
-(void)showKeyboard:(NSNotification *)noti{
    //NSLog(@"userInfo %@",noti.userInfo);
    //键盘出现后的位置
    CGRect endframe = [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //键盘弹起时的动画效果
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    //键盘弹起的时间
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect bottomViewFrame = _tableV.frame;
    bottomViewFrame.origin.y = endframe.origin.y - bottomViewFrame.size.height-50;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        _tableV.frame = bottomViewFrame;
    } completion:nil];
    [self.view layoutIfNeeded];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;    
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    

    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
}

- (NSMutableArray *)addressArray{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
