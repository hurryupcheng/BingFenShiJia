//
//  BFSosoModel.m
//  缤微纷购
//
//  Created by 郑洋 on 16/5/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFSosoModel.h"

@implementation BFSosoModel

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    return propertyName;
}

- (NSMutableArray *)IDArr{
    if (!_IDArr) {
        _IDArr = [NSMutableArray array];
    }
    return _IDArr;
}

- (NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

@end

@implementation BFSosoSubModel
- (NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

@end

@implementation BFSosoSubOtherModel

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"shopID"]) {
        propertyName = @"id";
    }
    if ([propertyName isEqualToString:@"choose"]) {
        propertyName = @"size";
    }
    return propertyName;
}

- (NSMutableArray *)shopIDarray{
    if (!_shopIDarray) {
        _shopIDarray = [NSMutableArray array];
    }
    return _shopIDarray;
}

@end