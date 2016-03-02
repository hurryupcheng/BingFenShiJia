//
//  NSObject+Parse.m
//  BaseProject
//
//  Created by 程召华 on 15/11/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject (Parse)
+(id)parse:(id)responseObj{
    if ([responseObj isKindOfClass:[NSArray class]]) {
        return [self mj_objectArrayWithKeyValuesArray:responseObj];
    }
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:responseObj];
    }
    return  responseObj;
}
@end
