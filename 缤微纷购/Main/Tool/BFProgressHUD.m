//
//  BFProgressHUD.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/3.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFProgressHUD.h"
#import "MBProgressHUD.h"
@implementation BFProgressHUD
+ (id)MBProgressFromWindowWithLabelText:(NSString *)labelText {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        hud.labelText = labelText;
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
            
        });
    });
    return hud;
}


+ (id)MBProgressFromWindowWithLabelText:(NSString *)labelText dispatch_get_main_queue:(void(^)())mainBlock{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        hud.labelText = labelText;
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
            if (mainBlock) {
                mainBlock();
            }
        });
    });
    return hud;
}
+ (id)MBProgressFromView:(UIView *)view wrongLabelText:(NSString *)labelText{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"as_03"]];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        hud.labelText = labelText;
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
            
        });
    });
    return hud;
}

+ (id)MBProgressFromView:(UIView *)view andLabelText:(NSString *)labelText {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        hud.labelText = labelText;
        hud.mode = MBProgressHUDModeText;
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
    });
    return hud;
    
}


+ (id)MBProgressOnlywithLabelText:(NSString *)labelText {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        hud.labelText = labelText;
        hud.mode = MBProgressHUDModeText;
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
        });
    });
    return hud;
}

@end
