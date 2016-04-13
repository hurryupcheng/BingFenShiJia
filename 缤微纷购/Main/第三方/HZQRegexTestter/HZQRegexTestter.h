//
//  HZQRegexTestter.h
//  正则表达式验证
//
//  Created by 1 on 16/3/8.
//  Copyright © 2016年 HZQ. All rights reserved.



#import <Foundation/Foundation.h>


@interface HZQRegexTestter : NSObject
/**
 *  判断是不是数字
 */
+ (BOOL)validateIntegerNumber:(NSString *)integerNumber;
/**
 *  判断是不是汉字
 */
+ (BOOL)validateChineseCharacter:(NSString *)chineseCharacter;
/**
 *  判断是不是银行卡号
 */
+ (BOOL)validateBankCardNumber:(NSString *)bankCardNumber;
/**
 *  判断是不是非负的浮点数
 */
+ (BOOL)validateFloatingPoint:(NSString *)floatingPoint;
/**
 *  1.用户名 - 2.密码 （英文、数字都可，且不包含特殊字符
 */
+ (BOOL)validateStrWithRange:(NSString *)range str:(NSString *)str;

/**
 *  真实姓名验证
 * （只能是汉字且10个字内）
 */
+ (BOOL)validateRealName:(NSString *)name;

/**
 *  邮箱验证
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  手机号码验证
 */
+ (BOOL)validatePhone:(NSString *)phone;

/**
 *  身份证号码验证
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;

@end

