//
//  BFURLEncodeAndDecode.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFURLEncodeAndDecode.h"

@implementation BFURLEncodeAndDecode

+ (NSString *)encodeToPercentEscapeString:(NSString *)input
{
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, /* allocator */(__bridge CFStringRef)input,NULL, /* charactersToLeaveUnescaped */(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);

    return outputStr;
}

+ (NSString *)decodeFromPercentEscapeString:(NSString *)input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,[outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



@end
