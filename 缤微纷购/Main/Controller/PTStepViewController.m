
//
//  PTStepViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/1.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "PTStepViewController.h"

@interface PTStepViewController ()

@end

@implementation PTStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-60)];
    
    NSURL *url = [NSURL URLWithString:@"http://bingo.luexue.com/index.php?m=Teambuy&a=help"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    web.scrollView.showsVerticalScrollIndicator = NO;
    web.scrollView.showsHorizontalScrollIndicator = NO;
    
    [web loadRequest:request];
    [self.view addSubview:web];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
