//
//  BFZFViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
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
@interface BFZFViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
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

@property (nonatomic,retain)UISwitch *swit;// 开启积分
@property (nonatomic,assign)float freeprice;//运费
@property (nonatomic,assign)NSInteger score;//总积分
@property (nonatomic,assign)NSInteger scores;// 可用积分
@property (nonatomic,assign)double sum_price;
@property (nonatomic,retain)UILabel *everMoney;//
@property (nonatomic,retain)UILabel *scoreLabel;
@property (nonatomic,retain)UILabel *nullAdds;// 未添加地址
@property (nonatomic,assign)double lastPrice;//实际支付金额

@property (nonatomic,retain)UIButton *wordesBut;
@property (nonatomic,retain)UIView *footV;//尾视图
@property (nonatomic,retain)NSMutableArray *favourableArr;//优惠卷名字
@property (nonatomic,retain)NSMutableArray *favourablePrice;//优惠卷金额

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
    NSLog(@"**********%f==%f==%d",self.sum_price,self.freeprice,self.scores);
    self.footView = [[BFFootViews alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-114, kScreenWidth, 50) money:@"合计:¥ 0.00" home:nil name:@"提交订单"];
    self.footView.backgroundColor = [UIColor whiteColor];
    [self.footView.buyButton addTarget:self action:@selector(payoff) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.footView];
}

#pragma  mark  跳转支付
- (void)payoff{
    
    if (self.name.text == nil) {
        [BFProgressHUD MBProgressFromView:self.view wrongLabelText:@"请选择地址"];
    }else{
    BFPayoffViewController *pay = [[BFPayoffViewController alloc]init];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
#pragma  mark 表视图初始化
- (void)initWithTableView{

    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.footView.height-64) style:UITableViewStyleGrouped];

    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.showsHorizontalScrollIndicator = NO;
    self.tableV.showsVerticalScrollIndicator = NO;
//    self.wordesBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    [_wordesBut setTitle:@"   订单留言" forState:UIControlStateNormal];
//    _wordesBut.backgroundColor = [UIColor grayColor];
//    [_wordesBut addTarget:self action:@selector(wordes) forControlEvents:UIControlEventTouchUpInside];
    
    self.swit = [[UISwitch alloc]init];
    _scoreLabel = [[UILabel alloc]init];
    _scoreLabel.text = @"¥ 0.00";
    _scoreLabel.font = [UIFont systemFontOfSize:15];
    CGFloat width = [Height widthString:_scoreLabel.text font:[UIFont systemFontOfSize:15]];
    _scoreLabel.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-width-10, 0, width, 44);
    
    [self.view addSubview:self.tableV];
}

- (void)wordes{
    
}

#pragma  mark 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.groubeImg.height+30;
    }else{
        return (kScreenWidth/4+20)*(self.modelArr.count);
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

        }
        for (int i = 0; i < self.modelArr.count; i++) {
            BForder *order = [[BForder alloc]initWithFrame:CGRectMake(0,((kScreenWidth/4+10)*i)+(i*5), kScreenWidth, kScreenWidth/4+10) img:img[i] title:title[i] money:money[i] guige:nil number:number[i]];
            order.backgroundColor = [UIColor whiteColor];
            
            [_imageV addSubview:order];
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
                UILabel *rigt = [[UILabel alloc]initWithFrame:CGRectMake(CGFloatX(CGRectGetMaxX(cell.frame)-50), 0, kScreenWidth/4, cell.height)];
                rigt.text = @"请选择";
                rigt.font = [UIFont systemFontOfSize:CGFloatX(16)];
                [cell addSubview:rigt];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 1:{
            cell.textLabel.text = @"积分抵扣";
//            self.swit = [[UISwitch alloc]init];
                cell.accessoryView = self.swit;
                [self.swit addTarget:self action:@selector(scoreBut:) forControlEvents:UIControlEventValueChanged];
            }
                break;
            default:
                break;
        }
            
    }else if (indexPath.section == 1){
     
            NSArray *array = @[@"商品总价",@"运费",@"积分抵扣",@"优惠卷抵扣"];
            cell.textLabel.text = array[indexPath.row];
        self.everMoney = [[UILabel alloc]init];
        _everMoney.font = [UIFont systemFontOfSize:15];
        
        _everMoney.textAlignment = NSTextAlignmentCenter;
        switch (indexPath.row) {
            case 0:{
                [self getPrice:self.sum_price];
                _everMoney.textColor = [UIColor orangeColor];
                break;
            }case 1:{
                [self getPrice:self.freeprice];
            _everMoney.textColor = [UIColor orangeColor];
                break;
            }case 2:
                [cell addSubview:_scoreLabel];
                _scoreLabel.textColor = [UIColor grayColor];
                break;
                case 3:
                [self getPrice:0.00];
                _everMoney.textColor = [UIColor grayColor];
                break;
            default:
                break;
        }
        CGFloat width = [Height widthString:_everMoney.text font:[UIFont systemFontOfSize:15]];
        _everMoney.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-width-10, 0, width, cell.height);
        
        [cell addSubview:_everMoney];
        
    }
    
    return cell;
}

