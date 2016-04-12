//
//  XQModel.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "XQModel.h"

@implementation XQModel

@end

@implementation XQSubModel

@end

@implementation XQSubOtherModel
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    return propertyName;
}
@end