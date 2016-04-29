//
//  BFHomeWebViewController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFHomeWebViewController.h"

@interface BFHomeWebViewController ()<UIWebViewDelegate>
/***/
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation BFHomeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
    self.title = self.titleString;
    //创建webView
    [self setUpWebView];
}


- (void)setUpWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.webView.delegate = self;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

#pragma mark -- 取消webview的点击
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    if(navigationType == UIWebViewNavigationTypeLinkClicked)//判断是否是点击链接
        
    {
        return NO;
    }
    
    else{
        return YES;
    }
    
}




@end
