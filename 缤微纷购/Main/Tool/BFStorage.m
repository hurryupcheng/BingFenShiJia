//
//  BFStorage.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFStorage.h"

@implementation BFStorage

- (instancetype)initWithTitle:(NSString *)title img:(NSString *)img money:(NSString *)price number:(NSInteger)number shopId:(NSString *)shopId stock:(NSString *)stock choose:(NSString *)choose color:(NSString *)color{
    if ([super init]) {
        _title = title;
        _img = img;
        _price = price;
        _numbers = number;
        _shopID = shopId;
        _stock = stock;
        _choose = choose;
        _color = color;
    }
    return self;
}
// 将对象类型转换为二进制数据类型
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeInteger:self.numbers forKey:@"number"];
    [aCoder encodeObject:self.shopID forKey:@"shopID"];
    [aCoder encodeObject:self.stock forKey:@"stock"];
    [aCoder encodeObject:self.choose forKey:@"choose"];
    [aCoder encodeObject:self.color forKey:@"color"];
};

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.numbers = [aDecoder decodeIntegerForKey:@"number"];
        self.shopID = [aDecoder decodeObjectForKey:@"shopID"];
        self.stock = [aDecoder decodeObjectForKey:@"stock"];
        self.choose = [aDecoder decodeObjectForKey:@"choose"];
        self.color = [aDecoder decodeObjectForKey:@"color"];
    }
    return self;
}


@end
