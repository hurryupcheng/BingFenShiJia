//
//  BFProgressHUD.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/3.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFProgressHUD : NSObject
/**从最view窗口弹出带图文的提示框以及有主线程block的进度条加载的（请求完成才消失）*/
+ (id)MBProgressWithDispatch_get_global_queue:(void(^)())globalBlock dispatch_get_main_queue:(void(^)(MBProgressHUD *hud))mainBlock;
/**从最上层窗口弹出只带文字的提示框（请求完成才消失）*/
+ (id)MBProgressWithLabelText:(NSString *)labelText dispatch_get_main_queue:(void(^)(MBProgressHUD *hud))block;
/**从最上层窗口弹出只带文字的提示框*/
+ (id)MBProgressOnlyWithLabelText:(NSString *)labelText;
/**从view层窗口弹出只带文字的提示框*/
+ (id)MBProgressFromView:(UIView *)view onlyWithLabelText:(NSString *)labelText;
/**从最上层窗口弹出带图文的提示框*/
+ (id)MBProgressFromWindowWithLabelText:(NSString *)labelText;
/**从view层窗口弹出带图文的提示框*/
+ (id)MBProgressFromView:(UIView *)view andLabelText:(NSString *)labelText;
/**从最上层窗口弹出带图文的提示框以及有主线程block*/
+ (id)MBProgressFromWindowWithLabelText:(NSString *)labelText dispatch_get_main_queue:(void(^)())mainBlock;
/**从最view窗口弹出带图文的提示框以及有主线程block*/
+ (id)MBProgressFromView:(UIView *)view LabelText:(NSString *)labelText dispatch_get_main_queue:(void(^)())mainBlock;
/**从最view窗口弹出带图文的提示框以及有主线程block的进度条加载的*/
+ (id)MBProgressFromView:(UIView *)view WithLabelText:(NSString *)labelText  dispatch_get_global_queue:(void(^)())globalBlock dispatch_get_main_queue:(void(^)())mainBlock;
/**进度条进度*/
+ (void)doSomeWorkWithProgress:(UIView *)view;
/**成功返回*/
+ (id)MBProgressFromView:(UIView *)view wrongLabelText:(NSString *)labelText;
/**失败返回*/
+ (id)MBProgressFromView:(UIView *)view rightLabelText:(NSString *)labelText;

@end
