//
//  BFSettingController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define kUMKey  @"56e3cf9fe0f55a2fe50023fb"

#import "BFSettingController.h"
#import "BFShareView.h"
#import "BFCustomerServiceView.h"
#import "BFPersonInformationController.h"
#import "BFModifyPasswordController.h"
#import "BFCleanView.h"
#import "BFHomeModel.h"
#import "BFAboutController.h"
#import "LogViewController.h"
#import "PTStepViewController.h"
#import "BFSettingHeadItem.h"
#import "BFSettingArrowItem.h"
#import "BFSettingSwitchItem.h"
#import "BFSettingGroup.h"

@interface BFSettingController ()<UITableViewDelegate, UITableViewDataSource,  BFCustomerServiceViewDelegate, BFShareViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**音效开关*/
@property (nonatomic, strong) UISwitch *switchButton;
@end

@implementation BFSettingController

#pragma mark --懒加载



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"设置";
    [self.view addSubview:self.tableView];
    //
    [self createSoundSwitch];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    //设置底部按钮视图
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (userInfo.ID) {
        [self setBottomView];
    }

}

- (void)createSoundSwitch {
    self.switchButton = [[UISwitch alloc] init];
    self.switchButton.on = [[BFUserDefaluts getSwitchInfo] intValue    ];
    [self.switchButton addTarget:self action:@selector(soundSwitch:) forControlEvents:UIControlEventValueChanged];
    self.switchButton.onTintColor = BFColor(0x0977ca);
    self.switchButton.tintColor = BFColor(0xBABABA);
}




#pragma mark -- 退出按钮视图
- (void)setBottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-BF_ScaleHeight(50)-64, ScreenWidth, BF_ScaleHeight(50))];
    bottomView.backgroundColor = BFColor(0xffffff);
    [self.view addSubview:bottomView];
    
    UIButton *exitButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(80), BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(160), BF_ScaleHeight(30)) title:@"退出登录" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xffffff)];
    exitButton.layer.cornerRadius = BF_ScaleHeight(15);
    exitButton.backgroundColor = BFColor(0xFD8727);
    [exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:exitButton];
}


