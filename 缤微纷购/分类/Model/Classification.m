//
//  Classification.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "Classification.h"

@implementation Classification

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
     self = [super init];
    if (self) {
      
        self.ID = dic[@"id"];
        self.name = dic[@"name"];
        self.pid = dic[@"pid"];
        
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *name = [NSMutableArray arrayWithCapacity:0];
        
        NSArray * sub_cates = dic[@"sub_cates"];
        if ([dic[@"sub_cates"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary * subDic in sub_cates) {
                ClassificationSubModel * model = [[ClassificationSubModel alloc]initWithDictionary:subDic];
                
                [array addObject:model];
                [arr addObject:model.ID];
                [name addObject:model.name];
            }
            [array addObject:@""];
            self.sub_catesArr = [array copy];
            self.idArr = [arr copy];
            self.nameArr = [name copy];
        }
        
        
    }
    return self;
}

@end
@implementation ClassificationSubModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        
        self.ID = dic[@"id"];
        self.imageUrl = dic[@"img"];
        self.name = dic[@"name"];
        self.pid = dic[@"pid"];

    }
    return self;
}

@end

