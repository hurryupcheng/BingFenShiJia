//
//  BFRecommendDividedModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/25.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RecommendDividedList;
@interface BFRecommendDividedModel : NSObject
/**已确认金额*/
@property (nonatomic, strong) NSString *proxy_order_money_confirm;
/**recom_data*/
@property (nonatomic, strong) NSArray <RecommendDividedList *> *recom_data;
@end


@interface RecommendDividedList : NSObject
/**推荐时间*/
@property (nonatomic, strong) NSString *addtime;
/**昵称*/
@property (nonatomic, strong) NSString *nickname;
/**头像地址*/
@property (nonatomic, strong) NSString *user_icon;
/**佣金*/
@property (nonatomic, strong) NSString *jiner;

@end