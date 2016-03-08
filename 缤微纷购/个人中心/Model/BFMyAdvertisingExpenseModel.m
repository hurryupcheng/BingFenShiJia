//
//  BFMyAdvertisingExpenseModel.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyAdvertisingExpenseModel.h"
#import "BFUserModel.h"

@implementation BFMyAdvertisingExpenseModel
+ (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] parsingJsonWithDictionary:dict];
}

- (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray * userArr = [NSMutableArray array];
        for (NSDictionary * __dic in self.groups) {
            BFUserModel *user = [BFUserModel parsingJsonWithDictionary:__dic];
            [userArr addObject:user];
        }
        self.groups = userArr;
    }
    return self;
}

@end
