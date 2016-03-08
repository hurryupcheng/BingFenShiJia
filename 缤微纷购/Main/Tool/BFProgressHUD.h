//
//  BFProgressHUD.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/3.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFProgressHUD : NSObject
+ (id)MBProgressFromWindowWithLabelText:(NSString *)labelText;


+ (id)MBProgressOnlywithLabelText:(NSString *)labelText;

+ (id)MBProgressFromWindowWithLabelText:(NSString *)labelText dispatch_get_main_queue:(void(^)())mainBlock;

+ (id)MBProgressFromView:(UIView *)view andLabelText:(NSString *)labelText;

+ (id)MBProgressFromView:(UIView *)view wrongLabelText:(NSString *)labelText;
@end
