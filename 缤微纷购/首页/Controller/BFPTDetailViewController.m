//
//  BFPTDetailViewController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/2.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPTDetailViewController.h"
#import "BFPTDetailHeaderView.h"

@interface BFPTDetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) BFPTDetailHeaderView *header;
@property (nonatomic, strong) UIView *addview;
@end

@implementation BFPTDetailViewController





- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.delegate = self;
    
    self.header = [[BFPTDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    self.header.height = self.header.headerHeight;
    //self.header.y = -self.header.headerHeight;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.header.headerHeight, ScreenWidth, ScreenHeight-110)];
    self.webView.scrollView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bingo.luexue.com/index.php?m=Json&a=info&id=3159"]];
    [self.webView loadRequest:request];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.header];
    [self.view addSubview:self.webView];


}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BFLog(@"scrollViewDidScroll");
}






@end
