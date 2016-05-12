//
//  BFCustmorOrderModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/5/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFCustomerOrderList;
@interface BFCustmorOrderModel : NSObject
/**已确认佣金*/
@property (nonatomic, strong) NSString *proxy_order_money_confirm;
/**待确认佣金*/
@property (nonatomic, strong) NSString *proxy_order_money_need_confirm;
/**总佣金*/
@property (nonatomic, strong) NSString *proxy_order_money;
/**总页数*/
@property (nonatomic, assign) NSInteger page_num;
/**客户订单数组*/
@property (nonatomic, strong) NSArray<BFCustomerOrderList *> *proxy_order;
@end

@interface BFCustomerOrderList : NSObject

/**头像*/
@property (nonatomic, strong) NSString *user_icon;
/**我的佣金*/
@property (nonatomic, strong) NSString *jiner;
/**下单时间*/
@property (nonatomic, strong) NSString *add_time;
/**昵称*/
@property (nonatomic, strong) NSString *nickname;
@end