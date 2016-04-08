//
//  FXQViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "LogViewController.h"
#import "PrefixHeader.pch"
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

@interface FXQViewController ()<BFShareViewDelegate,UITabBarControllerDelegate,UIWebViewDelegate>

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
@property (nonatomic,retain)BFUserInfo *userInfo;
@property (nonatomic)BOOL popView;//判断点击弹出哪个视图
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic)BOOL isPT;

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
//    [self initWithWeb];
    [self initWithTabBar];
}

- (void)initWithNavigationItem{
  
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-fenxiang-6.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(fenxiang)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-htmal5icon37.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark 初始化webview
- (UIWebView *)webView{
    if (!_webView) {
     
    self.isPT = NO;
    NSURL *url = [NSURL URLWithString:self.fxq.info];
    NSURLRequest *requser = [NSURLRequest requestWithURL:url];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-115)];
    [self.webView loadRequest:requser];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.delegate = self;
    
    _webView.scalesPageToFit = YES;
    
    self.header = [[BFWebHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0) model:self.fxq];
    self.header.frame = CGRectMake(0, 0, kScreenWidth, self.header.headerHeight);
    self.webBrowserView = self.webView.scrollView.subviews[0];
    CGRect frame = self.webBrowserView.frame;
    frame.origin.y = CGRectGetMaxY(self.header.frame);
    self.webBrowserView.frame = frame;
    self.header.backgroundColor = [UIColor whiteColor];

    [self.webView.scrollView addSubview:self.header];
    [self.view addSubview:self.webView];
    }
    return _webView;
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
    [self.view addSubview:self.buttonView];
    [self.view bringSubviewToFront:self.buttonView];
    
    
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
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }

}

#pragma  mark 购买点击
- (void)butSelent:(UIButton *)pop{
    [self ifLog:pop];
}

