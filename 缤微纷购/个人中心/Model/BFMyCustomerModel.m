//
//  BFMyCustomerModel.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/24.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyCustomerModel.h"

@implementation BFMyCustomerModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"sub_list" : [BFCustomerList class]};
}


@end

@implementation BFCustomerList

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    return propertyName;
}

@end