//
//  BFPTDetailViewController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/2.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPTDetailViewController.h"
#import "BFPTDetailHeaderView.h"
#import "BFPTDetailModel.h"

@interface BFPTDetailViewController ()
/**webView*/
@property (nonatomic, strong) UIWebView *webView;
/**自定义头部视图*/
@property (nonatomic, strong) BFPTDetailHeaderView *header;
/**自定义头部视图*/
@property (nonatomic, strong) UIView* webBrowserView;


@end

@implementation BFPTDetailViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    //获取数据
    [self getData];
    
}

- (void)getData {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"m"] = @"Json";
    parameters[@"a"] = @"team_item";
    parameters[@"id"] = self.ID;
    [BFHttpTool GET:BF_URL params:parameters success:^(id responseObject) {
        
        BFPTDetailModel *model = [BFPTDetailModel mj_objectWithKeyValues:responseObject];
        //显示图形
        [self initView:model];
    } failure:^(NSError *error) {
        BFLog(@"BFPTDetailViewController%@",error);
    }];
}

- (void)initView:(BFPTDetailModel *)model{
    self.header = [[BFPTDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    self.header.detailModel = model;
    self.header.height = self.header.headerHeight;
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-110)];
    self.webBrowserView = self.webView.scrollView.subviews[0];
    CGRect frame = self.webBrowserView.frame;
    frame.origin.y = CGRectGetMaxY(self.header.frame);
    self.webBrowserView.frame = frame;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.info]];
    [self.webView loadRequest:request];
    
    [self.webView.scrollView addSubview:self.header];
    [self.view addSubview:self.webView];
}





@end
