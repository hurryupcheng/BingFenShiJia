//
//  BFPTDetailHeaderView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/2.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFPTStep.h"
#import "BFPurchaseButton.h"
#import <UIKit/UIKit.h>
#import "BFPTDetailModel.h"


@protocol BFPTDetailHeaderViewDelegate <NSObject>
/**个人*/
- (void)gotoAlonePurchase;
/**拼团*/
- (void)gotoGroupPurchaseButton;
@end

@interface BFPTDetailHeaderView : UIView
/**代理*/
@property (nonatomic, weak) id<BFPTDetailHeaderViewDelegate>delegate;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, strong) BFPTDetailModel *detailModel;

@property (nonatomic, strong) BFPTStep *step;

@end
