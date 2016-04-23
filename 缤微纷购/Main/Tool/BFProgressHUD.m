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
/**从最上层窗口弹出只带文字的提示框*/
+ (id)MBProgressOnlyWithLabelText:(NSString *)labelText {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        hud.label.text = labelText;
//        
//        hud.mode = MBProgressHUDModeText;
//        sleep(1);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
//        });
//    });
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = labelText;
    // Move to bottm center.
    //hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:1.5f];
    return hud;
}
/**从view层窗口弹出只带文字的提示框*/
+ (id)MBProgressFromView:(UIView *)view onlyWithLabelText:(NSString *)labelText{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        hud.label.text = labelText;
//
//        hud.mode = MBProgressHUDModeText;
//        sleep(1);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:view animated:YES];
//        });
//    });
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = labelText;
    // Move to bottm center.
    //hud.offset = CGPointMake(0.f, ScreenHeight/2);
    
    [hud hideAnimated:YES afterDelay:1.5f];
    return hud;
}

/**从最上层窗口弹出带图文的提示框*/
+ (id)MBProgressFromWindowWithLabelText:(NSString *)labelText {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        hud.label.text = labelText;
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
            
        });
    });
    return hud;
}
/**从view层窗口弹出带图文的提示框*/
+ (id)MBProgressFromView:(UIView *)view andLabelText:(NSString *)labelText {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        hud.label.text = labelText;
        
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
    });
    return hud;
    
}

+ (id)MBProgressFromView:(UIView *)view WithLabelText:(NSString *)labelText  dispatch_get_global_queue:(void(^)())globalBlock dispatch_get_main_queue:(void(^)())mainBlock {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"Loading...";
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        // Do something useful in the background and update the HUD periodically.
        if (globalBlock) {
            globalBlock();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (mainBlock) {
                mainBlock();
            }
            [hud hideAnimated:YES];
        });
    });

    return hud;
}

/**从最上层窗口弹出带图文的提示框以及有主线程block*/
+ (id)MBProgressFromWindowWithLabelText:(NSString *)labelText dispatch_get_main_queue:(void(^)())mainBlock{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    
    // Set the label text.
    hud.label.text = labelText;
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(1.);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (mainBlock) {
                mainBlock();
            }
            [hud hideAnimated:YES];
        });
    });

    return hud;
}
/**从最view窗口弹出带图文的提示框以及有主线程block*/
+ (id)MBProgressFromView:(UIView *)view LabelText:(NSString *)labelText dispatch_get_main_queue:(void(^)())mainBlock{
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the label text.
    hud.label.text = labelText;
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(1.);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (mainBlock) {
                mainBlock();
            }
            [hud hideAnimated:YES];
        });
    });

    
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        hud.label.text = labelText;
//        //hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"as_03"]];
//        sleep(1);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [MBProgressHUD hideHUDForView:view animated:YES];
//            
//            if (mainBlock) {
//                mainBlock();
//            }
//        });
//    });
    return hud;
}


+ (id)MBProgressFromView:(UIView *)view rightLabelText:(NSString *)labelText{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [UIImage imageNamed:@"mb_success"];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    //hud.square = YES;
    // Optional label text.
    hud.label.text = labelText;
    
    [hud hideAnimated:YES afterDelay:1.5f];
    return hud;
}


+ (id)MBProgressFromView:(UIView *)view wrongLabelText:(NSString *)labelText{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"mb_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    //hud.square = YES;
    // Optional label text.
    hud.label.text = labelText;
    
    [hud hideAnimated:YES afterDelay:1.5f];
    return hud;
}

+ (void)doSomeWorkWithProgress:(UIView *)view {
    
    // This just increases the progress indicator in a loop.
    float progress = 0.0f;
    while (progress < 1.0f) {
        
        progress += 0.03f;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Instead we could have also passed a reference to the HUD
            // to the HUD to myProgressTask as a method parameter.
            [MBProgressHUD HUDForView:view].progress = progress;
        });
        usleep(50000);
    }
}




@end
