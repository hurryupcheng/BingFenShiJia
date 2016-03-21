//
//  BFLogisticsModel.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFLogisticsModel.h"

@implementation BFLogisticsModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"item" : [ProductList class]};
}

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    return propertyName;
}
@end

@implementation ProductList



@end