#pragma  mark 弹出视图
- (void)initWithOtherView:(UIButton *)pop{

    self.clearView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.clearView.image = [UIImage imageNamed:@"ban.png"];
    self.clearView.userInteractionEnabled = YES;
    [self.clearView bringSubviewToFront:self.buttonView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight-160)];
    view.backgroundColor = [UIColor whiteColor];
  
    [self.view addSubview:self.clearView];
    [self.clearView addSubview:view];

       self.other = [[OtherView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-160) img:self.fxq.img title:self.fxq.title money:self.fxq.moneyArr arr:self.fxq.nameArr set:self.fxq.guigeArr num:self.header.addShopp.textF.text stock:self.fxq.stockArr];

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-20, 0, 20, 20)];
//    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(zhifu) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"guanbis.png"] forState:UIControlStateNormal];
    [view addSubview:button];
    [view addSubview:_other];
    NSLog(@"===%@",_fxq.stock);
    if (_fxq.stock == 0) {
        UIButton *buyButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2-(kScreenWidth/3/2), CGRectGetMaxY(_other.addShopp.frame)+35, kScreenWidth/3, CGFloatY(30))];
        
        [buyButton setTitle:@"此商品已下架" forState:UIControlStateNormal];
        buyButton.backgroundColor = [UIColor orangeColor];
        [view addSubview:buyButton];
        
    }else{
    if (pop.tag == 10) {
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
}

#pragma  mark 购买按钮点击事件
- (void)zhifu{
    [self.clearView removeFromSuperview];
   
    self.tableView.userInteractionEnabled = YES;
    self.buttonView.userInteractionEnabled = YES;
}

- (void)closes:(UIButton *)button{
    
    NSString *money = [self.other.moneyLabel.text substringWithRange:NSMakeRange(4, [self.other.moneyLabel.text length]-5)];
    NSString *title = self.other.titleLabel.text;
    NSString *img = self.other.img;
    NSString *guige = self.other.selectedGuige;
    NSString *color = self.other.selectedColor;
   float num = [self.other.addShopp.textF.text intValue];
    
    switch (button.tag) {
        case 111:{
            [self zhifu];
    
            ShoppingViewController *shopp = [[ShoppingViewController alloc]init];
 
            BFStorage *storage = [[BFStorage alloc]initWithTitle:title img:img money:money number:num shopId:self.ID stock:_fxq.stock choose:guige color:color];
            
            [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:storage];
            [[CXArchiveShopManager sharedInstance]startArchiveShop];
            
            self.tabBarController.selectedIndex = 1;
        [self.navigationController pushViewController:shopp animated:YES];

        
        }break;
        case 112:{
            [self zhifu];
        BFZFViewController *zf = [[BFZFViewController alloc]init];
           
            _fxq.numbers = num;
            _fxq.price = money;
            _fxq.choose = guige;
            _fxq.color = color;
           
            zf.isPT = _isPT;
            zf.modelArr = _dataArray;
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
            self.fxq.guigeArr = [NSMutableArray array];
            self.fxq.stockArr = [NSMutableArray array];
            self.fxq.imageArr = [NSMutableArray array];
            self.fxq.moneyArr = [NSMutableArray array];
            self.dataArray = [NSMutableArray array];
            
         FXQModel *fxq = [[FXQModel alloc]init];
         fxq.img = [dic valueForKey:@"img"];
         fxq.title = [dic valueForKey:@"title"];
         fxq.imgsArr = [dic valueForKey:@"imgs"];
        fxq.oldMoney = [dic valueForKey:@"yprice"];
        NSArray *arr = [dic valueForKey:@"price_array"];
        fxq.info = [dic valueForKey:@"info"];
        fxq.shopID = [dic valueForKey:@"id"];
        
        NSMutableArray *nameArray = [NSMutableArray array];
        NSMutableArray *stock = [NSMutableArray array];
        for (NSDictionary *dic2 in arr) {
        fxq.choose = [dic2 valueForKey:@"yanse"];
            [nameArray addObject:fxq.choose];
            
            NSArray *guigeArr = [dic2 valueForKey:@"guige"];
            NSMutableArray *pric = [NSMutableArray array];
            NSMutableArray *guige = [NSMutableArray array];
            
            
            for (NSDictionary *dic3 in guigeArr) {
                fxq.choose = [dic3 valueForKey:@"choose"];
                [guige addObject:fxq.choose];
                
               NSArray *answer = [dic3 valueForKey:@"answer"];
               
                for (NSDictionary *dic5 in answer) {
                    fxq.stock = [dic5 valueForKey:@"stock"];
                    fxq.price = [dic5 valueForKey:@"price"];
                }
                [pric addObject:fxq.price];
                [stock addObject:fxq.stock];
                
                fxq.guigeArr = [guige copy];
                fxq.moneyArr = [pric copy];

            }
            fxq.nameArr = [nameArray copy];
            fxq.stockArr = [stock copy];
            NSLog(@"-----%@",fxq.stockArr);
        }
        self.fxq = fxq;
        [self.dataArray addObject:fxq];
        }
        [self updateViewCtrl];
        [self.webView.scrollView.mj_header endRefreshing];
    }];
    
}

#pragma  mark 判断登陆
- (void)ifLog:(UIButton *)pop{
    if (self.userInfo == nil) {
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录,正在跳转..." dispatch_get_main_queue:^{
            LogViewController *log = [LogViewController new];
            [self.navigationController pushViewController:log animated:YES];
        }];
    }else{
        self.tableView.userInteractionEnabled = NO;
        self.buttonView.userInteractionEnabled = NO;
        [self initWithOtherView:pop];
    }
}

#pragma  mark 刷新数据
- (void)getNewDate{
  self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      [self getDate];
  }];
    [self.webView.scrollView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.userInfo = [BFUserDefaluts getUserInfo];
    self.navigationController.navigationBarHidden = NO;
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

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if(navigationType==UIWebViewNavigationTypeLinkClicked)//判断是否是点击链接
    {
        return NO;
    }
    else{
        return YES;
    }
}

@end
