//
//  BFPTDetailHeaderView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/2.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFPurchaseButton.h"
#import <UIKit/UIKit.h>
#import "BFPTDetailModel.h"
@interface BFPTDetailHeaderView : UIView
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, strong) BFPTDetailModel *detailModel;

@property (nonatomic, strong) BFPurchaseButton *groupPurchaseButton;
@property (nonatomic, strong) BFPurchaseButton *alonePurchaseButton;
@end
