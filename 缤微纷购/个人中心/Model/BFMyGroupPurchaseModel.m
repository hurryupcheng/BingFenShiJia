//
//  BFMyGroupPurchaseModel.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyGroupPurchaseModel.h"

@implementation BFMyGroupPurchaseModel
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    return propertyName;
}
@end
