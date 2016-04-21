//
//  XQModel.h
//  缤微纷购
//
//  Created by 郑洋 on 16/2/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XQSubOtherModel;
@class XQSubModel;

@interface XQModel : NSObject
/** 产品page **/
@property (nonatomic,retain)NSString *page_num;
@property (nonatomic,retain)NSArray <XQSubModel *> *items;
@end

@interface XQSubModel : NSObject
@property (nonatomic,retain)NSArray <XQSubOtherModel *> *item;
@end

@interface XQSubOtherModel : NSObject
/** 产品ID **/
@property (nonatomic,retain)NSString *ID;
/** 产品图片 **/
@property (nonatomic,retain)NSString *img;
/** 产品名称 **/
@property (nonatomic,retain)NSString *title;
/** 产品价格 **/
@property (nonatomic,retain)NSString *price;
/** 产品库存 **/
@property (nonatomic,retain)NSString *stock;
/** 产品颜色 **/
@property (nonatomic,retain)NSString *color;
/** 产品规格 **/
@property (nonatomic,retain)NSString *size;

@end


