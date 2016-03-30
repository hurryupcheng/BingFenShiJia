//
//  BFGroupOrderDetailController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupOrderDetailController.h"
#import "BFGroupOrderDetailView.h"
#import "BFGroupOrderDetailModel.h"

@interface BFGroupOrderDetailController ()
/**团订单详情自定义view*/
@property (nonatomic, strong) BFGroupOrderDetailView *detailView;
@end

@implementation BFGroupOrderDetailController


- (BFGroupOrderDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[BFGroupOrderDetailView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        [self.view addSubview:_detailView];
    }
    return _detailView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"团订单详情";
    //添加自定义view
    [self detailView];
    //添加数据
    [self getData];
}

- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=torderstatus"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"itemid"] = self.itemid;
    parameter[@"teamid"] = self.teamid;
    
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        BFLog(@"%@",responseObject);
        if (responseObject) {
            self.detailView.model = [BFGroupOrderDetailModel parse:responseObject[@"order"]];
        }
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
}


@end
