//
//  BFAddressModel.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAddressModel.h"

@implementation BFAddressModel
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    if ([propertyName isEqualToString:@"defaultAddress"]) {
        propertyName = @"default";
    }
    return propertyName;
}

@end
