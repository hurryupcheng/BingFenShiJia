//
//  AFNTool.m
//  Backpacking
//
//  Created by lanou on 15/8/1.
//  Copyright (c) 2015年 lanou. All rights reserved.
//
#import "OMGToast.h"
#import "AFNTool.h"
#import "Reachability.h"

@implementation AFNTool

/*检测网络状态*/
+ (void) netWorkstatusViewController:(UIViewController *)viewController
{
    /*
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    //如果要检查网络状态的变化，必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == -1)
        {
//            [viewController showHint:@"未知错误"];
        }
        else if (status == 0)
        {
            [viewController showHint:@"连接断开"];
            NSLog(@"连接断开");
        }
        else if (status == 1)
        {
            NSLog(@"3G");
        }
        else
        {
            NSLog(@"WiFi");
        }
    }];
}

/*JSON方式获取数据*/
- (void)JSONDataWithUrl:(NSString *)url ViewController:(UIViewController *)viewController success:(void (^)(id json))success fail:(void (^)())fail
{
    
    
    //如果要检查网络状态的变化，必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == -1)
        {
            [viewController showHint:@"未知错误 请检测网络"];
        }
        else if (status == 0)
        {
            [viewController showHint:@"网络异常 请检测网络"];
        }
        else
        {
            [AFNTool netWorkstatusViewController:viewController];
            
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            
            NSDictionary * dic = @{@"format": @"json"};
            
            // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
            [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //            NSLog(@"%@",error);
                if (fail) {
                    fail();
                    [viewController showHint:@"数据异常"];
                }
            }];
        }
    }];
    
}

///*XML方式获取数据*/
//- (void)XMLDataWithUrl:(NSString *)urlStr viewController:(UIViewController *)viewController success:(void(^)(id xml))success fail:(void (^)())fail
//{
//    if( [self isNetWork] == YES ){
//    
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    
//    //返回的数据格式是XML
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    
//        NSDictionary * dict = @{@"format": @"xml"};
//        
//        //网络访问是异步的，回调是主线程的，因此程序员不用管在主线程更新UI的事情
//        [manager GET:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            if (success) {
//                success(responseObject);
//            }
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////            NSLog(@"%@", error);
//            if (fail) {
//                fail();
//                [viewController showHint:@"数据异常"];
//            }  
//        }];
//    }
//    else
//    {
//        [viewController showHint:@"网络异常 请检测网络"];
//    }
//
//}

/*post提交json数据*/
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    
    //如果要检查网络状态的变化，必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == -1)
        {
            [BFProgressHUD MBProgressFromWindowWithLabelText:@"未知错误 请检测网络"];
        }
        else if (status == 0)
        {
            [BFProgressHUD MBProgressFromWindowWithLabelText:@"网络异常 请检测网络"];
        }
        else
        {
            NSLog(@"%@", urlStr);
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            // 设置请求格式
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            // 设置返回格式
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if (success) {
                    
                    if (!responseObject) {
                        NSLog(@"数据为空");
                        return ;
                    }
                    
                    NSError * error = nil;
                    
                    NSData * data = responseObject;
                    
                    //JOSN解析数据
                    id json = [NSJSONSerialization JSONObjectWithData:data
                                                              options:kNilOptions
                                                                error:&error];
                    
                    success(json);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //            NSLog(@"%@", error);
                if (fail) {
                    fail();
                    [BFProgressHUD MBProgressOnlyWithLabelText:@"数据异常"];
                }  
            }];
        }
    }];
    
}

/*判断网络*/
- (BOOL)isNetWork
{
    BOOL isNetWork=NO;
    //通过不断的访问"www.baidu.com"来判定是否有网
    Reachability *reach=[Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:
        {
            NSLog(@"没有网络");
            isNetWork=NO;
            break;}
        case ReachableViaWiFi:
        {
            isNetWork=YES;
            NSLog(@"WIFI,有网");
            break;
        }case ReachableViaWWAN:
        {
            isNetWork=YES;
            NSLog(@"2/3G，有网");
            break;
        }
        default:
            break;
    }
    return isNetWork;
}

@end
