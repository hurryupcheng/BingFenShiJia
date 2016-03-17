//
//  BFLogisticInfoView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFLogisticInfoView.h"

@interface BFLogisticInfoView()
@property (nonatomic, strong) UIView *bottomView;
/**物流信息*/
@property (nonatomic, strong) UILabel *logisticLabel;
/**收货地址*/
@property (nonatomic, strong) UILabel *addressLabel;
/**配送方式*/
@property (nonatomic, strong) UILabel *deliverieLabel;
/**第一根线*/
@property (nonatomic, strong) UIView *firstLine;
/**第二根线*/
@property (nonatomic, strong) UIView *secondLine;
/**第三根线*/
@property (nonatomic, strong) UIView *thirdLine;
/**第四根线*/
@property (nonatomic, strong) UIView *fourthLine;
/**收货地址*/
@property (nonatomic, strong) UILabel *address;
/**配送方式*/
@property (nonatomic, strong) UILabel *deliverie;
/**快递公司*/
@property (nonatomic, strong) UILabel *expressCompany;
/**快递单号*/
@property (nonatomic, strong) UILabel *expressNumber;
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



@implementation BFLogisticInfoView
+ (instancetype)logisticView {
    BFLogisticInfoView *view = [[BFLogisticInfoView alloc] init];
    return view;
}

- (id)init {
    if (self = [super init]) {
        
        self.backgroundColor = BFColor(0xF4F4F4);
        [self setView];
    }
    return self;
}

