//
//  BFGroupOrderDetailModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFGroupOrderDetailModel : NSObject
/**订单号码*/
@property (nonatomic, strong) NSString *orderid;
/**判断付款状态（1：未付款 2：待发货，3：已发货 4：完成 5：关闭*/
@property (nonatomic, strong) NSString *status;
/**订单付款价格*/
@property (nonatomic, strong) NSString *order_sumPrice;
/**团购单价*/
@property (nonatomic, strong) NSString *team_price;
/**快递方式*/
@property (nonatomic, strong) NSString *userfree;
/**地址*/
@property (nonatomic, strong) NSString *address;
/**收货人名字*/
@property (nonatomic, strong) NSString *address_name;
/**收货人电话*/
@property (nonatomic, strong) NSString *mobile;
/**下单时间*/
@property (nonatomic, strong) NSString *add_time;
/**产品图片*/
@property (nonatomic, strong) NSString *img;
/**产品标题*/
@property (nonatomic, strong) NSString *title;
/**产品数量*/
@property (nonatomic, strong) NSString *quantity;

@end
