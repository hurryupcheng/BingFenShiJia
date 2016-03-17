//
//  BFStorage.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFStorage.h"

@implementation BFStorage

//MJCodingImplementation

//+(NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
//    //判断某个属性 所对应的key
//    if ([propertyName isEqualToString:@"ID"]) {
//        propertyName = @"id";
//    }
//    return propertyName;
//}

- (instancetype)initWithTitle:(NSString *)title img:(NSString *)img spec:(NSString *)spec money:(NSString *)money number:(NSInteger)number{
    if ([super init]) {
        _title = title;
        _img = img;
        _spec = spec;
        _money = money;
        _numbers = number;
    }
    return self;
}
// 将对象类型转换为二进制数据类型
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.spec forKey:@"spec"];
    [aCoder encodeObject:self.money forKey:@"money"];
    [aCoder encodeInteger:self.numbers forKey:@"number"];
};

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.spec = [aDecoder decodeObjectForKey:@"spec"];
        self.money = [aDecoder decodeObjectForKey:@"money"];
        self.numbers = [aDecoder decodeIntegerForKey:@"number"];
    }
    return self;
}


@end