#pragma mark --- datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        if ([userInfo.loginType isEqualToString:@"3"]) {
            return 4;
        }else {
            return 3;
        }
    }else if (section == 2) {
        return 3;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    cell.detailTextLabel.textColor = BFColor(0x000073);
    cell.detailTextLabel.text = nil;
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
 
        cell.textLabel.text = @"联系客服";
        cell.detailTextLabel.text = @"020-38875719";
    } else if (indexPath.section == 1) {
        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        if ([userInfo.loginType isEqualToString:@"3"]) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"修改密码";
                    
                    break;
                case 1:{
                    cell.textLabel.text = @"清空图片缓存";
                    CGFloat size =[SDImageCache sharedImageCache].getSize / 1000.0 / 1000;
                    //NSString *clearCacheName = size >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",size] : [NSString stringWithFormat:@"清理缓存(%.2fK)",size * 1024];
                    if (size >= 1) {
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f MB", size];
                    }else {
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f KB", size * 1024];
                    }
                    
                    break;
                }case 2:
                    cell.textLabel.text = @"个人信息";
                   
                    break;
                case 3:
                    cell.textLabel.text = @"音效开关";
                  
                    cell.accessoryView = self.switchButton;

                    break;
            }
        }else {
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text = @"清空图片缓存";
                    CGFloat size =[SDImageCache sharedImageCache].getSize / 1024.0 / 1024.0;
                    //NSString *clearCacheName = size >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",size] : [NSString stringWithFormat:@"清理缓存(%.2fK)",size * 1024];
                    if (size >= 1) {
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f MB", size];
                    }else {
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f KB", size * 1024];
                    }
                    
                    break;
                }case 1:
                    cell.textLabel.text = @"个人信息";
                    
                    break;
                case 2:
                    cell.textLabel.text = @"音效开关";
                    
                    cell.accessoryView = self.switchButton;
                    
                    break;

            }
        }
    } else if (indexPath.section == 2) {
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"版本信息";
                cell.detailTextLabel.text = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
                break;
            case 1:
                cell.textLabel.text = @"亲，给缤纷好评吧";
                break;
            case 2:
                cell.textLabel.text = @"分享App";
                break;
        }
    }else {
        
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"关于我们";
                break;

        }


    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (indexPath.section == 0) {
        //打电话
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        BFCustomerServiceView *customerServiceView = [BFCustomerServiceView createCustomerServiceView];
        customerServiceView.delegate = self;
        [window addSubview:customerServiceView];
        
    }else if (indexPath.section == 1) {
        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        if ([userInfo.loginType isEqualToString:@"3"]) {
            switch (indexPath.row) {
                case 0:{
                    if (userInfo == nil) {
                        [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
                            self.navigationController.navigationBarHidden = NO;
                            LogViewController *logVC= [LogViewController new];
                            [self.navigationController pushViewController:logVC animated:YES];
                            
                        }];
                    }else {
                        BFModifyPasswordController *modifyPasswordVC = [BFModifyPasswordController new];
                        [self.navigationController pushViewController:modifyPasswordVC animated:YES];
                        BFLog(@"修改密码");
                        
                    }
                    break;
                }
                case 1:{
                    BFLog(@"清空图片缓存");
                    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
                    BFCleanView *cleanView = [BFCleanView cleanView];
                    [window addSubview:cleanView];
                    
                   // CGFloat size =[SDImageCache sharedImageCache].getSize / 1024.0 / 1024.0;
                    [[SDImageCache sharedImageCache] clearDisk];
                    [self.tableView reloadData];
//                    NSString *clearCacheName = size >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",size] : [NSString stringWithFormat:@"清理缓存(%.2fK)",size * 1024];
//
//                    BFLog(@"缓存--%@", clearCacheName);
                    break;
                }case 2:{
                    if (userInfo == nil) {
                        [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
                            self.navigationController.navigationBarHidden = NO;
                            LogViewController *logVC= [LogViewController new];
                            [self.navigationController pushViewController:logVC animated:YES];
                        }];
                    }else {
                        BFPersonInformationController *personInformationVC = [[BFPersonInformationController alloc] init];
                        [self.navigationController pushViewController:personInformationVC animated:YES];
                        BFLog(@"个人信息");
                    }
                    break;
                }
            }

        }else {
            switch (indexPath.row) {
                case 0:{
                    BFLog(@"清空图片缓存");
                    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
                    BFCleanView *cleanView = [BFCleanView cleanView];
                    [window addSubview:cleanView];
                    
                    CGFloat size =[SDImageCache sharedImageCache].getSize / 1024.0 / 1024.0;
                    NSString *clearCacheName = size >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",size] : [NSString stringWithFormat:@"清理缓存(%.2fK)",size * 1024];
                    [[SDImageCache sharedImageCache] clearDisk];
                    [self.tableView reloadData];
                    BFLog(@"缓存--%@", clearCacheName);
                    break;
                }case 1:{
                    if (userInfo == nil) {
                        [BFProgressHUD MBProgressFromWindowWithLabelText:@"未登录，正在跳转..." dispatch_get_main_queue:^{
                            self.navigationController.navigationBarHidden = NO;
                            LogViewController *logVC= [LogViewController new];
                            [self.navigationController pushViewController:logVC animated:YES];
                        }];
                    }else {
                        BFPersonInformationController *personInformationVC = [[BFPersonInformationController alloc] init];
                        [self.navigationController pushViewController:personInformationVC animated:YES];
                        BFLog(@"个人信息");
                    }
                    break;
                }
            }

        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            //点击看看是否有版本更新
            NSString *url = @"http://itunes.apple.com/lookup?id=1131613819";
            [BFHttpTool POST:url params:nil success:^(id responseObject) {
                NSArray *array = responseObject[@"results"];
                NSDictionary *dict = [array lastObject];
                NSString *storeVersion = [dict[@"version"] substringFromIndex:2];
                NSString *currentVersion = [[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] substringFromIndex:2];
                if ([storeVersion floatValue] > [currentVersion floatValue]) {
                    UIAlertController *alertController = [UIAlertController alertWithControllerTitle:@"版本更新提醒" controllerMessage:@"检测到AppStore有新的版本,请问是否需要更新" preferredStyle:UIAlertControllerStyleAlert actionTitle:@"立即前往AppStore更新"style:UIAlertActionStyleDefault handler:^{
                        NSString *appid = @"1131613819";
                        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
                        NSURL *url = [NSURL URLWithString:str];
                        [[UIApplication sharedApplication] openURL:url];
                    }];
                [self presentViewController:alertController animated:YES completion:nil];
                }else {
                    [BFProgressHUD MBProgressOnlyWithLabelText:@"当前版本已经是最新版本"];
                }
            } failure:^(NSError *error) {
                [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络问题"];
            }];
        }else if (indexPath.row == 1) {
            
            NSString *appid = @"1131613819";
            NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
            NSURL *url = [NSURL URLWithString:str];
            [[UIApplication sharedApplication] openURL:url];

        }else if (indexPath.row == 2) {
            //调用自定义分享
            BFShareView *share = [BFShareView shareView];
            share.delegate = self;
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            [window addSubview:share];
        }
    }else {
        //BFSettingList *list = self.mutableArray[indexPath.row];
        PTStepViewController *ptVC= [[PTStepViewController alloc] init];
        ptVC.url = [NET_URL stringByAppendingPathComponent:@"/apphtml/jifen/about.html"];
        [self.navigationController pushViewController:ptVC animated:YES];
//        BFAboutController *aboutVC = [[BFAboutController alloc] init];
//        aboutVC.ID = @"关于我们";
//        aboutVC.url = [NET_URL stringByAppendingPathComponent:@"apphtml/jifen/about.html"];
//        [self.navigationController pushViewController:aboutVC animated:YES];
        
    }
}

