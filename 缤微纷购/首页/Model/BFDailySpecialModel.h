//
//  BFDailySpecialModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFDailySpecialBannerList,BFDailySpecialProductList;
@interface BFDailySpecialModel : NSObject
/**轮播数组*/
@property (nonatomic, strong) NSArray<BFDailySpecialBannerList *> *ads;
/**抢购数组*/
@property (nonatomic, strong) NSArray<BFDailySpecialProductList *> *item;
@end

@interface BFDailySpecialBannerList : NSObject
/**抢购数组*/
@property (nonatomic, strong) NSString *url;
/**轮播图地址*/
@property (nonatomic, strong) NSString *content;
/**类型*/
@property (nonatomic, strong) NSString *id_type;
@end

@interface BFDailySpecialProductList : NSObject
/**ID*/
@property (nonatomic, strong) NSString *ID;
/**判断0.没开始/1.进行中/2.过期*/
@property (nonatomic, strong) NSString *seckill_type;
/**地址*/
@property (nonatomic, strong) NSString *img;
/**标题*/
@property (nonatomic, strong) NSString *title;
/**现价格*/
@property (nonatomic, strong) NSString *price;
/**原价格*/
@property (nonatomic, strong) NSString *yprice;
/**商品货号*/
@property (nonatomic, strong) NSString *goods_sn;
/**商品品牌号*/
@property (nonatomic, strong) NSString *brand;
/**类型id*/
@property (nonatomic, strong) NSString *cate_id;
/**颜色*/
@property (nonatomic, strong) NSString *color;
/**尺寸*/
@property (nonatomic, strong) NSString *size;
/**开始时间*/
@property (nonatomic, assign) NSInteger special_starttime;
/**结束时间*/
@property (nonatomic, assign) NSInteger special_endtime;
/**服务器当前时间*/
@property (nonatomic, assign) NSInteger nowtime;
/**价格*/
@property (nonatomic, assign) NSInteger thisprice;
/**库存*/
@property (nonatomic, assign) NSInteger stock;
@end