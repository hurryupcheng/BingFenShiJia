//
//  BFVIPOrderModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/5/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFVIPOrderList;
@interface BFVIPOrderModel : NSObject
/**已确认佣金*/
@property (nonatomic, strong) NSString *proxy_order_money_confirm;
/**待确认佣金*/
@property (nonatomic, strong) NSString *proxy_order_money_need_confirm;
/**总佣金*/
@property (nonatomic, strong) NSString *proxy_order_money;
/**总页数*/
@property (nonatomic, assign) NSInteger page_num;
/**客户订单数组*/
@property (nonatomic, strong) NSArray<BFVIPOrderList *> *proxy_order;
@end

@interface BFVIPOrderList : NSObject
/**状态*/
@property (nonatomic, strong) NSString *order_status;
/**订单编号*/
@property (nonatomic, strong) NSString *orderId;
/**商品图片*/
@property (nonatomic, strong) NSString *img;
/**订单金额*/
@property (nonatomic, strong) NSString *order_sumPrice;
/**我的佣金*/
@property (nonatomic, strong) NSString *jiner;
/**订单状态*/
@property (nonatomic, strong) NSString *status_w;
/**下单时间*/
@property (nonatomic, strong) NSString *add_time;
/**快递类型 0.包邮 */
@property (nonatomic, strong) NSString *freetype;
/**运费*/
@property (nonatomic, strong) NSString *freeprice;
@end