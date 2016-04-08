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

@interface BFPTDetailViewController ()<BFPTStepDelegate,UIWebViewDelegate>
/**webView*/
@property (nonatomic, strong) UIWebView *webView;
/**自定义头部视图*/
@property (nonatomic, strong) BFPTDetailHeaderView *header;
/**自定义头部视图*/
@property (nonatomic, strong) UIView* webBrowserView;

@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic)BOOL isPT;

@end

@implementation BFPTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPT = YES;
    //获取数据
    [self getData];
    
}



- (void)getData {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"m"] = @"Json";
    parameters[@"a"] = @"team_item";
    parameters[@"id"] = self.ID;
    [BFHttpTool GET:BF_URL params:parameters success:^(id responseObject) {
        BFLog(@"BFPTDetailViewController%@",responseObject);
        _dataArray = [NSMutableArray array];
        BFPTDetailModel *model = [BFPTDetailModel mj_objectWithKeyValues:responseObject];
        model.numbers = 1;
        model.shopID = self.ID;
        [_dataArray addObject:model];
        //显示图形
        [self initView:model];
    } failure:^(NSError *error) {
        BFLog(@"BFPTDetailViewController%@",error);
    }];
}

- (void)initView:(BFPTDetailModel *)model{
    self.header = [[BFPTDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    self.header.step.delegate = self;
    self.header.detailModel = model;
    self.header.height = self.header.headerHeight;
    [self.header.alonePurchaseButton addTarget:self action:@selector(alonePurchaseButton) forControlEvents:UIControlEventTouchUpInside];
    [self.header.groupPurchaseButton addTarget:self action:@selector(groupPurchaseButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
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


- (void)alonePurchaseButton{
    FXQViewController *fxq = [[FXQViewController alloc]init];
    fxq.ID = self.ID;
    [self.navigationController pushViewController:fxq animated:YES];
}


- (void)groupPurchaseButton{
    BFZFViewController *zf = [[BFZFViewController alloc]init];
    zf.isPT = _isPT;
    zf.modelArr = _dataArray;
    [self.navigationController pushViewController:zf animated:YES];
}

- (void)goToCheckDetail {
    PTStepViewController *pt = [[PTStepViewController alloc]init];
    [self.navigationController pushViewController:pt animated:YES];
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
