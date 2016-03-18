//
//  FXQViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "UMSocial.h"
#import "BFShareView.h"
#import "BFWebHeaderView.h"
#import "BFStorage.h"
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
#import "CXArchiveShopManager.h"

@interface FXQViewController ()<BFShareViewDelegate,UITabBarControllerDelegate>

@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIView *buttonView;

@property (nonatomic,retain)FXQModel *fxq;
@property (nonatomic,retain)AddShopping *addShopp;
@property (nonatomic,retain)OtherView *other;
@property (nonatomic,retain)BFWebHeaderView *webHeader;
@property (nonatomic,retain)BFWebHeaderView *header;
@property (nonatomic,retain)UIView *webBrowserView;
@property (nonatomic,retain)UIWebView *webView;

@property (nonatomic,retain)UIImageView *clearView;
@property (nonatomic,retain)UIButton *selecdent;

@property (nonatomic,assign)NSInteger number;
@property (nonatomic,assign)NSInteger nowIndex;

@end

@implementation FXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"商品详情";
    self.tabBarController.delegate = self;
    
    [self getDate];
}

- (void)updateViewCtrl{
    [self initWithNavigationItem];
    [self initWithWeb];
    [self initWithTabBar];
}

- (void)initWithNavigationItem{
  
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-fenxiang-2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(fenxiang)];

}

#pragma  mark 初始化webview
- (void)initWithWeb{

    NSURL *url = [NSURL URLWithString:self.fxq.info];
    NSURLRequest *requser = [NSURLRequest requestWithURL:url];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-115)];
    [self.webView loadRequest:requser];
    
    self.header = [[BFWebHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 300) model:self.fxq];
  
    self.webBrowserView = self.webView.scrollView.subviews[0];
    CGRect frame = self.webBrowserView.frame;
    frame.origin.y = CGRectGetMaxY(self.header.frame);
    self.webBrowserView.frame = frame;
    self.header.backgroundColor = [UIColor whiteColor];

    [self.webView.scrollView addSubview:self.header];
    [self.view addSubview:self.webView];
}

#pragma  mark TabBar初始化
- (void)initWithTabBar{

    self.buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-50, kScreenWidth, 50)];
    self.buttonView.backgroundColor = [UIColor whiteColor];
//    self.buttonView.layer.borderWidth = 0.5;
//    self.buttonView.layer.borderColor = [UIColor grayColor].CGColor;
    
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
    [self.buttonView bringSubviewToFront:self.webView];
    [self.view addSubview:self.buttonView];
    
}

#pragma  mark TabBar点击事件
- (void)buttonSelent:(UIButton *)button{

    switch (button.tag) {
        case 0:{
            self.tabBarController.selectedIndex = 0;
          break;
        }case 1:{
            self.tabBarController.selectedIndex = 3;
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }case 2:{
            self.tabBarController.selectedIndex = 1;
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
  
    [self.view addSubview:self.clearView];
    [self.clearView addSubview:view];

       self.other = [[OtherView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-160) img:self.fxq.img title:self.fxq.title money:self.fxq.moneyArr arr:self.fxq.nameArr set:self.fxq.guigeArr num:self.header.addShopp.textF.text];
   
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-20, 0, 20, 20)];
//    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(zhifu) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"guanbis.png"] forState:UIControlStateNormal];
    [view addSubview:button];
    [view addSubview:_other];
    
    if (tag == 10) {
        UIButton *buyButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2-(kScreenWidth/3/2), CGRectGetMaxY(_other.addShopp.frame)+35, kScreenWidth/3, CGFloatY(30))];
        
        [buyButton setTitle:@"确定支付" forState:UIControlStateNormal];
        buyButton.backgroundColor = [UIColor orangeColor];
        buyButton.tag = 112;
        [buyButton addTarget:self action:@selector(closes:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:buyButton];
    }else{

    UIButton *shoppBut = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2-(kScreenWidth/3), CGRectGetMaxY(_other.addShopp.frame)+35, CGFloatX(kScreenWidth/3), CGFloatY(30))];
    shoppBut.tag = 111;
    shoppBut.backgroundColor = rgb(0, 14, 255, 1.0);
    [shoppBut addTarget:self action:@selector(closes:) forControlEvents:UIControlEventTouchUpInside];
    [shoppBut setTitle:@"加入购物车" forState:UIControlStateNormal];
    shoppBut.layer.cornerRadius = 6;
    shoppBut.layer.masksToBounds = YES;
        shoppBut.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(20)];
    
    UIButton *buyBut = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shoppBut.frame)+5, CGRectGetMaxY(_other.addShopp.frame)+35, CGFloatX(kScreenWidth/3), CGFloatY(30))];
    buyBut.tag = 112;
    buyBut.backgroundColor = [UIColor redColor];
    [buyBut addTarget:self action:@selector(closes:) forControlEvents:UIControlEventTouchUpInside];
    [buyBut setTitle:@"立即购买" forState:UIControlStateNormal];
    buyBut.layer.cornerRadius = 6;
    buyBut.layer.masksToBounds = YES;
    buyBut.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(20)];
        
        [view addSubview:shoppBut];
        [view addSubview:buyBut];
    }
}