#pragma mark -- 音效按钮开关
- (void)soundSwitch:(UISwitch *)sender {
    if (sender.on) {
        [BFUserDefaluts modifySwitchInfo:@1];
    }else {
        [BFUserDefaluts modifySwitchInfo:@0];
    }
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
    
    if (shareType == SSDKPlatformTypeSinaWeibo) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"缤纷世家,让每一次购物都能带来惊喜,让每次分享都能带来喜悦https://itunes.apple.com/cn/app/bin-fen-shi-jia/id1131613819?mt=8"
                                         images:@[[UIImage imageNamed:@"icon"]] //传入要分享的图片
                                            url:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/bin-fen-shi-jia/id1131613819?mt=8"]]
                                          title:@"缤纷世家,让每一次购物都能带来惊喜,让每次分享都能带来喜悦"
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

    }else {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"缤纷世家,让每一次购物都能带来惊喜,让每次分享都能带来喜悦"
                                         images:@[[UIImage imageNamed:@"icon"]] //传入要分享的图片
                                            url:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/bin-fen-shi-jia/id1131613819?mt=8"]]
                                          title:@"缤纷世家,让每一次购物都能带来惊喜,让每次分享都能带来喜悦"
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
//                [BFProgressHUD MBProgressFromView:self.view rightLabelText: @"分享成功"];
//                
//            }else if (state == SSResponseStateFail) {
//                [BFProgressHUD MBProgressFromView:self.view wrongLabelText: @"分享失败"];
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
//                [BFProgressHUD MBProgressFromView:self.view rightLabelText: @"分享成功"];
//                
//            }else if (state == SSResponseStateFail) {
//                //[self hideShareView];
//                [BFProgressHUD MBProgressFromView:self.view wrongLabelText: @"分享失败"];
//                NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
//            }else if (state == SSResponseStateCancel) {
//                //[self hideShareView];
//                //[BFProgressHUD MBProgressOnlyWithLabelText: @"分享失败"];
//            }
//        }];
//        
//    }
}




#pragma mark --BFCustomerServiceViewDelegate
- (void)clickToChooseCustomerServiceWithType:(BFCustomerServiceViewButtonType)type {
    switch (type) {
        case BFCustomerServiceViewButtonTypeTelephone:{
            BFLog(@"点击电话客服");
            UIAlertController *alertC = [UIAlertController alertWithControllerTitle:nil controllerMessage:nil preferredStyle:UIAlertControllerStyleActionSheet actionTitle:@"020-38875719" style:UIAlertActionStyleDefault handler:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://020-38875719"]]];
            }];
            [self presentViewController:alertC animated:YES completion:nil];

            
            break;
        }
        case BFCustomerServiceViewButtonTypeWechat:
            BFLog(@"点击微信客服");
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"暂不支持，尽请期待"];
            break;
            
    }
}


#pragma mark -- delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"    售后服务";
    }else if (section == 1) {
        return @"    个人设置";
    }else if (section == 2) {
        return @"    关于APP";
    }else {
        return @"    关于缤纷";
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0;
}




- (void)exit {
    [BFProgressHUD MBProgressFromWindowWithLabelText:@"退出登录" dispatch_get_main_queue:^{
        [BFUserDefaluts removeUserInfo];
        [BFNotificationCenter postNotificationName:@"logout" object:nil];
        UITabBarController *tabBar = [self.tabBarController viewControllers][1];
        tabBar.tabBarItem.badgeValue = nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];

    BFLog(@"点击退出");
}





#pragma mark --分割线到头
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
