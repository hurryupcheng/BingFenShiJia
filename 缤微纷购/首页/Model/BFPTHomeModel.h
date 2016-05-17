//
//  BFPTHomeModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/5/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFPTBannerList,BFPTItemList;

@interface BFPTHomeModel : NSObject
/**服务器当前时间*/
@property (nonatomic, assign) NSInteger nowtime;
/**轮播图数据*/
@property (nonatomic, strong) NSArray <BFPTBannerList *> *ads;
/**商品数组*/
@property (nonatomic, strong) NSArray <BFPTItemList *> *item;
@end


@interface BFPTBannerList : NSObject

/**url*/
@property (nonatomic, strong) NSString *url;
/**content*/
@property (nonatomic, strong) NSString *content;

@end

@interface BFPTItemList : NSObject

/**id*/
@property (nonatomic, strong) NSString *ID;
/**是不是拼团商品*/
@property (nonatomic, strong) NSString *isteam;
/**标题*/
@property (nonatomic, strong) NSString *title;
/**商品普片*/
@property (nonatomic, strong) NSString *img;
/**商品介绍*/
@property (nonatomic, strong) NSString *intro;
/**拼团价格*/
@property (nonatomic, strong) NSString *team_price;
/**开团人数*/
@property (nonatomic, strong) NSString *team_num;
/**折扣*/
@property (nonatomic, strong) NSString *team_discount;
/**商品上架*/
@property (nonatomic, strong) NSString *starttime;
/**商品下架*/
@property (nonatomic, strong) NSString *endtime;
/**商品库存*/
@property (nonatomic, strong) NSString *team_stock;
/**商品可以购买开始时间*/
@property (nonatomic, strong) NSString *team_timestart;
/**商品结束购买时间*/
@property (nonatomic, strong) NSString *team_timeend;
/**服务器当前时间*/
@property (nonatomic, assign) NSInteger nowtime;

@end