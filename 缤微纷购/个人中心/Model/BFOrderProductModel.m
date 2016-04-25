//
//  BFOrderProductModel.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/16.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFOrderProductModel.h"

@implementation BFOrderProductModel
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    return propertyName;
}
@end
