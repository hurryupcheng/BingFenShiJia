//
//  BFZFViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
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
@interface BFZFViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,BFCouponViewDelegate,UITextViewDelegate>
@property (nonatomic,retain)UITableView *tableV;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UIImageView *groubeImg;
@property (nonatomic,retain)UILabel *name;
@property (nonatomic,retain)UILabel *photo;
@property (nonatomic,retain)UILabel *adds;
@property (nonatomic,retain)UILabel *type;
@property (nonatomic,retain)UIImageView *img;
@property (nonatomic,retain)BFFootViews *footView;
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
@property (nonatomic,retain)UILabel *payTitle;//回调支付方式

@property (nonatomic,retain)BFCouponView *couponView;//弹出优惠卷视图
@property (nonatomic,assign)NSInteger couponHeight;// 视图高度
@property (nonatomic)BOOL isCoupon;//是否弹出视图
@property (nonatomic,assign)NSInteger nums;//cell点击次数

@property (nonatomic)BOOL hidden;

@end

@implementation BFZFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"确认支付";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
   
    self.isCoupon = NO;
    self.isWordes = NO;
    
    [self initWithFootView];
    [self initWithTableView];
    [self addsView];
    [self getData];
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
        [BFProgressHUD MBProgressFromView:self.view wrongLabelText:@"请选择地址"];
    }else if([self.payTitle.text isEqualToString:@"请选择"]){
        [BFProgressHUD MBProgressFromView:self.view wrongLabelText:@"请选择支付方式"];
    }else{
        BFPayoffViewController *pay = [[BFPayoffViewController alloc]init];
        pay.pay = self.payTitle.text;
        
        for (BFPTDetailModel *model in self.modelArr){
        [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
        [[CXArchiveShopManager sharedInstance]removeItemKeyWithOneItem:model.shopID];
        }
        self.removeBlock();
        [self.navigationController pushViewController:pay animated:YES];
    }
}


- (void)addsView{

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_01.png"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoHomeController)];
    
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
#pragma  mark 表视图初始化
- (void)initWithTableView{

    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.footView.height-64) style:UITableViewStyleGrouped];

    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.showsHorizontalScrollIndicator = NO;
    self.tableV.showsVerticalScrollIndicator = NO;
    
// 积分抵扣控件
    self.swit = [[UISwitch alloc]init];
    
    _scoreTitle = [[UILabel alloc]init];
    NSInteger useScore = self.score/100;
//    NSInteger useScore = 100000/100;
    if (useScore > _sum_price/2) {
        self.scores = _sum_price/2;
    }else{
        self.scores = useScore;
    }

    _scoreTitle.text = [NSString stringWithFormat:@"积分抵扣(最多%d元)",self.scores];
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

    [self.view addSubview:self.tableV];
}

#pragma  mark 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 4;
    }else if(section == 2){
        return 1;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.groubeImg.height+30;
    }else if(section == 1){
        return (kScreenWidth/4+10)*(self.modelArr.count)+(self.modelArr.count*5);
    }else if(section == 2){
        if (self.isCoupon == YES) {
         return (CGFloatX(90)*_favourableArr.count)+(10*_favourableArr.count);
        }else{
            return 0;
        }
    }else{
        return 0;
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
        [_imageV addSubview:_type];
        [_imageV addSubview:_nullAdds];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerDid)];
        [_imageV addGestureRecognizer:tap];
        
    }else if(section == 1){
        NSMutableArray *title = [NSMutableArray array];
        NSMutableArray *money = [NSMutableArray array];
        NSMutableArray *number = [NSMutableArray array];
        NSMutableArray *img = [NSMutableArray array];
        NSMutableArray *guige = [NSMutableArray array];
        NSMutableArray *color = [NSMutableArray array];
        
        for (BFPTDetailModel *model in self.modelArr) {
            [title addObject:model.title];
            if (_isPT == YES) {
                [money addObject:model.team_price];
            }else{
            [money addObject:model.price];
            }
            [img addObject:model.img];
            NSString *num = [NSString stringWithFormat:@"%d",model.numbers];
            [number addObject:num];
            [guige addObject:model.choose];
            [color addObject:model.color];
           
        }
        for (int i = 0; i < self.modelArr.count; i++) {
            BForder *order = [[BForder alloc]initWithFrame:CGRectMake(0,-7+((kScreenWidth/4+10)*i)+(i*5), kScreenWidth, kScreenWidth/4+10) img:img[i] title:title[i] money:money[i] guige:guige[i] number:number[i] color:color[i]];
            order.backgroundColor = [UIColor whiteColor];
            
            [_imageV addSubview:order];
        }
    }else if (section == 2){
   
        if (self.isCoupon == YES) {
            
            _couponView = [[BFCouponView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (CGFloatX(90)*_favourableArr.count)+(10*_favourableArr.count)) name:_favourableArr price:_favourablePrice end:_favourableTime];
            _couponHeight = _couponView.height;
            _couponView.couponDelegate = self;
            
           [_imageV addSubview:_couponView];
        }
    }

    return _imageV;
}

