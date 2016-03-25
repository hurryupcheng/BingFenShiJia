//
//  BFScoreModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFScoreModel : NSObject
/**使用时间*/
@property (nonatomic, strong) NSString *add_time;
/**积分*/
@property (nonatomic, strong) NSString *score;
/**订单号*/
@property (nonatomic, strong) NSString *orderId;
/**说明*/
@property (nonatomic, strong) NSString *action;

@end
