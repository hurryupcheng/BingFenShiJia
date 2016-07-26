//
//  BFSettingItem.m
//  缤微纷购
//
//  Created by 程召华 on 16/7/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFSettingItem.h"

@implementation BFSettingItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    BFSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}


+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}
@end
