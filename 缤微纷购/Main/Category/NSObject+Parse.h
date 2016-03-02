//
//  NSObject+Parse.h
//  BaseProject
//
//  Created by 程召华 on 15/11/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Parse)
/** 对MJExtension的封装，自动判断参数类型。来解析 */
+(id)parse:(id)responseObj;
@end