#pragma  mark 购买按钮点击事件
- (void)zhifu{
    [self.clearView removeFromSuperview];
   
    self.tableView.userInteractionEnabled = YES;
    self.buttonView.userInteractionEnabled = YES;
}

- (void)closes:(UIButton *)button{
   
    switch (button.tag) {
        case 111:{
            [self zhifu];
            
            ShoppingViewController *shopp = [[ShoppingViewController alloc]init];
            NSString *title = self.other.titleLabel.text;
            NSString *img = self.other.img;
            NSString *hot = self.other.hot;
            NSString *money = [self.other.moneyLabel.text substringWithRange:NSMakeRange(4, [self.other.moneyLabel.text length]-5)];
            float num = [self.other.addShopp.textF.text intValue];
//            NSString *num = self.other.addShopp.textF.text;
            BFStorage *storage = [[BFStorage alloc]initWithTitle:title img:img spec:hot money:money number:num shopId:self.ID];
           
            [[CXArchiveShopManager sharedInstance]initWithUserID:@"111" ShopItem:storage];
            [[CXArchiveShopManager sharedInstance]startArchiveShop];
            
            self.tabBarController.selectedIndex = 1;
        [self.navigationController pushViewController:shopp animated:YES];

        
        }break;
        case 112:{
            [self zhifu];
            BFZFViewController *zf = [[BFZFViewController alloc]init];
            zf.titles = self.fxq.title;
            NSString *str = [self.other.moneyLabel.text substringWithRange:NSMakeRange(4, [self.other.moneyLabel.text length]-5)];
            zf.sum = str;
        [self.navigationController pushViewController:zf animated:YES
             ];
        }
            break;
        default:
            break;
    }
}


// 导航栏右按钮点击事件
- (void)fenxiang{
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    BFShareView *share = [BFShareView shareView];
    share.delegate = self;
    [window addSubview:share];
}

- (void)bfShareView:(BFShareView *)shareView type:(BFShareButtonType)type {
    switch (type) {
            
        case BFShareButtonTypeMoments:
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController: self completion:^(UMSocialResponseEntity *response){
                if(response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            BFLog(@"朋友圈分享");
            break;
        case BFShareButtonTypeWechatFriends:
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            BFLog(@"微信好友");
            break;
        case BFShareButtonTypeSinaBlog:
            
            [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"SinaBlog"] socialUIDelegate:self];        //设置分享内容和回调对象
            [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
            BFLog(@"新浪微博分享");
            break;
        case BFShareButtonTypeQQFriends:
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"分享文字" image:nil location:nil urlResource:nil presentedController: self completion:^(UMSocialResponseEntity *response){
                if(response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            BFLog(@"QQ好友分享");
            break;
        case BFShareButtonTypeQQZone:
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"分享文字" image:nil location:nil urlResource:nil presentedController: self completion:^(UMSocialResponseEntity *response){
                if(response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            BFLog(@"QQ空间分享");
            break;
            
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
        
            self.fxq.nameArr = [NSMutableArray array];
            self.fxq.guigeArr = [NSArray array];
            self.fxq.stockArr = [NSMutableArray array];
            self.fxq.imageArr = [NSMutableArray array];
            self.fxq.moneyArr = [NSMutableArray array];
            
         FXQModel *fxq = [[FXQModel alloc]init];
         fxq.img = [dic valueForKey:@"img"];
         fxq.title = [dic valueForKey:@"title"];
         fxq.imgsArr = [dic valueForKey:@"imgs"];
        fxq.oldMoney = [dic valueForKey:@"yprice"];
        NSArray *arr = [dic valueForKey:@"price_array"];
        fxq.info = [dic valueForKey:@"info"];
        
            NSMutableArray *nameArray = [NSMutableArray array];
        for (NSDictionary *dic2 in arr) {
        fxq.guige = [dic2 valueForKey:@"yanse"];
            [nameArray addObject:fxq.guige];
            
            NSArray *guigeArr = [dic2 valueForKey:@"guige"];
            NSMutableArray *pric = [NSMutableArray array];
            NSMutableSet *set = [NSMutableSet set];
            
            for (NSDictionary *dic3 in guigeArr) {
                fxq.guige = [dic3 valueForKey:@"choose"];
                [set addObject:fxq.guige];
                NSArray *answer = [dic3 valueForKey:@"answer"];
                
                for (NSDictionary *dic4 in answer) {
                    fxq.stockArr = [dic4 valueForKey:@"stock"];
                    fxq.price = [dic4 valueForKey:@"price"];
                    [pric addObject:fxq.price];
                    
                }
                fxq.guigeArr = [set allObjects];
                fxq.moneyArr = [pric copy];
            }
            fxq.nameArr = [nameArray copy];
        }
        self.fxq = fxq;
        }
          [self updateViewCtrl];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)minButSelented{
    self.number--;
    self.addShopp.textF.text = [NSString stringWithFormat:@"%d",self.number];
    if (self.number <= 1) {
        self.addShopp.minBut.userInteractionEnabled = NO;
    }
}

- (void)maxButSelented{
    self.number++;
    self.addShopp.textF.text = [NSString stringWithFormat:@"%d",self.number];
    if (self.number > 1) {
        self.addShopp.minBut.userInteractionEnabled = YES;
    }
}
-(BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewControlle{
        [self.navigationController popToRootViewControllerAnimated:YES];

    return YES;
}

@end
