//
//  BFPTDetailViewController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/2.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "PTStepViewController.h"
#import "BFZFViewController.h"
#import "FXQViewController.h"
#import "BFPTDetailViewController.h"
#import "BFPTDetailHeaderView.h"
#import "BFPTDetailModel.h"
#import "BFShareView.h"
#import "LogViewController.h"

@interface BFPTDetailViewController ()<BFPTStepDelegate,UIWebViewDelegate, BFPTDetailHeaderViewDelegate, BFShareViewDelegate>
/**webView*/
@property (nonatomic, strong) UIWebView *webView;
/**自定义头部视图*/
@property (nonatomic, strong) BFPTDetailHeaderView *header;
/**自定义头部视图*/
@property (nonatomic, strong) UIView* webBrowserView;

@property (nonatomic, retain) NSMutableArray *dataArray;
//判断是不是拼团
@property (nonatomic, assign) BOOL isPT;

@property (nonatomic, retain) BFPTDetailModel *model;

@property (nonatomic, retain) NSString *endTime;

@end

@implementation BFPTDetailViewController





#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.isPT = YES;
    self.title = @"拼团详情";
    //创建navigationBar
    [self initWithNavigationItem];
    //获取数据
    [self getData];
    
}

#pragma mark --添加导航栏
- (void)initWithNavigationItem{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-fenxiang-6.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(share)];
}

#pragma mark --分享按钮点击事件
- (void)share {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    id<ISSContent> publishContent = [ShareSDK content:self.model.intro
                                       defaultContent:self.model.intro
                                                image:[ShareSDK imageWithUrl:self.model.img]
                                                title:self.model.title
                                                  url:[NSString stringWithFormat:@"http://bingo.luexue.com/index.php?m=Item&a=index&id=%@&uid=%@", self.ID, userInfo.ID]
                                          description:self.model.title
                                            mediaType:SSPublishContentMediaTypeNews];
    //调用自定义分享
    BFShareView *share = [BFShareView shareView];
    share.delegate = self;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:share];
    
}


#pragma mark -- 分享页面代理方法

- (void)shareView:(BFShareView *)shareView type:(BFShareButtonType)type {
    
    switch (type) {
        case BFShareButtonTypeQQZone:{
            [self shareWithType:ShareTypeQQSpace];
            break;
        }
        case BFShareButtonTypeQQFriends:{
            [self shareWithType:ShareTypeQQ];
            break;
        }
        case BFShareButtonTypeWechatFriends:{
            [self shareWithType:ShareTypeWeixiSession];
            break;
        }
        case BFShareButtonTypeMoments:{
            [self shareWithType:ShareTypeWeixiTimeline];
            break;
        }
        case BFShareButtonTypeSinaBlog:{
            [self shareWithType:ShareTypeSinaWeibo];
            break;
        }
    }
}


- (void)shareWithType:(ShareType)shareType {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    BFLog(@"---%@,,%@,,%@,,%@",self.model.title, self.model.intro, self.model.img, self.model);
    if (shareType == ShareTypeSinaWeibo) {
        id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@http://bingo.luexue.com/index.php?m=Item&a=index&id=%@&uid=%@",self.model.title, self.ID, userInfo.ID]
                                           defaultContent:self.model.intro
                                                    image:[ShareSDK imageWithUrl:self.model.img]
                                                    title:self.model.title
                                                      url:nil
                                              description:self.model.title
                                                mediaType:SSPublishContentMediaTypeNews];
        [ShareSDK shareContent:publishContent type:shareType authOptions:nil shareOptions:nil statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            if (state == SSResponseStateSuccess) {
                [BFProgressHUD MBProgressFromView:self.view rightLabelText: @"分享成功"];
                
            }else if (state == SSResponseStateFail) {
                [BFProgressHUD MBProgressFromView:self.view wrongLabelText: @"分享失败"];
                NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
                if ([error errorCode] == 20012) {
                    [BFProgressHUD MBProgressOnlyWithLabelText: @"分享内容过长,请少于140个字节"];
                }
            }else if (state == SSResponseStateCancel) {
                //[BFProgressHUD MBProgressFromView:self wrongLabelText: @"分享失败"];
            }
            BFLog(@"---%d",state);
        }];
        
    }else {
        id<ISSContent> publishContent = [ShareSDK content:self.model.intro
                                           defaultContent:self.model.intro
                                                    image:[ShareSDK imageWithUrl:self.model.img]
                                                    title:self.model.title
                                                      url:[NSString stringWithFormat:@"http://bingo.luexue.com/index.php?m=Item&a=index&id=%@&uid=%@", self.ID, userInfo.ID]
                                              description:self.model.title
                                                mediaType:SSPublishContentMediaTypeNews];
        [ShareSDK showShareViewWithType:shareType container:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            BFLog(@"---%d",type);
            if (state == SSResponseStateSuccess) {
                //[self hideShareView];
                [BFProgressHUD MBProgressFromView:self.view rightLabelText: @"分享成功"];
                
            }else if (state == SSResponseStateFail) {
                //[self hideShareView];
                [BFProgressHUD MBProgressFromView:self.view wrongLabelText: @"分享失败"];
                NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
            }else if (state == SSResponseStateCancel) {
                //[self hideShareView];
                //[BFProgressHUD MBProgressOnlyWithLabelText: @"分享失败"];
            }
        }];
        
    }
}