- (void)getPrice:(double)price{
    if (self.sum_price == 0.00) {
        _everMoney.text = @"¥ 0.00";
    }else{
        _everMoney.text = [NSString stringWithFormat:@"¥ %.2f",price];
        NSLog(@"%@",_everMoney.text);
    }
}

#pragma  mark 开启积分抵扣
- (void)scoreBut:(UISwitch *)switc{

    if (switc.on == YES) {
//        NSInteger useScore = self.score/100;
        NSInteger useScore = 10000/100;
        if (useScore > _sum_price/2) {
            self.scores = _sum_price/2;
        }else{
            self.scores = useScore;
        }
        _scoreLabel.text = [NSString stringWithFormat:@"¥ %d.00",self.scores];
        _footView.money.text = [NSString stringWithFormat:@"合计: ¥%.2f",self.lastPrice-self.scores];
    }else{
        _scoreLabel.text = @"¥ 0.00";
        _footView.money.text = [NSString stringWithFormat:@"合计: ¥%.2f",self.lastPrice];
    }
    CGFloat width = [Height widthString:_scoreLabel.text font:[UIFont systemFontOfSize:15]];
    _scoreLabel.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-width-10, 0, width, 44);
}

#pragma  mark cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BFPaymentViewController *payment = [[BFPaymentViewController alloc]init];
            [self.navigationController pushViewController:payment animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 3) {
            
        }
    }
}
#pragma  mark 优惠卷选择

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
    NSString *urlStrs = [NSString stringWithFormat:@"id=627,num=1,price=18.90;"];
    self.userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=app_free"];
    NSMutableDictionary *boty = [NSMutableDictionary dictionary];
    boty[@"uid"] = self.userInfo.ID;
    boty[@"token"] = self.userInfo.token;
    boty[@"data"] = urlStrs;
    boty[@"sheng"] = self.model.sheng;

    [BFHttpTool POST:url params:boty success:^(id responseObject) {
//        NSLog(@"...%@,%@",responseObject,boty);
        self.freeprice = [responseObject[@"freeprice"] floatValue];
       double score = [responseObject[@"score"] integerValue];
        self.score = score;
    
        double price = [responseObject[@"sum_item_price"] doubleValue];
        self.sum_price = price;
        
        NSArray *data = [BFPayoffModel parse:responseObject[@"coupon_data"]];
        self.favourableArr = [NSMutableArray array];
        self.favourablePrice = [NSMutableArray array];
        for (BFPayoffModel *model in data) {
            [_favourableArr addObject:model.name];
            [_favourablePrice addObject:model.money];
        }
        NSLog(@"%@",_favourablePrice);
        [self initWithTableView];

        self.lastPrice = self.sum_price+self.freeprice;
        self.footView.money.text = [NSString stringWithFormat:@"合计: ¥%.2f",self.lastPrice];
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"请检查网络"];
    }];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.name.text == nil) {
        self.nullAdds.alpha = 1;
    }else{
        self.nullAdds.alpha = 0;
        [self getData];
    }
    
    if (self.type.text == nil) {
        self.type.alpha = 0;
    }else{
        self.type.alpha = 1;
    }
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
