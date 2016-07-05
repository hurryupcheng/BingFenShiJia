//
//  BFGroupOrderDetailView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFGroupOrderDetailModel.h"

typedef enum {
    BFGroupOrderDetailViewButtonTypePay,//立即支付按钮-status=1显示
    BFGroupOrderDetailViewButtonTypeGroup, //查看团详情
    BFGroupOrderDetailViewButtonTypeLogistics//查看物流  已发货状态和已完成状态显示
}BFGroupOrderDetailViewButtonType;


@protocol BFGroupOrderDetailViewDelegate <NSObject>

- (void)clickToViewWithButtonType:(BFGroupOrderDetailViewButtonType)buttonType;

@end

@interface BFGroupOrderDetailView : UIView

/**团订单详情模型*/
@property (nonatomic, strong) BFGroupOrderDetailModel *model;
/**代理*/
@property (nonatomic, weak) id<BFGroupOrderDetailViewDelegate>delegate;
/**支付按钮  status=1是显示*/
@property (nonatomic, strong) UIButton *payButton;
/**查看物流  已发货状态和已完成状态显示*/
@property (nonatomic, strong) UIButton *logisticsButton;
@end
