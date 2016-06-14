//
//  UIAlertController+Extension.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extension)
/**
 *  UIAlertController扩展方法
 *
 *  @param controllerTitle   弹出框标题
 *  @param controllerMessage 弹出框信息提示
 *  @param preferredStyle    弹出框类型
 *  @param actionTitle       确定按钮的标题
 *  @param style             确定按钮的类型
 *  @param handler           block内容
 *
 *  @return UIAlertController
 */
+ (UIAlertController *)alertWithControllerTitle:(NSString *)controllerTitle controllerMessage:(NSString *)controllerMessage preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitle:(NSString *)actionTitle style:(UIAlertActionStyle)style handler:(void (^)())handler;


/**
 *  UIAlertController扩展方法升级
 *
 *  @param controllerTitle   弹出框标题
 *  @param controllerMessage 弹出框信息提示
 *  @param preferredStyle    弹出框类型
 *  @param cancleTitle       取消按钮的标题
 *  @param actionTitle       确定按钮的标题
 *  @param style             确定按钮的类型
 *  @param handler           block内容
 *
 *  @return UIAlertController
 */
+ (UIAlertController *)alertWithControllerTitle:(NSString *)controllerTitle controllerMessage:(NSString *)controllerMessage preferredStyle:(UIAlertControllerStyle)preferredStyle cancleTitle:(NSString *)cancleTitle  actionTitle:(NSString *)actionTitle style:(UIAlertActionStyle)style handler:(void (^)())handler;
@end
