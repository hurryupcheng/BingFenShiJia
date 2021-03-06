//
//  BFPayoffModel.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/24.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFPayoffModel : NSObject

@property (nonatomic,retain)NSString *name;/*名字*/
@property (nonatomic,retain)NSString *money;/*金额*/
@property (nonatomic,retain)NSString *end_time;/*结束时间*/
@property (nonatomic,retain)NSString *ID;/*id*/
@property (nonatomic,retain)NSString *cr_type;/*优惠券类型 1.现金 2.折扣*/
@property (nonatomic,retain)NSString *discount;/*折扣*/
@end
