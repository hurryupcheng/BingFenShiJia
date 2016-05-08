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

@protocol BFMyAdvertisingExpenseTabbarDelegate <NSObject>

- (void)howToWithdrawCash;

@end


@interface BFMyAdvertisingExpenseTabbar : UIView

/**客户订单模型*/
@property (nonatomic, strong) BFCommissionModel *commissionModel;
/**推荐分成订单模型*/
@property (nonatomic, strong) BFRecommendDividedModel *recommendDividedModel;
/**代理*/
@property (nonatomic, weak) id<BFMyAdvertisingExpenseTabbarDelegate>delegate;
@end
