//
//  BFGroupOrderDetailController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFGroupDetailController.h"
#import "BFGroupOrderDetailController.h"
#import "BFGroupOrderDetailView.h"
#import "BFGroupOrderDetailModel.h"

@interface BFGroupOrderDetailController ()<BFGroupOrderDetailViewDelegate>
/**团订单详情自定义view*/
@property (nonatomic, strong) BFGroupOrderDetailView *detailView;
@end

@implementation BFGroupOrderDetailController

#pragma mark --懒加载
- (BFGroupOrderDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[BFGroupOrderDetailView alloc] initWithFrame:CGRectMake(0, 64-ScreenHeight, ScreenWidth, ScreenHeight-64)];
        _detailView.delegate = self;
        [self.view addSubview:_detailView];
    }
    return _detailView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"团订单详情";
    //添加自定义view
    [self detailView];
    //添加数据
    [self getData];
}

#pragma mark --获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=torderstatus"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"itemid"] = self.itemid;
    parameter[@"teamid"] = self.teamid;
    
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"%@",responseObject);
            if (responseObject) {
                self.detailView.model = [BFGroupOrderDetailModel parse:responseObject[@"order"]];
                [UIView animateWithDuration:0.5 animations:^{
                    self.detailView.y = 0;
                }];
            }
        } failure:^(NSError *error) {
            BFLog(@"%@",error);
        }];
    }];
}

#pragma mark --BFGroupOrderDetailViewDelegate代理方法
- (void)clickToViewWithButtonType:(BFGroupOrderDetailViewButtonType)buttonType {
    switch (buttonType) {
        case BFGroupOrderDetailViewButtonTypePay:{
            BFLog(@"点击支付");
            break;
        }
        case BFGroupOrderDetailViewButtonTypeGroup:{
            BFGroupDetailController *groupDetailVC = [[BFGroupDetailController alloc] init];
            groupDetailVC.itemid = self.itemid;
            groupDetailVC.teamid = self.teamid;
            [self.navigationController pushViewController:groupDetailVC animated:YES];
            BFLog(@"点击查看团详情");
            break;
        }
    }
}


@end
