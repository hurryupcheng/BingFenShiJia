//
//  BFUserInfo.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFUserInfo.h"

@implementation BFUserInfo

MJCodingImplementation

+(NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
        //判断某个属性 所对应的key
        if ([propertyName isEqualToString:@"ID"]) {
            propertyName = @"id";
        }
        return propertyName;
}
@end
