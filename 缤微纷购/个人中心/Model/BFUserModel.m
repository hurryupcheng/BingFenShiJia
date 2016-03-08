//
//  BFUserModel.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFUserModel.h"

@implementation BFUserModel
+ (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] parsingJsonWithDictionary:dict];
}

- (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
