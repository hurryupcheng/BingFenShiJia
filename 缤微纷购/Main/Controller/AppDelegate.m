//
//  AppDelegate.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//


#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "payRequsestHandler.h"
#import "WeiboSDK.h"
#import <AlipaySDK/AlipaySDK.h>

#import "Header.h"
#import "RootViewController.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "DWTableViewController.h"
#import "BFNavigationController.h"
#import "DWTableViewController.h"
#define AppKey   @"11ae973b82132"

#define  kWXKey         @"wxfdfc235382c84b7d"
#define  kWXSecret      @"d911c360a8a5ad90a9b5ca1250e35e97"

//#define  kQQKey         @"1104539912"
//#define  kQQSecret      @"eFVgRits2fqf36Jf"
#define  kQQKey         @"1105335960"
#define  kQQSecret      @"KEYgTufBAzAgLcyXhb0"

#define  kSinaKey         @"1177928191"
#define  kSinaSecret      @"090912c73729b5aa7d1405fce0a6c76a"


@interface AppDelegate ()<CLLocationManagerDelegate, WXApiDelegate>
/**定位管理*/
@property (nonatomic, strong) CLLocationManager * manager;
/**记录上一次的定位状态*/
@property (nonatomic, assign) NSInteger lastStatus;

@property (nonatomic, strong) NSString *city;
@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    
    [WXApi registerApp:kWXKey withDescription:@"缤纷"];
    
    [ShareSDK registerApp:AppKey];//字符串api20为您的ShareSDK的AppKey
    

    [ShareSDK connectQQWithQZoneAppKey:kQQKey
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];

    //微信登陆的时候需要初始化

    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:kSinaKey
                                appSecret:kSinaSecret
                              redirectUri:@"http://www.baidu.com"
                              weiboSDKCls:[WeiboSDK class]];
    
//    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:kSinaKey
                               appSecret:kSinaSecret
                             redirectUri:@"http://www.baidu.com"];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:kQQKey
                           appSecret:kQQSecret
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectWeChatWithAppId:kWXKey   //微信APPID
                           appSecret:kWXSecret  //微信APPSecret
                           wechatCls:[WXApi class]];

    
    self.proportionX = kScreenWidth/375;
    self.proportionY = kScreenHeight/667;
    
    
    
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    //获取当前的版本号
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//    //获取上一次的版本号
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastVersion"];
//    if ([currentVersion isEqualToString:lastVersion]) {
        //没有更新版本
        RootViewController *root = [[RootViewController alloc]init];
        self.window.rootViewController = root;
//    }else {
//
//        RootViewController *root = [[RootViewController alloc]init];
//        self.window.rootViewController = root;
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"LastVersion"];
//    }
    
    [self.window makeKeyAndVisible];
    

    
    //开始监听网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    return YES;

    
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    if ([ShareSDK handleOpenURL:url wxDelegate:self]) {
//        return [ShareSDK handleOpenURL:url wxDelegate:self];
//    }else {
//        return [WXApi handleOpenURL:url delegate:self];
//    }
//    
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"-----result = %@",resultDic);
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"+++++result = %@",resultDic);
        }];
    }
    
//    if ([ShareSDK handleOpenURL:url
//              sourceApplication:sourceApplication
//                     annotation:annotation
//                     wxDelegate:self]) {
        return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
//    }else {
//       return  [WXApi handleOpenURL:url delegate:self];
//    }
//    
}

//微信支付完成后的回调
-(void) onResp:(BaseResp*)resp
{
//    NSString *strMsg = [NSString stringWithFormat:@"---errcode:%d", resp.errCode];
//    NSString *strTitle;
//    
//    if([resp isKindOfClass:[SendMessageToWXResp class]])
//    {
//        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
//    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
       // strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                //strMsg = @"支付结果：成功！";
                
                [BFNotificationCenter postNotificationName:@"paySuccess" object:nil];
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                [BFNotificationCenter postNotificationName:@"payFail" object:nil];
                //[BFProgressHUD MBProgressOnlyWithLabelText:@"支付失败"];
                //strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //[alert show];
}






#pragma mark 程序失去焦点的时候调用（不能跟用户进行交互了）
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive-失去焦点");
}

#pragma mark 当应用程序进入后台的时候调用（点击HOME键）
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"applicationDidEnterBackground-进入后台");
    
}

#pragma mark 当应用程序进入前台的时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"applicationWillEnterForeground-进入前台");
}

#pragma mark 当应用程序获取焦点的时候调用
// 获取焦点之后才可以跟用户进行交互
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //获取定位
    [self getAddress];
    NSLog(@"applicationDidBecomeActive-获取焦点");

    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    //CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
//    if (status == kCLAuthorizationStatusDenied) {
//        DWTableViewController *dwVC = [[DWTableViewController alloc]init];
//        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dwVC];
//        [self.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
//    }
    //如果定位状态改变，发送通知
    if (self.city == nil) {
        return;
    }else {
        if (status != self.lastStatus) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
        }
    }
    
    
    self.lastStatus = status;
    
      // NSLog(@"用户进行交互:::%@",@(status));
}

#pragma mark 程序在某些情况下被终结时会调用这个方法
- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"applicationWillTerminate-被关闭");
}

- (void)getAddress{
    self.manager = [[CLLocationManager alloc]init];
    self.manager.delegate = self;
    //用于判断当前是ios7.0还是ios8.0
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        //NSLocationAlwaysUsageDescription   允许在前后台都可以授权
        //        NSLocationWhenInUseUsageDescription   允许在前台授权
        //手动授权
        
        //        主动请求前后台授权
        [self.manager requestAlwaysAuthorization];
        
        //主动请求前台授权
        //[self.mgr requestWhenInUseAuthorization];
    }else {
        [self.manager startUpdatingLocation];
    }
    
}
//判断授权状态
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {

        //开启定位
        [self.manager startUpdatingLocation];
        [self.manager requestAlwaysAuthorization];
        // 定位的精确度
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        //        //每隔一点距离定位一次 （单位：米）
        //        self.mgr.distanceFilter = 10;
    }
    
}
//获取定位的位置信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%@",locations);
    //获取我当前的位置
    CLLocation *location = [locations lastObject];
    
    //停止定位
    [self.manager stopUpdatingLocation];
    //地理反编码
    //创建反编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    BFLog(@"%@,,%@",location,geocoder);
    //调用方法，使用位置反编码对象获取位置信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *place = [placemarks lastObject];
        NSString *city = [place.locality stringByReplacingOccurrencesOfString:@"市" withString:@""];
        self.city = city;
        BFLog(@"chengshi%@",city);
        
        if (city != nil) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:city];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"changeCurrentCity"];
        }
    }];
    
    
}

@end
