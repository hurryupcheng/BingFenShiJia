//
//  BFProductDetailWebViewController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFProductDetailWebViewController.h"

@interface BFProductDetailWebViewController ()<UIWebViewDelegate>
/**webView*/
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation BFProductDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.view.backgroundColor = BFColor(0xffffff);
    //添加webView
    [self setUpWebView];
}

- (void)setUpWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.info]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];

    
}

#pragma mark --不让点击webview
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
