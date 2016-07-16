//
//  BFTastingExperienceController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFTastingExperienceController.h"
#import "BFShareView.h"
#import "BFTastingExperienceModel.h"
#import "BFTastingExperienceHeaderView.h"
#import "BFTastingExperienceFooterView.h"
#import "BFTastingExperienceCell.h"

@interface BFTastingExperienceController ()<UITableViewDelegate, UITableViewDataSource, BFTastingExperienceFooterViewDelegate, BFShareViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**数组*/
@property (nonatomic, strong) NSArray *listArray;
/**免费试吃数据模型*/
@property (nonatomic, strong) BFTastingExperienceModel *model;
/**头部视图*/
@property (nonatomic, strong) BFTastingExperienceHeaderView *headerView;
/**底部视图*/
@property (nonatomic, strong) BFTastingExperienceFooterView *footerView;
@end

@implementation BFTastingExperienceController

#pragma mark --懒加载

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = @[@"图文详情", @"试吃规则", @"试吃体验"];
    }
    return _listArray;
}

- (BFTastingExperienceFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[BFTastingExperienceFooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(115))];
        _footerView.delegate = self;
    }
    return _footerView;
}

- (BFTastingExperienceHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFTastingExperienceHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(395))];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight-22)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.backgroundColor = BFColor(0xF4F4F4);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"免费试吃";
    self.view.backgroundColor = BFColor(0xffffff);
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
    self.tabBarController.tabBar.hidden = YES;
    //添加tableviewView
    [self tableView];
    //添加navigationbar
    [self setUpNavigationBar];
    //加载数据
    [self getData];
}

#pragma mark -- 加载数据
- (void)getData {
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=item"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"id"] = @"2989";
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"%@", responseObject);
            if (responseObject) {
                self.model = [BFTastingExperienceModel parse:responseObject];
                self.tableView.tableHeaderView = self.headerView;
                self.tableView.tableFooterView = self.footerView;
                self.headerView.model = self.model;
                self.footerView.model = self.model;
                [UIView animateWithDuration:0.5 animations:^{
                    self.tableView.y = 0;
                }];
            }
        } failure:^(NSError *error) {
            BFLog(@"%@", error);
        }];

    }];
//    [BFProgressHUD MBProgressFromView:self.navigationController.view LabelText:@"正在请求" dispatch_get_main_queue:^{
//            }];
}

#pragma mark -- 设置客服按钮
- (void)setUpNavigationBar {
    UIButton *share = [UIButton buttonWithType:0];
    //telephone.backgroundColor = [UIColor redColor];
    share.width = 30;
    share.height = 30;
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [share setImage:[UIImage imageNamed:@"iconfont-fenxiang-6"] forState:UIControlStateNormal];
    UIBarButtonItem *telephoneItem = [[UIBarButtonItem alloc] initWithCustomView:share];
    self.navigationItem.rightBarButtonItem = telephoneItem;
}

#pragma mark -- 分享事件
- (void)share {
   
    //调用自定义分享
    BFShareView *share = [BFShareView shareView];
    share.delegate = self;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:share];
}

#pragma mark -- 分享页面代理方法

- (void)shareView:(BFShareView *)shareView type:(BFShareButtonType)type {
    
    switch (type) {
        case BFShareButtonTypeQQZone:{
            [self shareWithType:SSDKPlatformSubTypeQZone];
            break;
        }
        case BFShareButtonTypeQQFriends:{
            [self shareWithType:SSDKPlatformSubTypeQQFriend];
            break;
        }
        case BFShareButtonTypeWechatFriends:{
            [self shareWithType:SSDKPlatformSubTypeWechatSession];
            break;
        }
        case BFShareButtonTypeMoments:{
            [self shareWithType:SSDKPlatformSubTypeWechatTimeline];
            break;
        }
        case BFShareButtonTypeSinaBlog:{
            [self shareWithType:SSDKPlatformTypeSinaWeibo];
            break;
        }
    }
}


- (void)shareWithType:(SSDKPlatformType)shareType {
    
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:@[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1468469620&di=02144b426c8625fc1877e097952c1a1f&src=http://c.hiphotos.baidu.com/image/pic/item/83025aafa40f4bfbc9c817b9074f78f0f63618c6.jpg"] //传入要分享的图片
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    
    //进行分享
    [ShareSDK share:shareType //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
         if (state == SSDKResponseStateSuccess) {
             [BFProgressHUD MBProgressOnlyWithLabelText: @"分享成功"];
         }else if (state ==  SSDKResponseStateFail) {
                 [BFProgressHUD MBProgressOnlyWithLabelText: @"分享失败"];
             BFLog(@"分享失败%@",error);
         }else if (state ==  SSDKResponseStateCancel) {
                 [BFProgressHUD MBProgressOnlyWithLabelText: @"分享失败"];
         }
     }];
}

//    if (shareType == ShareTypeSinaWeibo) {
//        id<ISSContent> publishContent = [ShareSDK content:@"测试测试"
//                                           defaultContent:@"ddsf"
//                                                    image:nil
//                                                    title:@"这是一个分享测试"
//                                                      url:@"www.baidu.com"
//                                              description:@"哈哈哈"
//                                                mediaType:SSPublishContentMediaTypeNews];;
//        [ShareSDK shareContent:publishContent type:shareType authOptions:nil shareOptions:nil statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//            if (state == SSResponseStateSuccess) {
//                [BFProgressHUD MBProgressOnlyWithLabelText: @"分享成功"];
//                
//            }else if (state == SSResponseStateFail) {
//                [BFProgressHUD MBProgressOnlyWithLabelText: @"未检测到客户端 分享失败"];
//                NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
//                if ([error errorCode] == 20012) {
//                    [BFProgressHUD MBProgressOnlyWithLabelText: @"分享内容过长,请少于140个字节"];
//                }
//            }else if (state == SSResponseStateCancel) {
//                //[BFProgressHUD MBProgressFromView:self wrongLabelText: @"分享失败"];
//            }
//            BFLog(@"---%d",state);
//        }];
//        
//    }else {
//        id<ISSContent> publishContent = [ShareSDK content:@"测试测试"
//                                           defaultContent:@"ddsf"
//                                                    image:nil
//                                                    title:@"这是一个分享测试"
//                                                      url:@"www.baidu.com"
//                                              description:@"哈哈哈"
//                                                mediaType:SSPublishContentMediaTypeNews];
//        [ShareSDK showShareViewWithType:shareType container:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//            BFLog(@"---%d",type);
//            if (state == SSResponseStateSuccess) {
//                //[self hideShareView];
//                [BFProgressHUD MBProgressOnlyWithLabelText: @"分享成功"];
//                
//            }else if (state == SSResponseStateFail) {
//                //[self hideShareView];
//                [BFProgressHUD MBProgressOnlyWithLabelText: @"未检测到客户端 分享失败"];
//                NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
//            }else if (state == SSResponseStateCancel) {
//                //[self hideShareView];
//                //[BFProgressHUD MBProgressOnlyWithLabelText: @"分享失败"];
//            }
//        }];
//        
//    }






#pragma mark -- 申请按钮
- (void)gotoApply {
    BFLog(@"去申请");
}


#pragma mark -- tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFTastingExperienceCell *cell = [BFTastingExperienceCell cellWithTableView:tableView];
    cell.titleLabel.text = self.listArray[indexPath.row];
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return BF_ScaleHeight(44);

}


@end
