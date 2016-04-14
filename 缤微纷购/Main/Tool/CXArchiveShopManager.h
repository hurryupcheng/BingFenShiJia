//
//  CXArchiveShopManager.h
//  2016_Project_TextDemo
//
//  Created by daohe on 16/3/16.
//  Copyright (c) 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFStorage;

#define SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)sharedInstance;

#define SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)sharedInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

@interface CXArchiveShopManager : UIView

SYNTHESIZE_SINGLETON_FOR_HEADER(CXArchiveShopManager)
//初始化
-(void)initWithUserID:(NSString *)userId ShopItem:(BFStorage *)item;
//数据存入 -> 根据item添加
-(void)startArchiveShop;
//数据存入 -> 根据商品id添加(购物车添加)
-(void)shoppingCartChangeNumberWithShopID:(NSString *)shopID ctrl:(BOOL)ctrl;
//数据查询
-(BFStorage *)screachDataSourceWithItem:(NSString *)shopID;
-(NSArray *)screachDataSourceWithMyShop;
//删除当前用户一个商品信息
-(void)removeItemKeyWithOneItem:(NSString *)shopID;
//删除某个userID所有数据
-(void)removeItemKeyOneDataSource:(NSString *)userID;
//删除所有数据
-(void)removeAllKeysWithDataSource;

@end
