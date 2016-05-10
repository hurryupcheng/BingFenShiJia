//
//  BFProductDetialModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFProductDetialList, BFProductDetailSize, BFProductDetailStock, BFProductDetailCarouselList;
@interface BFProductDetialModel : NSObject
/**id*/
@property (nonatomic, strong) NSString *ID;
/**标题*/
@property (nonatomic, strong) NSString *title;
/**分类id*/
@property (nonatomic, strong) NSString *cate_id;
/**说明*/
@property (nonatomic, strong) NSString *intro;
/**详情链接*/
@property (nonatomic, strong) NSString *info;
/**图片*/
@property (nonatomic, strong) NSString *img;
/**轮播图地址*/
@property (nonatomic, strong) NSArray<BFProductDetailCarouselList *> *imgs;
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
/**系统当前时间*/
@property (nonatomic, assign) NSInteger nowtime;
/**颜色*/
@property (nonatomic, strong) NSString *first_color;
/**尺寸*/
@property (nonatomic, strong) NSString *first_size;
/**库存*/
@property (nonatomic, strong) NSString *first_stock;
/**价格*/
@property (nonatomic, strong) NSString *first_price;
/**商品颜色，规格*/
@property (nonatomic, strong) NSArray<BFProductDetialList *> *price_array;
@end

@interface BFProductDetialList : NSObject
/**颜色*/
@property (nonatomic, strong) NSString *yanse;
/**规格*/
@property (nonatomic, strong) NSArray<BFProductDetailSize *> *guige;
@end


@interface BFProductDetailSize : NSObject
/**尺寸*/
@property (nonatomic, strong) NSString *choose;
/**产品库存*/
@property (nonatomic, strong) NSArray<BFProductDetailStock *> *answer;
@end


@interface BFProductDetailStock : NSObject
/**库存*/
@property (nonatomic, assign) NSInteger stock;
/**价格*/
@property (nonatomic, assign) NSInteger price;
/**出厂价*/
@property (nonatomic, assign) NSInteger costs;
@end


@interface BFProductDetailCarouselList : NSObject
/**轮播图链接*/
@property (nonatomic, strong) NSString *url;
@end
