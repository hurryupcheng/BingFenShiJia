//
//  BFGroupDetailTabbar.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/30.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFGroupDetailModel.h"
typedef enum {
    /**回到首页*/
    BFGroupDetailTabbarButtonTypeHome,
    /**分享*/
    BFGroupDetailTabbarButtonTypeShare,
    /**团长 立即支付，才显示*/
    BFGroupDetailTabbarButtonTypePay,
    /**团员 立即支付参团*/
    BFGroupDetailTabbarButtonTypePayToJoin,
    /**团员 也要参团*/
    BFGroupDetailTabbarButtonTypeJoin,
    /**组团成功才显示*/
    BFGroupDetailTabbarButtonTypeSuccess,
    /**组团失败才显示*/
    BFGroupDetailTabbarButtonTypeFail,
    /**已付款，缺少人*/
    BFGroupDetailTabbarButtonTypeLack
}BFGroupDetailTabbarButtonType;

@protocol BFGroupDetailTabbarDelegate <NSObject>

- (void)clickEventWithType:(BFGroupDetailTabbarButtonType)type;

@end

@interface BFGroupDetailTabbar : UIView
/**代理*/
@property (nonatomic, weak) id<BFGroupDetailTabbarDelegate>delegate;
/**BFGroupDetailModel*/
@property (nonatomic, strong) BFGroupDetailModel *model;
@end
