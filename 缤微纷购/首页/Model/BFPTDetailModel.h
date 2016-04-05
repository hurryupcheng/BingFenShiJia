//
//  BFPTDetailModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/2.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFCarouselList;
@interface BFPTDetailModel : NSObject
/**id*/
@property (nonatomic, strong) NSString *shopID;
/**标题*/
@property (nonatomic, strong) NSString *title;
/**分类id*/
@property (nonatomic, strong) NSString *cate_id;
/**图片*/
@property (nonatomic, strong) NSString *img;
/**价格*/
@property (nonatomic, strong) NSString *price;
/**up*/
@property (nonatomic, strong) NSString *up;
/**详细介绍*/
@property (nonatomic, strong) NSString *intro;
/**拼团人数*/
@property (nonatomic, strong) NSString *team_num;
/**拼团价格*/
@property (nonatomic, strong) NSString *team_price;
/**拼团折扣*/
@property (nonatomic, strong) NSString *team_discount;
/**拼团开始时间*/
@property (nonatomic, strong) NSString *team_timestart;
/**拼团结束时间*/
@property (nonatomic, strong) NSString *team_timeend;
/**team_cycle*/
@property (nonatomic, strong) NSString *team_cycle;
/**webview参数*/
@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) NSInteger numbers;
@property (nonatomic,retain)NSString *guige;

/**轮播图数组*/
@property (nonatomic, strong) NSArray <BFCarouselList *>*imgs;
@end



@interface BFCarouselList : NSObject
/**图片地址*/
@property (nonatomic, strong) NSString *url;
@end
