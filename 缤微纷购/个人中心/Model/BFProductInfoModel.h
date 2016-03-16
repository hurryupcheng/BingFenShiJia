//
//  BFProductInfoModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFProductInfoModel : NSObject
/**id*/
@property (nonatomic, strong) NSString *ID;
/**订单号*/
@property (nonatomic, strong) NSString *orderId;
/**添加订单时间*/
@property (nonatomic, strong) NSString *add_time;
/**单价*/
@property (nonatomic, strong) NSString *goods_sumPrice;
/**总价*/
@property (nonatomic, strong) NSString *order_sumPrice;
/**用户名字*/
@property (nonatomic, strong) NSString *address_name;
/**手机号*/
@property (nonatomic, strong) NSString *mobile;
/**具体地址*/
@property (nonatomic, strong) NSString *address;
/**状态*/
@property (nonatomic, strong) NSString *status;
/**物流类型 0.包邮1.平邮2.快递3.ems*/
@property (nonatomic, strong) NSString *freetype;
/**运费*/
@property (nonatomic, strong) NSString *freeprice;

@end
