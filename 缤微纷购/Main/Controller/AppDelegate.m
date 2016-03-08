//
//  AppDelegate.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "RootViewController.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "DWTableViewController.h"
#import "BFNavigationController.h"
@interface AppDelegate ()<CLLocationManagerDelegate>
/**定位管理*/
@property (nonatomic, strong) CLLocationManager * manager;
/**记录上一次的定位状态*/
@property (nonatomic, assign) NSInteger lastStatus;

@property (nonatomic, strong) NSString *city;
@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.proportionX = kScreenWidth/375;
    self.proportionY = kScreenHeight/667;
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    self.window.rootViewController = [[RootViewController alloc]init];
    
    
    //开始监听网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    return YES;
    
    
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
        //                [self.mgr requestWhenInUseAuthorization];
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
        self.city = place.locality;
        BFLog(@"chengshi%@",place.locality);
        [[NSUserDefaults standardUserDefaults] setObject:place.locality forKey:@"currentCity"];

    }];
    
    
}

@end
