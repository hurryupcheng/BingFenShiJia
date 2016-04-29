//
//  BFOrderDetailBottomView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFOrderDetailBottomView.h"

@interface BFOrderDetailBottomView()
/**查看物流*/
@property (nonatomic, strong) UIButton *checkLogistics;
/**付款*/
@property (nonatomic, strong) UIButton *pay;
/**取消订单*/
@property (nonatomic, strong) UIButton *cancleOrder;
/**申请退款*/
@property (nonatomic, strong) UIButton *applyRebund;
/**申请退货退款*/
@property (nonatomic, strong) UIButton *applyReturnGoods;
/**取消退货退款申请*/
@property (nonatomic, strong) UIButton *cancleReturn;
/**确认收货*/
@property (nonatomic, strong) UIButton *confirmReceipt;


@end


@implementation BFOrderDetailBottomView



- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xffffff);
        [self setView];
    }
    return self;
}

- (void)setModel:(BFProductInfoModel *)model {
    _model = model;
    if ([model.refund_status isEqualToString:@"0"]) {
        if ([model.status isEqualToString:@"1"]) {
            self.hidden = NO;
            self.pay.hidden = NO;
            self.cancleOrder.hidden = NO;
            self.checkLogistics.hidden = YES;
            self.confirmReceipt.hidden = YES;
        }else if ([model.status isEqualToString:@"2"]){
            self.hidden = NO;
            self.pay.hidden = YES;
            self.cancleOrder.hidden = YES;
            self.checkLogistics.hidden = YES;
            self.confirmReceipt.hidden = NO;
        }else if ([model.status isEqualToString:@"3"]) {
            self.hidden = NO;
            self.pay.hidden = YES;
            self.cancleOrder.hidden = YES;
            self.checkLogistics.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleHeight(140), BF_ScaleHeight(30));
            self.checkLogistics.hidden = NO;
            self.confirmReceipt.hidden = NO;
        }else if ([model.status isEqualToString:@"4"]) {
            self.hidden = NO;
            self.pay.hidden = YES;
            self.cancleOrder.hidden = YES;
            [UIView animateWithDuration:0.5 animations:^{
                self.checkLogistics.frame = CGRectMake(BF_ScaleWidth(80), BF_ScaleHeight(10), BF_ScaleHeight(160), BF_ScaleHeight(30));
                self.confirmReceipt.frame = CGRectMake(BF_ScaleWidth(240), BF_ScaleHeight(25), BF_ScaleHeight(0), BF_ScaleHeight(0));
            }];
            self.checkLogistics.hidden = NO;
            //self.confirmReceipt.hidden = YES;
        } else {
            self.hidden = YES;
        }
    }
    
    
}

- (void)setView {
    self.checkLogistics = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleHeight(140), BF_ScaleHeight(30)) type:BFOrderDetailBottomViewButtonTypeCheckLogistics title:@"查看物流"];
  
    
     self.cancleOrder = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleHeight(140), BF_ScaleHeight(30)) type:BFOrderDetailBottomViewButtonTypeCancleOrder title:@"取消订单"];

    
    self.pay = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(170), BF_ScaleHeight(10), BF_ScaleHeight(140), BF_ScaleHeight(30)) type:BFOrderDetailBottomViewButtonTypePay title:@"支付"];
    
    self.confirmReceipt = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(170), BF_ScaleHeight(10), BF_ScaleHeight(140), BF_ScaleHeight(30)) type:BFOrderDetailBottomViewButtonTypeConfirmReceipt title:@"确认收货"];
    
}

- (UIButton *)setUpButtonWithFrame:(CGRect)frame type:(BFOrderDetailBottomViewButtonType)type title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = frame;
    button.layer.cornerRadius = BF_ScaleFont(15);
    button.backgroundColor = BFColor(0xFD8627);
    button.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(16)];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = type;
    button.hidden = YES;
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return button;
}

#pragma mark --按钮点击事件
- (void)click:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToOperateWithType:)]) {
        [self.delegate clickToOperateWithType:sender.tag];
    }
}


@end
