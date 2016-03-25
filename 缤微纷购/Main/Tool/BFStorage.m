//
//  BFStorage.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFStorage.h"

@implementation BFStorage

- (instancetype)initWithTitle:(NSString *)title img:(NSString *)img spec:(NSString *)spec money:(NSString *)price number:(NSInteger)number shopId:(NSString *)shopId{
    if ([super init]) {
        _title = title;
        _img = img;
        _spec = spec;
        _price = price;
        _numbers = number;
        _shopID = shopId;
    }
    return self;
}
// 将对象类型转换为二进制数据类型
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.spec forKey:@"spec"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeInteger:self.numbers forKey:@"number"];
    [aCoder encodeObject:self.shopID forKey:@"shopID"];
};

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.spec = [aDecoder decodeObjectForKey:@"spec"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.numbers = [aDecoder decodeIntegerForKey:@"number"];
        self.shopID = [aDecoder decodeObjectForKey:@"shopID"];
    }
    return self;
}


@end
