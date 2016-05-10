//
//  BFGenerateOrderModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/5/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFThirdPartyPayment;
@interface BFGenerateOrderModel : NSObject
/**状态*/
@property (nonatomic, strong) NSString *status;
/**订单号*/
@property (nonatomic, strong) NSString *orderid;
/**下单时间*/
@property (nonatomic, strong) NSString *addtime;
/**返回信息*/
@property (nonatomic, strong) NSString *msg;
/**第三方支付信息*/
@property (nonatomic, strong) BFThirdPartyPayment *re_sign;
@end

@interface BFThirdPartyPayment : NSObject
/**appid*/
@property (nonatomic, strong) NSString *appid;
/**noncestr*/
@property (nonatomic, strong) NSString *noncestr;
/**package*/
@property (nonatomic, strong) NSString *package;
/**partnerid*/
@property (nonatomic, strong) NSString *partnerid;
/**prepayid*/
@property (nonatomic, strong) NSString *prepayid;
/**timestamp*/
@property (nonatomic, assign) NSUInteger timestamp;
/**sign*/
@property (nonatomic, strong) NSString *sign;
@end
