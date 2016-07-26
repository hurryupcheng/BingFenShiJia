//
//  BFSettingGroup.h
//  缤微纷购
//
//  Created by 程召华 on 16/7/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFSettingGroup : NSObject
/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *header;
/**
 *  尾部标题
 */
@property (nonatomic, copy) NSString *footer;
/**
 *  存放着这组所有行的模型数据(这个数组中都是MJSettingItem对象)
 */
@property (nonatomic, strong) NSArray *items;
@end
