//
//  BFAboutController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAboutController.h"

@interface BFAboutController ()<UIWebViewDelegate>
/**网页*/
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation BFAboutController



#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = self.ID;
    //添加webView
    [self setUpWebView];
}

#pragma mark -- 添加webView
- (void)setUpWebView {
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

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 禁用用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    // 禁用长按弹出框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}


@end
