//
//  BFSettingArrowItem.m
//  缤微纷购
//
//  Created by 程召华 on 16/7/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFSettingArrowItem.h"

@implementation BFSettingArrowItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    BFSettingArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}
@end
