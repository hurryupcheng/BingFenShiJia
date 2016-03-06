//
//  BFFunctionButtonView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BFFunctionButtonTypeMyWallet,//我的钱包
    BFFunctionButtonTypeMyOrder,//我的订单
    BFFunctionButtonTypeMyGroupPurchase,//我的拼团
    BFFunctionButtonTypeMyCoupons,//我的优惠券
    BFFunctionButtonTypeMyProFile,//我的资料
    BFFunctionButtonTypeMyPrivilege//我的特权
} BFFunctionButtonType;

@protocol FunctionButtonDelegate <NSObject>

- (void)chooseFunction:(BFFunctionButtonType)type;

@end



@interface BFFunctionButtonView : UIView
@property (nonatomic, weak) id<FunctionButtonDelegate> delegate;
@end
