//
//  FXQViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Height.h"
#import "BFZFViewController.h"
#import "AddShopping.h"
#import "OtherView.h"
#import "HomeViewController.h"
#import "ClassificationViewController.h"
#import "ShoppingViewController.h"
#import "FXQModel.h"
#import "ViewController.h"
#import "LBView.h"
#import "Header.h"
#import "FXQViewController.h"

@interface FXQViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIView *buttonView;
@property (nonatomic,assign)NSInteger numbers;

@property (nonatomic,retain)FXQModel *fxq;
@property (nonatomic,retain)AddShopping *addShopp;
@property (nonatomic,retain)OtherView *other;

@property (nonatomic,retain)NSMutableArray *nameArr;
@property (nonatomic,retain)NSMutableSet *guigeSet;
@property (nonatomic,retain)NSMutableArray *stockArr;
@property (nonatomic,retain)NSMutableArray *imageArr;
@property (nonatomic,retain)NSMutableArray *imgsArr;
@property (nonatomic,retain)NSMutableArray *moneyArr;

@property (nonatomic,retain)UIImageView *clearView;
@property (nonatomic,retain)UIButton *selecdent;

@property (nonatomic,assign)NSInteger nowIndex;

@end

@implementation FXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"商品详情";
    self.numbers = 1;
   
    [self initWithTabBar];
    [self getDate];
}

- (void)updateViewCtrl{
    [self initWithNavigationItem];
    
    [self initWithTabView];

}

- (void)initWithNavigationItem{
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-htmal5icon37.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-fenxiang-2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(fenxiang)];

}

- (void)initWithTabBar{

    self.buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-110, kScreenWidth, 50)];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*50, 0, 50, 50);
        
        button.tag = i;
        button.layer.borderWidth = 0.3;
        button.layer.borderColor = [UIColor grayColor].CGColor;
        [button addTarget:self action:@selector(buttonSelent:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, button.frame.size.width-20, button.frame.size.height-20)];
        [button addSubview:image];
        
        if (button.tag == 0) {
            image.image = [UIImage imageNamed:@"shanpinshouye.png"];
        }else if (button.tag == 1){
            image.image = [UIImage imageNamed:@"icon_04.png"];
        }else{
            image.image = [UIImage imageNamed:@"icon_02.png"];
        }
        
        [self.buttonView addSubview:button];
    }
    
    
    NSArray *butArr = @[@"立即购买",@"加入购物车"];
    for (int j = 0; j < 2; j++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake((50*3)+(j*(kScreenWidth-(50*3))/2), 0, (kScreenWidth-(50*3))/2, 50);
        but.tag = 10+j;
        [but setTitle:butArr[j] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(butSelent:) forControlEvents:UIControlEventTouchUpInside];
        but.titleLabel.font = [UIFont systemFontOfSize:CGFloatY(18)];
        
        if (but.tag == 10) {
            but.backgroundColor = [UIColor redColor];
        }else{
            but.backgroundColor = [UIColor orangeColor];
        }
        
        [self.buttonView addSubview:but];
    }
    
    [self.view addSubview:self.buttonView];

}

#pragma  mark  UITableView
- (void)initWithTabView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-110) style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
}

#pragma  mark TabView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 30;
    }else if (indexPath.row == 1){
        return 30;
    }else{
        return 400;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    NSArray *nameArr = @[@"规格",@"商品详情"];
    cell.textLabel.text = nameArr[indexPath.row];
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    NSURL *url = [NSURL URLWithString:self.fxq.info];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
//    [cell addSubview:web];
    
    if (indexPath.row != 0) {
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScreenWidth/2+100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    imageV.userInteractionEnabled = YES;
    imageV.backgroundColor = [UIColor whiteColor];
  
    CGFloat x = imageV.frame.size.height/2;
    
    LBView *lbView = [[LBView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
    NSMutableArray *arr = [NSMutableArray array];
    for (FXQModel *fx in self.imgsArr) {
        [arr addObject:fx.url];
    }
    lbView.isServiceLoadingImage = YES;
    lbView.dataArray = [arr copy];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(lbView.frame), kScreenWidth-30, x)];
//    title.backgroundColor = [UIColor greenColor];
    title.text = self.fxq.title;
    
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(title.frame), kScreenWidth/4, x)];
//    money.backgroundColor = [UIColor orangeColor];
    money.font = [UIFont systemFontOfSize:CGFloatY(22)];
    money.text = [NSString stringWithFormat:@"¥ %@.00",self.moneyArr[0]];
    money.textColor = [UIColor orangeColor];
    
    UILabel *oldMoney = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(money.frame), CGRectGetMaxY(title.frame), kScreenWidth/4, x)];
