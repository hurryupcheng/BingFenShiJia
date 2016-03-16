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
/**查看物流信息*/
@property (nonatomic, strong) UIButton *checkLogistics;
@end



@implementation BFLogisticInfoView
+ (instancetype)logisticView {
    BFLogisticInfoView *view = [[BFLogisticInfoView alloc] init];
    return view;
}

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(220));
        self.backgroundColor = BFColor(0xF4F4F4);
        [self setView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bottomView.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(300),BF_ScaleHeight(170));
    
    self.logisticLabel.frame = CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(10), BF_ScaleWidth(60), BF_ScaleHeight(14));
    
    self.addressLabel.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.logisticLabel.frame)+BF_ScaleHeight(8), self.logisticLabel.width, BF_ScaleHeight(13));
    
    self.address.frame = CGRectMake(CGRectGetMaxX(self.logisticLabel.frame), CGRectGetMaxY(self.logisticLabel.frame)+BF_ScaleHeight(8), BF_ScaleWidth(210), BF_ScaleHeight(25));
    
    self.firstLine.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.address.frame)+BF_ScaleHeight(4), BF_ScaleWidth(284), 1);
    
    self.deliverieLabel.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.firstLine.frame)+BF_ScaleHeight(3), self.logisticLabel.width, BF_ScaleHeight(13));
    
    self.deliverie.frame = CGRectMake(CGRectGetMaxX(self.deliverieLabel.frame), self.deliverieLabel.y, BF_ScaleWidth(100), self.deliverieLabel.height);
    
    self.secondLine.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.deliverie.frame)+BF_ScaleHeight(6), BF_ScaleWidth(284), 1);
    
    self.expressCompany.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.secondLine.frame)+BF_ScaleHeight(3), BF_ScaleWidth(284), self.logisticLabel.height);
    
    self.thirdLine.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.expressCompany.frame)+BF_ScaleHeight(6), BF_ScaleWidth(284), 1);
    
    self.expressNumber.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.thirdLine.frame)+BF_ScaleHeight(3), BF_ScaleWidth(284), self.logisticLabel.height);
    
    self.fourthLine.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.expressNumber.frame)+BF_ScaleHeight(6), BF_ScaleWidth(284), 1);
    
    self.checkLogistics.frame = CGRectMake(self.logisticLabel.x, CGRectGetMaxY(self.expressNumber.frame)+BF_ScaleHeight(6), BF_ScaleWidth(284), BF_ScaleHeight(30));
    
    
}

- (void)setView {
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:self.bottomView];
    
    self.logisticLabel = [self setUpLabelWithText:@"订单详情"];
    self.logisticLabel.textColor = BFColor(0x373737);
    self.logisticLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    
    self.addressLabel = [self setUpLabelWithText:@"收货地址"];
    
    self.address = [self setUpLabelWithText:@"哈哈哈，13986600772，广东省广州市白云区解放北路1339号8楼8218室"];
    self.address.font = [UIFont systemFontOfSize:BF_ScaleFont(10)];
    
    self.firstLine = [self setUpLine];
    
    self.deliverieLabel = [self setUpLabelWithText:@"配送方式"];
    
    self.deliverie = [self setUpLabelWithText:@"卖家包邮"];
    
    self.secondLine = [self setUpLine];
    
    self.expressCompany = [self setUpLabelWithText:@"快递公司：天天快递"];
    
    self.thirdLine = [self setUpLine];
    
    self.expressNumber = [self setUpLabelWithText:@"快递单号：2016120231172632123456"];
    
    self.fourthLine = [self setUpLine];
    
    self.checkLogistics = [[UIButton alloc] init];
    [self.checkLogistics setTitle:@"查看物流详情" forState:UIControlStateNormal];
    self.checkLogistics.backgroundColor = BFColor(0xE7001B);
    [self.bottomView addSubview:self.checkLogistics];
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

@end
