//
//  BFMyCouponsModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFMyCouponsModel : NSObject
/**coupon_id*/
@property (nonatomic, strong) NSString *coupon_id;
/**id*/
@property (nonatomic, strong) NSString *ID;
/**优惠券ID*/
@property (nonatomic, strong) NSString *cr_id;
/**状态*/
@property (nonatomic, strong) NSString *status;
/**是否领取0.未领取1.领取*/
@property (nonatomic, strong) NSString *is_used;
/**领取时间*/
@property (nonatomic, strong) NSString *receive_time;
/**标题*/
@property (nonatomic, strong) NSString *name;
/**类型*/
@property (nonatomic, strong) NSString *cr_type;
/**判断1.是通用2.拼团3.特定*/
@property (nonatomic, strong) NSString *offers_range;
/**优惠金额*/
@property (nonatomic, strong) NSString *money;
/**折扣*/
@property (nonatomic, strong) NSString *discount;
/**cate_id*/
@property (nonatomic, strong) NSString *cate_id;
/**优惠券开始时间*/
@property (nonatomic, strong) NSString *start_time;
/**优惠券结束时间*/
@property (nonatomic, strong) NSString *end_time;
@end
