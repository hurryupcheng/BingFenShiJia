//
//  BFPayoffModel.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/24.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPayoffModel.h"

@implementation BFPayoffModel

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    if ([propertyName isEqualToString:@""]) {
        propertyName = @"id";
    }
    return propertyName;
}
@end
