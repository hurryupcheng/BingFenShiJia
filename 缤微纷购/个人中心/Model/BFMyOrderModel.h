//
//  BFMyOrderModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFMyOrderModel : NSObject
/**订单编号*/
@property (nonatomic, strong) NSString *orderId;
/**订单时间*/
@property (nonatomic, strong) NSString *add_time;
/**商品价格*/
@property (nonatomic, strong) NSString *goods_sumPrice;
/**订单价格*/
@property (nonatomic, strong) NSString *order_sumPrice;
/**图片地址*/
@property (nonatomic, strong) NSString *img;
/**订单状态*/
@property (nonatomic, strong) NSString *status_w;
/**运费价格*/
@property (nonatomic, strong) NSString *freeprice;
/**运费类型*/
@property (nonatomic, strong) NSString *freetype;
@end
