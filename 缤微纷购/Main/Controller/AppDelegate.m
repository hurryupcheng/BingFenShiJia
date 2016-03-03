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

@interface AppDelegate ()<CLLocationManagerDelegate>
/**定位管理*/
@property (nonatomic, strong) CLLocationManager * manager;
/**定位状态沙盒路径*/
@property (nonatomic, assign) NSInteger lastStatus;

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
    NSLog(@"applicationDidBecomeActive-获取焦点");
    //[[NSUserDefaults standardUserDefaults] objectForKey:@"status"];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    BFLog(@"%ld,,,,%d",(long)self.lastStatus,status);
    if (status != self.lastStatus) {
        BFLog(@"改变了");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
    }
    
    self.lastStatus = status;
    

    //[[NSUserDefaults standardUserDefaults] setObject:@(status) forKey:@"status"];
      // NSLog(@"用户进行交互:::%@",@(status));
}

#pragma mark 程序在某些情况下被终结时会调用这个方法
- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"applicationWillTerminate-被关闭");
}



@end