//    oldMoney.backgroundColor = [UIColor grayColor];
    NSString *oldPrice = [NSString stringWithFormat:@"¥ %@",self.fxq.oldMoney];
    oldMoney.font = [UIFont systemFontOfSize:CGFloatY(18)];
    oldMoney.textColor = [UIColor grayColor];
    
     NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [oldMoney setAttributedText:attri];
    
    self.addShopp = [[AddShopping alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageV.frame)-(imageV.frame.size.width/3)-20, CGRectGetMaxY(title.frame)-5, kScreenWidth/3, CGFloatY(35))];
    
     _addShopp.textF.text = [NSString stringWithFormat:@"%ld",(long)self.numbers];
    [_addShopp.minBut addTarget:self action:@selector(minButSelented) forControlEvents:UIControlEventTouchUpInside];
    [_addShopp.maxBut addTarget:self action:@selector(maxButSelented) forControlEvents:
     UIControlEventTouchUpInside];
    
    UIView *colorV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(money.frame), kScreenWidth, 1)];
    colorV.backgroundColor = [UIColor grayColor];
    
    [imageV addSubview:lbView];
    [imageV addSubview:colorV];
    [imageV addSubview:_addShopp];
    [imageV addSubview:oldMoney];
    [imageV addSubview:money];
    [imageV addSubview:title];
    
    return imageV;
}

#pragma  mark TabBar点击事件
- (void)buttonSelent:(UIButton *)button{

    switch (button.tag) {
        case 0:{
            
        HomeViewController *home = [[HomeViewController alloc]init];
        [self.navigationController pushViewController:home animated:YES];
            
            break;
        }case 1:{
        ClassificationViewController *class = [[ClassificationViewController alloc]init];
        [self.navigationController pushViewController:class animated:YES];
            
            break;
        }case 2:{
        ShoppingViewController *shopp = [[ShoppingViewController alloc]init];
            [self.navigationController pushViewController:shopp animated:YES];
            break;
        }
        default:
            break;
    }

}

#pragma  mark 购买点击
- (void)butSelent:(UIButton *)but{
    self.tableView.userInteractionEnabled = NO;
    self.buttonView.userInteractionEnabled = NO;
    [self initWithOtherView:but.tag];
}

#pragma  mark 弹出视图
- (void)initWithOtherView:(NSInteger)tag{

    self.clearView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.clearView.image = [UIImage imageNamed:@"ban.png"];
    self.clearView.userInteractionEnabled = YES;
    [self.clearView bringSubviewToFront:self.buttonView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight-160)];
    view.backgroundColor = [UIColor whiteColor];
  
    
       self.other = [[OtherView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, CGRectGetMaxY(view.frame)-160) img:self.fxq.img title:self.fxq.title money:self.moneyArr arr:self.nameArr set:self.guigeSet number:self.numbers];
   
    if (tag == 10) {
        UIButton *buyButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2-(kScreenWidth/3/2), CGRectGetMaxY(_other.addShopp.frame)+35, kScreenWidth/3, CGFloatY(30))];
        
        [buyButton setTitle:@"确定支付" forState:UIControlStateNormal];
        buyButton.backgroundColor = [UIColor orangeColor];
        buyButton.tag = 112;
        [buyButton addTarget:self action:@selector(closes:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:buyButton];
    }else{
        
    UIButton *shoppBut = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2-(kScreenWidth/3), CGRectGetMaxY(_other.addShopp.frame)+35, kScreenWidth/3, CGFloatY(30))];
    shoppBut.tag = 111;
    shoppBut.backgroundColor = rgb(0, 14, 255, 1.0);
    [shoppBut addTarget:self action:@selector(closes:) forControlEvents:UIControlEventTouchUpInside];
    [shoppBut setTitle:@"加入购物车" forState:UIControlStateNormal];
    shoppBut.layer.cornerRadius = 8;
    shoppBut.layer.masksToBounds = YES;
    
    UIButton *buyBut = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shoppBut.frame)+5, CGRectGetMaxY(_other.addShopp.frame)+35, kScreenWidth/3, CGFloatY(30))];
    buyBut.tag = 112;
    buyBut.backgroundColor = [UIColor redColor];
    [buyBut addTarget:self action:@selector(closes:) forControlEvents:UIControlEventTouchUpInside];
    [buyBut setTitle:@"立即购买" forState:UIControlStateNormal];
    buyBut.layer.cornerRadius = 8;
    buyBut.layer.masksToBounds = YES;
        
        [view addSubview:shoppBut];
        [view addSubview:buyBut];
    }
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-20, 0, 20, 20)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(zhifu) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.clearView];
    [self.clearView addSubview:view];
    [view addSubview:button];
    [view addSubview:_other];
   
}

