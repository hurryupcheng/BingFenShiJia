//
//  BFMyAdvertisingExpenseTabbar.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCommissionModel.h"
#import "BFRecommendDividedModel.h"

@interface BFMyAdvertisingExpenseTabbar : UIView

/**客户订单模型*/
@property (nonatomic, strong) BFCommissionModel *commissionModel;
/**推荐分成订单模型*/
@property (nonatomic, strong) BFRecommendDividedModel *recommendDividedModel;
@end
