//
//  BFShoppModel.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFShoppModel.h"

@implementation BFShoppModel

- (id)initWithsetDateDictionary:(NSDictionary *)dic{
    if ([super init]) {
        NSArray *itemArr = [dic valueForKey:@"like_item"];
        
        self.dateArr = [NSMutableArray array];
        self.imgArr = [NSMutableArray array];
        self.IDArr = [NSMutableArray array];
    
        for (NSDictionary *dics in itemArr) {
            BFShoppModel *shoppModel = [[BFShoppModel alloc]init];
            shoppModel.ID = [dics valueForKey:@"id"];
            shoppModel.img = [dics valueForKey:@"img"];
            shoppModel.title = dics[@"title"];
            shoppModel.price = dics[@"price"];
            shoppModel.number = 1;
            [self.dateArr addObject:shoppModel];
            [self.imgArr addObject:shoppModel.img];
            [self.IDArr addObject:shoppModel.ID];
        }
  
    }
    return self;
}

@end
