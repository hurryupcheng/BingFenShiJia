//
//  BFCommissionModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/24.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProxyOrderList;
@interface BFCommissionModel : NSObject
/**已确认佣金*/
@property (nonatomic, strong) NSString *proxy_order_money_confirm;
/**待确认佣金*/
@property (nonatomic, strong) NSString *proxy_order_money_need_confirm;
/**总佣金*/
@property (nonatomic, strong) NSString *proxy_order_money;
/**客户订单数组*/
@property (nonatomic, strong) NSArray<ProxyOrderList *> *proxy_order;
@end


@interface ProxyOrderList : NSObject
/**已确认佣金*/
@property (nonatomic, strong) NSString *orderId;
/**已确认佣金*/
@property (nonatomic, strong) NSString *img;
/**已确认佣金*/
@property (nonatomic, strong) NSString *order_sumPrice;
/**已确认佣金*/
@property (nonatomic, strong) NSString *jiner;
/**已确认佣金*/
@property (nonatomic, strong) NSString *status_w;
/**已确认佣金*/
@property (nonatomic, strong) NSString *add_time;
@end