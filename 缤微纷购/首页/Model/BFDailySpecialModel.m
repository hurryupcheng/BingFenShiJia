//
//  BFDailySpecialModel.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFDailySpecialModel.h"

@implementation BFDailySpecialModel

@end

@implementation BFDailySpecialBannerList

@end

@implementation BFDailySpecialProductList
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    return propertyName;
}
@end