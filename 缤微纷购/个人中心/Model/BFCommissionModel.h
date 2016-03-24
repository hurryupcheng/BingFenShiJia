//
//  BFCommissionModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/24.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFCommissionModel : NSObject
/**已确认佣金*/
@property (nonatomic, strong) NSString *proxy_order_money_confirm;
/**待确认佣金*/
@property (nonatomic, strong) NSString *proxy_order_money_need_confirm;
/**总佣金*/
@property (nonatomic, strong) NSString *proxy_order_money;
@end
