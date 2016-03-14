//
//  BFMyGroupPurchaseModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFMyGroupPurchaseModel : NSObject
/**id*/
@property (nonatomic, strong) NSString *ID;
/**开团人数*/
@property (nonatomic, strong) NSString *team_num;
/**是不是团员*/
@property (nonatomic, strong) NSString *isteam;
/**商品图片*/
@property (nonatomic, strong) NSString *img;
/**parent_id*/
@property (nonatomic, strong) NSString *parent_id;
/**tid*/
@property (nonatomic, strong) NSString *tid;
/**团购价格*/
@property (nonatomic, strong) NSString *team_price;
/**商品标题*/
@property (nonatomic, strong) NSString *title;
/**状态*/
@property (nonatomic, strong) NSString *status;
/**价格*/
@property (nonatomic, strong) NSString *price;

@end