- (void)setModel:(BFProductInfoModel *)model {
    _model = model;
    self.address.text = [NSString stringWithFormat:@"%@,%@,%@",model.address_name, model.mobile, model.address];
    self.address.frame = CGRectMake(CGRectGetMaxX(self.logisticLabel.frame), CGRectGetMaxY(self.logisticLabel.frame)+BF_ScaleHeight(8), BF_ScaleWidth(224), BF_ScaleHeight(30));
    [self.address sizeToFit];
    
    if ([model.freetype isEqualToString:@"0"]) {
        self.deliverie.text = @"卖家包邮";
    }else if ([model.freetype isEqualToString:@"1"]){
        self.deliverie.text = @"平邮";
    }else if ([model.freetype isEqualToString:@"3"]){
        self.deliverie.text = @"EMS";
    }else {
        self.deliverie.text = @"快递";
    }
    self.expressCompany.text = [NSString stringWithFormat:@"快递公司：%@",model.userfree];
    self.expressNumber.text = [NSString stringWithFormat:@"快递单号:%@",model.freecode];

    if (model.freecode.length == 0) {
        self.checkLogistics.hidden = YES;
        self.fourthLine.hidden = NO;
        self.bottomView.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(300),BF_ScaleHeight(150));
    }else {
        self.checkLogistics.hidden = NO;
        self.fourthLine.hidden = YES;
        self.bottomView.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(300),BF_ScaleHeight(185));
    }
    
    self.pay.frame = CGRectMake(BF_ScaleWidth(170), CGRectGetMaxY(self.bottomView.frame)+BF_ScaleHeight(30), BF_ScaleWidth(140), BF_ScaleHeight(40));
    self.cancleOrder.frame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.bottomView.frame)+BF_ScaleHeight(30), BF_ScaleWidth(140), BF_ScaleHeight(40));
    self.applyRebund.frame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.bottomView.frame)+BF_ScaleHeight(30), BF_ScaleWidth(300), BF_ScaleHeight(40));
    self.applyReturnGoods.frame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.bottomView.frame)+BF_ScaleHeight(30), BF_ScaleWidth(140), BF_ScaleHeight(40));
    self.confirmReceipt.frame = CGRectMake(BF_ScaleWidth(170), CGRectGetMaxY(self.bottomView.frame)+BF_ScaleHeight(30), BF_ScaleWidth(140), BF_ScaleHeight(40));
    self.cancleReturn.frame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.bottomView.frame)+BF_ScaleHeight(30), BF_ScaleWidth(300), BF_ScaleHeight(40));

    if ([model.refund_status isEqualToString:@"0"]) {
        if ([model.status isEqualToString:@"1"]) {
            self.pay.hidden = NO;
            self.cancleOrder.hidden = NO;
            self.cancleReturn.hidden = YES;
            self.confirmReceipt.hidden = YES;
            self.applyRebund.hidden = YES;
            self.applyReturnGoods.hidden = YES;
        }else if ([model.status isEqualToString:@"2"]) {
            self.pay.hidden = YES;
            self.cancleOrder.hidden = YES;
            self.cancleReturn.hidden = YES;
            self.confirmReceipt.hidden = YES;
            self.applyRebund.hidden = NO;
            self.applyReturnGoods.hidden = YES;
        }else if ([model.status isEqualToString:@"3"]) {
            self.pay.hidden = YES;
            self.cancleOrder.hidden = YES;
            self.cancleReturn.hidden = NO;
            self.confirmReceipt.hidden = NO;
            self.applyRebund.hidden = YES;
            self.applyReturnGoods.hidden = YES;
        }else if ([model.status isEqualToString:@"4"] || [model.status isEqualToString:@"5"]) {
            self.pay.hidden = YES;
            self.cancleOrder.hidden = YES;
            self.cancleReturn.hidden = YES;
            self.confirmReceipt.hidden = YES;
            self.applyRebund.hidden = YES;
            self.applyReturnGoods.hidden = YES;
        }
    }else if ([model.refund_status isEqualToString:@"1"] || [model.refund_status isEqualToString:@"4"] || [model.refund_status isEqualToString:@"6"]){
        self.pay.hidden = YES;
        self.cancleOrder.hidden = YES;
        self.cancleReturn.hidden = NO;
        self.confirmReceipt.hidden = YES;
        self.applyRebund.hidden = YES;
        self.applyReturnGoods.hidden = YES;
    }

    self.frame = CGRectMake(0, BF_ScaleHeight(10), ScreenWidth, CGRectGetMaxY(self.bottomView.frame)+BF_ScaleHeight(130));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.logisticLabel.frame = CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(10), BF_ScaleWidth(60), BF_ScaleHeight(14));
    
    self.addressLabel.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.logisticLabel.frame)+BF_ScaleHeight(8), self.logisticLabel.width, BF_ScaleHeight(13));
    
    self.address.frame = CGRectMake(CGRectGetMaxX(self.logisticLabel.frame), CGRectGetMaxY(self.logisticLabel.frame)+BF_ScaleHeight(8), BF_ScaleWidth(224), BF_ScaleHeight(30));
    
    self.firstLine.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.address.frame)+BF_ScaleHeight(4), BF_ScaleWidth(284), 1);
    
    self.deliverieLabel.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.firstLine.frame)+BF_ScaleHeight(3), self.logisticLabel.width, BF_ScaleHeight(13));
    
    self.deliverie.frame = CGRectMake(CGRectGetMaxX(self.deliverieLabel.frame), self.deliverieLabel.y, BF_ScaleWidth(100), self.deliverieLabel.height);
    
    self.secondLine.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.deliverie.frame)+BF_ScaleHeight(6), BF_ScaleWidth(284), 1);
    
    self.expressCompany.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.secondLine.frame)+BF_ScaleHeight(3), BF_ScaleWidth(284), self.logisticLabel.height);
    
    self.thirdLine.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.expressCompany.frame)+BF_ScaleHeight(6), BF_ScaleWidth(284), 1);
    
    self.expressNumber.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.thirdLine.frame)+BF_ScaleHeight(3), BF_ScaleWidth(284), self.logisticLabel.height);
    
    self.fourthLine.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.expressNumber.frame)+BF_ScaleHeight(6), BF_ScaleWidth(284), 1);
    
    self.checkLogistics.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.expressNumber.frame)+BF_ScaleHeight(10), BF_ScaleWidth(284), BF_ScaleHeight(30));
    
    
}

