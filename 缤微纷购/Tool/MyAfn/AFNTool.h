//
//  AFNTool.h
//  Backpacking
//
//  Created by lanou on 15/8/1.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIViewController+HUD.h"


@interface AFNTool : NSObject

/*检测网络状态*/
+ (void) netWorkstatusViewController:(UIViewController *)viewController;

/*判断网络*/
- (BOOL)isNetWork;

/*JSON方式获取数据*/
- (void)JSONDataWithUrl:(NSString *)url ViewController:(UIViewController *)viewController success:(void (^)(id json))success fail:(void (^)())fail;


///*XML方式获取数据*/
//- (void)XMLDataWithUrl:(NSString *)urlStr viewController:(UIViewController *)viewController success:(void(^)(id xml))success fail:(void (^)())fail;

/*post提交json数据*/
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;

@end
