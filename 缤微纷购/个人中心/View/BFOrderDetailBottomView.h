//
//  BFOrderDetailBottomView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFProductInfoModel.h"

typedef enum {
    BFOrderDetailBottomViewButtonTypePay,//付款、
    BFOrderDetailBottomViewButtonTypeCancleOrder, //取消订单、
    BFOrderDetailBottomViewButtonTypeApplyRebund,//申请退款、
    BFOrderDetailBottomViewButtonTypeApplyReturnGoods,//申请退货退款、
    BFOrderDetailBottomViewButtonTypeCancleReturn,//取消退货退款申请，
    BFOrderDetailBottomViewButtonTypeConfirmReceipt,//确认收货、
    BFOrderDetailBottomViewButtonTypeCheckLogistics//查看物流详情、
}BFOrderDetailBottomViewButtonType;


@protocol BFOrderDetailBottomViewDelegate <NSObject>

- (void)clickToOperateWithType:(BFOrderDetailBottomViewButtonType)type;

@end


@interface BFOrderDetailBottomView : UIView
/**BFProductInfoModel*/
@property (nonatomic, strong) BFProductInfoModel *model;
/**代理*/
@property (nonatomic, weak) id<BFOrderDetailBottomViewDelegate>delegate;
@end