- (void)setView {
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:self.bottomView];
    
    self.logisticLabel = [self setUpLabelWithText:@"订单详情"];
    self.logisticLabel.textColor = BFColor(0x373737);
    self.logisticLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    
    self.addressLabel = [self setUpLabelWithText:@"收货地址"];
    
    self.address = [self setUpLabelWithText:nil];
    self.address.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    
    self.firstLine = [self setUpLine];
    
    self.deliverieLabel = [self setUpLabelWithText:@"配送方式"];
    
    self.deliverie = [self setUpLabelWithText:nil];
    
    self.secondLine = [self setUpLine];
    
    self.expressCompany = [self setUpLabelWithText:@"快递公司："];
    
    self.thirdLine = [self setUpLine];
    
    self.expressNumber = [self setUpLabelWithText:@"快递单号："];
    
    self.fourthLine = [self setUpLine];
    self.fourthLine.hidden = YES;
    

    self.checkLogistics = [self setUpButtonWithBackgroudColor:BFColor(0xE7001B) title:@"查看物流详情" type:BFLogisticInfoViewButtonTypeCheckLogistics];
    [self.bottomView addSubview:self.checkLogistics];
    self.checkLogistics.hidden = YES;
    
    self.pay = [self setUpButtonWithBackgroudColor:BFColor(0xF94250) title:@"付款" type:BFLogisticInfoViewButtonTypePay];
    [self addSubview:self.pay];
    self.pay.hidden = YES;
    
    self.cancleOrder = [self setUpButtonWithBackgroudColor:BFColor(0x82A8D3) title:@"取消订单" type:BFLogisticInfoViewButtonTypeCancleOrder];
    [self addSubview:self.cancleOrder];
    self.cancleOrder.hidden = YES;
    
    self.applyRebund = [self setUpButtonWithBackgroudColor:BFColor(0xF94250) title:@"申请退款" type:BFLogisticInfoViewButtonTypeApplyRebund];
    [self addSubview:self.applyRebund];
    self.applyRebund.hidden = YES;
    
    self.applyReturnGoods = [self setUpButtonWithBackgroudColor:BFColor(0xF94250) title:@"申请退货退款" type:BFLogisticInfoViewButtonTypeApplyReturnGoods];
    [self addSubview:self.applyReturnGoods];
    self.applyReturnGoods.hidden = YES;
    
    self.cancleReturn = [self setUpButtonWithBackgroudColor:BFColor(0xF94250) title:@"撤销退货退款申请" type:BFLogisticInfoViewButtonTypeCancleReturn];
    [self addSubview:self.cancleReturn];
    self.cancleReturn.hidden = YES;
    
    self.confirmReceipt = [self setUpButtonWithBackgroudColor:BFColor(0xF94250) title:@"确认收货" type:BFLogisticInfoViewButtonTypeConfirmReceipt];
    [self addSubview:self.confirmReceipt];
    self.confirmReceipt.hidden = YES;
    
}

- (UIButton *)setUpButtonWithBackgroudColor:(UIColor *)backgroundColor title:(NSString *)title type:(BFLogisticInfoViewButtonType)type{
    UIButton *button = [[UIButton alloc] init];
    button.tag = type;
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    [button addTarget:self action:@selector(goToCheckLogistics:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (UILabel *)setUpLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = BFColor(0x5B5B5B);
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    label.text = text;
    //label.backgroundColor = [UIColor redColor];
    label.numberOfLines = 0;
    
    [self.bottomView  addSubview:label];
    [label sizeToFit];
    return label;
}

- (UIView *)setUpLine {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BFColor(0xE5E5E5);
    [self.bottomView  addSubview:view];
    return view;
}

#pragma mark -- 按钮点击事件
//查看物流按钮
- (void)goToCheckLogistics:(UIButton *)button {
    BFLog(@"点击");
    if (self.delegate && [self.delegate respondsToSelector:@selector(logisticInfoView:type:)]) {
        [self.delegate logisticInfoView:self type:button.tag];
    }
}


@end
