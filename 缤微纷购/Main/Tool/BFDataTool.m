//
//  BFDataTool.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/2.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFDataTool.h"
#import "PTModel.h"

@implementation BFDataTool
+ (NSArray *)getPTArrayWithDic:(NSDictionary *)dic{
    NSArray *array = dic[@"item"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        PTModel *model = [PTModel new];
        model.ID = dictionary[@"id"];
        model.isteam = dictionary[@"isteam"];
        model.title = dictionary[@"title"];
        model.img = dictionary[@"img"];
        model.intro = dictionary[@"intro"];
        model.team_price = dictionary[@"team_price"];
        model.team_num = dictionary[@"team_num"];
        model.team_discount = dictionary[@"team_discount"];
        [mutableArray addObject:model];
    }
    return [mutableArray copy];
}
@end