#pragma  mark 回调地址
- (void)headerDid{
    NSLog(@"地址点击");
    BFAddressController *addVC = [BFAddressController new];
    addVC.block = ^(BFAddressModel *model) {
        self.model = model;
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
        BFLog(@".....%@",self.model);
    };
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
            default:
                break;
        }
            
    }else if (indexPath.section == 1){
     
            NSArray *array = @[@"商品总价",@"运费",@"积分抵扣",@"优惠卷抵扣"];
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
            }case 3:
                [self getPrice:self.couponPrice height:cell.height];
                _everMoney.textColor = [UIColor grayColor];
                break;
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
            };
            NSString *strs = [self.footView.money.text substringFromIndex:5];
            payment.price = [strs doubleValue];
           
            [self.navigationController pushViewController:payment animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 3) {
           
            if (_favourableArr == nil) {
                self.isCoupon = NO;
            }else{
            self.nums++;
            if (self.nums%2 == 0) {
                self.isCoupon = YES;
            }else{
            self.isCoupon = NO;
            self.couponPrice = 0.00;
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
            self.tableV.tableFooterView = _wordesBack;
        }else{
            [self.tableV.tableFooterView removeFromSuperview];
        }
    }
}
#pragma  mark 代理优惠卷选择
- (void)BFCouponViewDelegate:(BFCouponView *)view index:(NSInteger)index{

    self.nums = 1;
    self.isCoupon = NO;
    self.couponPrice = [_favourablePrice[index] doubleValue];
    self.footView.money.text = [NSString stringWithFormat:@"合计: ¥%.2f",self.lastPrice-self.couponPrice-self.useScorePrice];
    [self.tableV reloadData];
}


#pragma  mark 解析
- (void)getData{
 
    _dataArr = [NSMutableArray array];
    NSString *string;
    NSString *urlStr = @"";
    for (BFPTDetailModel *model in self.modelArr) {

        string = [NSString stringWithFormat:@"id=%@,",model.shopID];
        string = [string stringByAppendingString:[NSString stringWithFormat:@"num=%d,",model.numbers]];
        if (self.isPT == YES) {
        string = [string stringByAppendingString:[NSString stringWithFormat:@"price=%@;",model.team_price]];
        }else{
        string = [string stringByAppendingString:[NSString stringWithFormat:@"price=%@;",model.price]];
        }
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@",string]];
    }
    NSLog(@"\\\\\\%@",urlStr);
    NSString *urlStrs = [NSString stringWithFormat:@"id=627,num=1,price=118.90;"];
    self.userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [BF_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=app_free"];
    NSMutableDictionary *boty = [NSMutableDictionary dictionary];
    boty[@"uid"] = self.userInfo.ID;
    boty[@"token"] = self.userInfo.token;
    boty[@"data"] = urlStr;
    boty[@"sheng"] = self.model.sheng;
    NSLog(@"======%@",self.model.sheng);
    [BFHttpTool POST:url params:boty success:^(id responseObject) {
        NSLog(@"...%@  %@",responseObject,boty);
        self.freeprice = [responseObject[@"freeprice"] floatValue];
       double score = [responseObject[@"score"] integerValue];
        self.score = score;
    
        double price = [responseObject[@"sum_item_price"] doubleValue];
        self.sum_price = price;
        
        NSArray *data = [BFPayoffModel parse:responseObject[@"coupon_data"]];
        self.favourableArr = [NSMutableArray array];
        self.favourablePrice = [NSMutableArray array];
        self.favourableTime = [NSMutableArray array];
        for (BFPayoffModel *model in data) {
            [_favourableArr addObject:model.name];
            [_favourablePrice addObject:model.money];
            [_favourableTime addObject:model.end_time];
        }
        NSLog(@"////%@",_favourablePrice);
        [self initWithTableView];

        self.lastPrice = self.sum_price+self.freeprice;
        self.footView.money.text = [NSString stringWithFormat:@"合计: ¥%.2f",self.lastPrice];
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"请检查网络"];
    }];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
    if (self.name.text == nil) {
        self.nullAdds.alpha = 1;
        self.type.alpha = 0;
    }else{
        self.nullAdds.alpha = 0;
        self.type.alpha = 1;
    }
    
    self.tabBarController.tabBar.hidden = YES;
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
    self.navigationController.navigationBar.translucent = NO;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    self.tabBarController.tabBar.hidden = YES;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
