//
//  BFCheckLogisticsController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFCheckLogisticsController.h"

@interface BFCheckLogisticsController ()
/**查看物流*/
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation BFCheckLogisticsController

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流信息";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.kuaidi100.com/result.jsp?com=&nu=%@", self.freecode]]];
    BFLog(@"%@",[NSString stringWithFormat:@"http://m.kuaidi100.com/result.jsp?com=&nu=%@", self.freecode]);
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