#pragma  mark 购买按钮点击事件
- (void)zhifu{
    [self.clearView removeFromSuperview];
    
    self.tableView.userInteractionEnabled = YES;
    self.buttonView.userInteractionEnabled = YES;
}

- (void)closes:(UIButton *)button{
    if (self.stockArr.count == 0) {
        
    }
    switch (button.tag) {
        case 111:{
            [self zhifu];
            ShoppingViewController *shopp = [[ShoppingViewController alloc]init];
            [self.navigationController pushViewController:shopp animated:YES];
            
        }break;
        case 112:{
            [self zhifu];
            BFZFViewController *zf = [[BFZFViewController alloc]init];
            zf.titles = self.fxq.title;
        [self.navigationController pushViewController:zf animated:YES
             ];
        }
            break;
        default:
            break;
    }
}

// 导航栏左按钮点击事件
- (void)rightButton{
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 导航栏右按钮点击事件
- (void)fenxiang{
    
    NSLog(@"fenxiang");

}

#pragma  mark  产品数量增减按钮点击事件
- (void)minButSelented{
    
    self.numbers--;
    if ([self.addShopp.textF.text integerValue] == 1) {
        self.addShopp.minBut.userInteractionEnabled = NO;
        self.addShopp.textF.text = @"1";
    }else{
        self.addShopp.maxBut.userInteractionEnabled = YES;
    self.addShopp.textF.text = [NSString stringWithFormat:@"%ld",(long)self.numbers];

    }

}

- (void)maxButSelented{
    
    self.numbers++;
    if ([self.addShopp.textF.text integerValue] >= (NSInteger)self.fxq.stock) {
        self.addShopp.maxBut.userInteractionEnabled = NO;
        self.addShopp.textF.text = self.fxq.stock;
    }else{
        self.addShopp.minBut.userInteractionEnabled = YES;
    self.addShopp.textF.text = [NSString stringWithFormat:@"%ld",(long)self.numbers];
    }
}

#pragma mark 数据解析
- (void)getDate{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://bingo.luexue.com/index.php?m=Json&a=item&id=%@",self.ID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",url);
        if (data != nil) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
            self.nameArr = [NSMutableArray array];
            self.guigeSet = [NSMutableSet set];
            self.stockArr = [NSMutableArray array];
            self.imageArr = [NSMutableArray array];
            self.moneyArr = [NSMutableArray array];
            
         FXQModel *fxq = [[FXQModel alloc]init];
         fxq.img = [dic valueForKey:@"img"];
         fxq.title = [dic valueForKey:@"title"];
         self.imgsArr = [dic valueForKey:@"imgs"];
        fxq.oldMoney = [dic valueForKey:@"yprice"];
        NSArray *arr = [dic valueForKey:@"price_array"];
            fxq.info = [dic valueForKey:@"info"];
       
        for (NSDictionary *dic2 in arr) {
        fxq.yanse = [dic2 valueForKey:@"yanse"];
            NSArray *guigeArr = [dic2 valueForKey:@"guige"];
            for (NSDictionary *dic3 in guigeArr) {
                fxq.guige = [dic3 valueForKey:@"choose"];
                NSArray *answer = [dic3 valueForKey:@"answer"];
                for (NSDictionary *dic4 in answer) {
                    fxq.stock = [dic4 valueForKey:@"stock"];
                    fxq.price = [dic4 valueForKey:@"price"];
                    [self.moneyArr addObject:fxq.price];
                    [self.stockArr addObject:fxq.stock];

                }
            [self.guigeSet addObject:fxq.guige];
            }
            [self.nameArr addObject:fxq.yanse];
        }
        self.fxq = fxq;
        }
          [self updateViewCtrl];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}


@end
