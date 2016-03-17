//
//  BFOrderDetailView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFOrderDetailView.h"

@interface BFOrderDetailView()
@property (nonatomic, strong) UIView *bottomView;
/**订单详情*/
@property (nonatomic, strong) UILabel *titleLabel;
/**订单状态*/
@property (nonatomic, strong) UILabel *statusLabel;
/**订单号*/
@property (nonatomic, strong) UILabel *orderLabel;
/**订单时间*/
@property (nonatomic, strong) UILabel *timeLabel;
/**第一根线*/
@property (nonatomic, strong) UIView *firstLine;
/**第二根线*/
@property (nonatomic, strong) UIView *secondLine;
/**第三根线*/
@property (nonatomic, strong) UIView *thirdLine;
/**状态*/
@property (nonatomic, strong) UILabel *status;
/**订单号*/
@property (nonatomic, strong) UILabel *orderID;
/**下单时间*/
@property (nonatomic, strong) UILabel *orderTime;
@end


@implementation BFOrderDetailView
+ (instancetype)detailView {
    BFOrderDetailView *view = [[BFOrderDetailView alloc] init];
    return view;
}

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(130));
        self.backgroundColor = BFColor(0xF4F4F4);
       
        [self setView];
    }
    return self;
}
- (void)setModel:(BFProductInfoModel *)model {
    _model = model;
    if ([model.refund_status isEqualToString:@"0"]) {
        if ([model.status isEqualToString:@"1"]) {
            self.status.text = @"未付款";
        }else if ([model.status isEqualToString:@"2"]) {
            self.status.text = @"待发货";
        }else if ([model.status isEqualToString:@"3"]) {
            self.status.text = @"已发货";
        }else if ([model.status isEqualToString:@"4"]) {
            self.status.text = @"完成";
        }else {
            self.status.text = @"关闭";
        }
    } else if ([model.refund_status isEqualToString:@"1"]){
        self.status.text = @"退款中";
    }else if ([model.refund_status isEqualToString:@"2"]){
        self.status.text = @"已退款";
    }else if ([model.refund_status isEqualToString:@"3"]){
        self.status.text = @"卖家不同意退款";
    }else if ([model.refund_status isEqualToString:@"4"]){
        self.status.text = @"已申请退货";
    }else if ([model.refund_status isEqualToString:@"5"]){
        self.status.text = @"卖家不同意退货";
    }else if ([model.refund_status isEqualToString:@"6"]){
        self.status.text = @"卖家同意退货";
    }else if ([model.refund_status isEqualToString:@"7"]){
        self.status.text = @"等待卖家退货";
    }else {
        self.status.text = @"已退款";
    }
    
    self.orderID.text = model.orderId;
    self.orderTime.text = [NSString stringWithFormat:@"%@",[BFTranslateTime translateTimeIntoCurrurents:model.add_time]];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.bottomView.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(300), BF_ScaleHeight(110));
    
    self.titleLabel.frame = CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(10), BF_ScaleWidth(60), BF_ScaleHeight(14));
    
    self.statusLabel.frame = CGRectMake(self.titleLabel.x, CGRectGetMaxY(self.titleLabel.frame)+BF_ScaleHeight(8), self.titleLabel.width, BF_ScaleHeight(13));
    
    self.firstLine.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.statusLabel.frame)+BF_ScaleHeight(6), BF_ScaleWidth(284), 1);
    
    self.orderLabel.frame = CGRectMake(self.statusLabel.x, CGRectGetMaxY(self.statusLabel.frame)+BF_ScaleHeight(11), self.statusLabel.width, BF_ScaleHeight(13));
    
    self.secondLine.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.orderLabel.frame)+BF_ScaleHeight(6), BF_ScaleWidth(284), 1);
    
    self.timeLabel.frame = CGRectMake(self.orderLabel.x, CGRectGetMaxY(self.orderLabel.frame)+BF_ScaleHeight(11), self.orderLabel.width, BF_ScaleHeight(13));
    
    self.thirdLine.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.timeLabel.frame)+BF_ScaleHeight(6), BF_ScaleWidth(284), 1);
    
    self.status.frame = CGRectMake(CGRectGetMaxX(self.statusLabel.frame), self.statusLabel.y, BF_ScaleWidth(150), self.statusLabel.height);
    
    self.orderID.frame = CGRectMake(self.status.x, self.orderLabel.y, self.status.width, self.status.height);
    
    self.orderTime.frame = CGRectMake(self.status.x, self.timeLabel.y, self.status.width, self.status.height);
    

}

- (void)setView {
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:self.bottomView];
    
    self.titleLabel = [self setUpLabelWithText:@"订单详情"];
    self.titleLabel.textColor = BFColor(0x373737);
    self.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    
    self.statusLabel = [self setUpLabelWithText:@"订单状态"];
    
    self.orderLabel = [self setUpLabelWithText:@"订单号"];
    
    self.timeLabel = [self setUpLabelWithText:@"下单时间"];
    
    self.firstLine = [self setUpLine];
    
    self.secondLine = [self setUpLine];
    
    self.thirdLine = [self setUpLine];
    
    self.status = [self setUpLabelWithText:nil];
    
    self.orderID = [self setUpLabelWithText:nil];
    
    self.orderTime = [self setUpLabelWithText:nil];
}

- (UILabel *)setUpLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = BFColor(0x5B5B5B);
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    label.text = text;
    //label.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:label];
    return label;
}

- (UIView *)setUpLine {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BFColor(0xE5E5E5);
    [self.bottomView addSubview:view];
    return view;
}

@end
