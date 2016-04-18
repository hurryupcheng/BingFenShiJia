//
//  BFPanicBuyingModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFPanicBuyingCarouselList;
@interface BFPanicBuyingModel : NSObject
/**id*/
@property (nonatomic, strong) NSString *ID;
/**标题*/
@property (nonatomic, strong) NSString *title;
/**分类id*/
@property (nonatomic, strong) NSString *cate_id;
/**说明*/
@property (nonatomic, strong) NSString *intro;
/**1.开始抢购 ，0.未开始*/
@property (nonatomic, strong) NSString *seckill_type;
/**系统时间*/
@property (nonatomic, assign) NSInteger nowtime;
/**开始时间*/
@property (nonatomic, assign) NSInteger seckill_starttime;
/**结束时间*/
@property (nonatomic, assign) NSInteger seckill_endtime;
/**详情链接*/
@property (nonatomic, strong) NSString *info;
/**图片*/
@property (nonatomic, strong) NSString *img;
/**轮播图地址*/
@property (nonatomic, strong) NSArray<BFPanicBuyingCarouselList *> *imgs;
/**新价格*/
@property (nonatomic, strong) NSString *price;
/**原价格*/
@property (nonatomic, strong) NSString *yprice;
/***/
@property (nonatomic, strong) NSString *up;
/**开始时间*/
@property (nonatomic, strong) NSString *starttime;
/**结束时间*/
@property (nonatomic, strong) NSString *endtime;
/**颜色*/
@property (nonatomic, strong) NSString *first_color;
/**尺寸*/
@property (nonatomic, strong) NSString *first_size;
/**库存*/
@property (nonatomic, strong) NSString *first_stock;
/**价格*/
@property (nonatomic, strong) NSString *first_price;

@end

@interface BFPanicBuyingCarouselList : NSObject
/**轮播图链接*/
@property (nonatomic, strong) NSString *url;
@end
