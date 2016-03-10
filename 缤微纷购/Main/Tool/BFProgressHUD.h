//
//  BFProgressHUD.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/3.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFProgressHUD : NSObject
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



+ (id)MBProgressFromView:(UIView *)view wrongLabelText:(NSString *)labelText;
@end
