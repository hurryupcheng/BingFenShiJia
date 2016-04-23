//
//  UIAlertController+Extension.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "UIAlertController+Extension.h"

@implementation UIAlertController (Extension)
+ (UIAlertController *)alertWithControllerTitle:(NSString *)controllerTitle controllerMessage:(NSString *)controllerMessage preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitle:(NSString *)actionTitle style:(UIAlertActionStyle)style handler:(void (^)())handler{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:controllerTitle message:controllerMessage preferredStyle:preferredStyle];
    //添加取消按钮
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击");
    }];
    //添加电话按钮
    UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:actionTitle style:style handler:^(UIAlertAction *action) {
        if (handler) {
            handler();
        }
    }];
    [alertC addAction:cancleAction];
    [alertC addAction:phoneAction];
    
    return alertC;
}
@end
