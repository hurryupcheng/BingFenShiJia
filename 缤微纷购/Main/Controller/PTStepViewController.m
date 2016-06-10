
//
//  PTStepViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/1.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "PTStepViewController.h"

@interface PTStepViewController ()

@end

@implementation PTStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建webview
    [self setUpWebView];
    //创建返回按钮
    [self setUpBackButton];
    
    
}


- (void)setUpWebView {
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    web.scrollView.showsVerticalScrollIndicator = NO;
    web.scrollView.showsHorizontalScrollIndicator = NO;
    
    [web loadRequest:request];
    [self.view addSubview:web];
}


- (void)setUpBackButton {
    UIButton *back = [UIButton buttonWithType:0];
    back.frame = CGRectMake(5, 22, 35, 40);
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];

}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark --viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