#pragma mark -- 获取数据
- (void)getData {
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=team_item"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"id"] = self.ID;
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameters success:^(id responseObject) {
            BFLog(@"BFPTDetailViewController%@",responseObject);
            _dataArray = [NSMutableArray array];
            BFPTDetailModel *model = [BFPTDetailModel mj_objectWithKeyValues:responseObject];
            self.model = model;
            model.numbers = 1;
            model.shopID = self.ID;
            self.endTime = model.team_timeend;
            [_dataArray addObject:model];
            //显示图形
            [self initView:model];
            [UIView animateWithDuration:0.5 animations:^{
                self.webView.y = 0;
            }];
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"网络问题"];
            BFLog(@"BFPTDetailViewController%@",error);
        }];

    }];
}

#pragma Mark --创建view
- (void)initView:(BFPTDetailModel *)model{
    self.header = [[BFPTDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    self.header.delegate = self;
    self.header.step.delegate = self;
    self.header.detailModel = model;
    self.header.height = self.header.headerHeight;
    
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight-64)];
    self.webBrowserView = self.webView.scrollView.subviews[0];
    CGRect frame = self.webBrowserView.frame;
    frame.origin.y = CGRectGetMaxY(self.header.frame);
    self.webBrowserView.frame = frame;
    self.webView.delegate = self;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.info]];
    [self.webView loadRequest:request];
    
    [self.webView.scrollView addSubview:self.header];
    [self.view addSubview:self.webView];
}

#pragma mark -- 单独购买按钮点击
- (void)gotoAlonePurchase{
    FXQViewController *fxq = [[FXQViewController alloc]init];
    fxq.ID = self.ID;
    [self.navigationController pushViewController:fxq animated:YES];
}

#pragma mark --团购按钮点击
- (void)gotoGroupPurchaseButton{
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSDate *nowTime = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger inter = [zone secondsFromGMTForDate:nowTime];
    NSDate *localeDate = [nowTime dateByAddingTimeInterval:inter];

    NSString *nowTimes = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];
   
    NSLog(@"===%@===%@",nowTimes,self.endTime);
    
    if (userInfo) {
        if ([nowTimes doubleValue] < [self.endTime doubleValue]) {
            
            BFZFViewController *zf = [[BFZFViewController alloc]init];
            zf.isPT = _isPT;
            zf.ID = self.ID;
            zf.modelArr = _dataArray;
            [self.navigationController pushViewController:zf animated:YES];
        }else{
            [BFProgressHUD MBProgressOnlyWithLabelText:@"团购已结束"];
        }
    }else {
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
            
            LogViewController *logVC= [LogViewController new];
            [self.navigationController pushViewController:logVC animated:YES];
            self.navigationController.navigationBarHidden = NO;
        }];
    }
    
    
}

#pragma mark -- 拼团玩法查看详情
- (void)goToCheckDetail {
    PTStepViewController *pt = [[PTStepViewController alloc]init];
    [self.navigationController pushViewController:pt animated:YES];
}



#pragma mark -- 取消webview的点击
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
