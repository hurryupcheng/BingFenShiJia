//
//  BFURLEncodeAndDecode.h
//  缤微纷购
//
//  Created by 程召华 on 16/5/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFURLEncodeAndDecode : NSObject
/**
 *  urlEncode
 *
 *  @param input 传入的字符串
 *
 *  @return 返回字符串
 */
+ (NSString *)encodeToPercentEscapeString:(NSString *)input;


/**
 *  urlDecode
 *
 *  @param input 传入的字符串
 *
 *  @return 返回字符串
 */
+ (NSString *)decodeFromPercentEscapeString:(NSString *)input;
@end
