//
//  BFGroupDetailModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/30.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemModel, TeamList;
@interface BFGroupDetailModel : NSObject
/**产品模型*/
@property (nonatomic, strong) ItemModel *item;
/**产品模型*/
@property (nonatomic, strong) NSArray<TeamList *> *thisteam;
/**状态 1组团成功 2组团失败 0 根据xinxi判断*/
@property (nonatomic, strong) NSString *status;
/**差几人*/
@property (nonatomic, assign) NSInteger havenum;
/**判断 1.立即支付 2.立即支付参团 3.还差几个组团成功 else.我也要参团*/
@property (nonatomic, strong) NSString *xinxi;
/**活动结束时间*/
@property (nonatomic, strong) NSString *endtime;
/**活动结束时间*/
@property (nonatomic, strong) NSString *nowtime;
@end

@interface ItemModel : NSObject
/**产品ID*/
@property (nonatomic, strong) NSString *ID;
/**产品图片地址*/
@property (nonatomic, strong) NSString *img;
/**产品标题*/
@property (nonatomic, strong) NSString *title;
/**产品价格*/
@property (nonatomic, strong) NSString *team_price;
/**拼团人数*/
@property (nonatomic, strong) NSString *team_num;
/**拼团倒计时*/
@property (nonatomic, strong) NSString *team_cycle;
@end

@interface TeamList : NSObject
/**用户头像*/
@property (nonatomic, strong) NSString *user_icon;
/**用户昵称*/
@property (nonatomic, strong) NSString *nickname;
/**参团时间*/
@property (nonatomic, strong) NSString *addtime;
@end
