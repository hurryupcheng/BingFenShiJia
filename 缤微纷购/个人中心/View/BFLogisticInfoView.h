//
//  BFLogisticInfoView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFProductInfoModel.h"


typedef enum {
    BFLogisticInfoViewButtonTypePay,//付款、
    BFLogisticInfoViewButtonTypeCancleOrder, //取消订单、
    BFLogisticInfoViewButtonTypeApplyRebund,//申请退款、
    BFLogisticInfoViewButtonTypeApplyReturnGoods,//申请退货退款、
    BFLogisticInfoViewButtonTypeCancleReturn,//取消退货退款申请，
    BFLogisticInfoViewButtonTypeConfirmReceipt,//确认收货、
    BFLogisticInfoViewButtonTypeCheckLogistics//查看物流详情、
}BFLogisticInfoViewButtonType;

@class BFLogisticInfoView;
@protocol BFLogisticInfoViewDelegate <NSObject>

- (void)logisticInfoView:(BFLogisticInfoView *)view type:(BFLogisticInfoViewButtonType)type;

@end

@interface BFLogisticInfoView : UIView
/**自定义类方法*/
+ (instancetype)logisticView;
/**BFProductInfoModel模型类*/
@property (nonatomic, strong) BFProductInfoModel *model;
/**代理*/
@property (nonatomic, weak) id<BFLogisticInfoViewDelegate>delegate;
@end
