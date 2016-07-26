//
//  BFSettingItem.h
//  缤微纷购
//
//  Created by 程召华 on 16/7/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BFSettingItemOption)();


@interface BFSettingItem : NSObject

/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subtitle;
/**
 *  子标题
 */
@property (nonatomic, strong) UIColor *subtitleColor;


/**
 *  存储数据用的key
 */
//@property (nonatomic, copy) NSString *key;

/**
 *  点击那个cell需要做什么事情
 */
@property (nonatomic, copy) BFSettingItemOption option;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
