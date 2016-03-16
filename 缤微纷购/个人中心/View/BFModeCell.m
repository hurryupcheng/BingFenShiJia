//
//  BFModeCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFModeCell.h"

@interface BFModeCell()
/**底部view*/
@property (nonatomic, strong) UIView *smallBottomView;
/**底部view*/
@property (nonatomic, strong) UIView *bigBottomView;
/**配送方式view*/
@property (nonatomic, strong) UIView *deliverieView;
/**支付方式view*/
@property (nonatomic, strong) UIView *payView;
/**商品配送方式*/
@property (nonatomic, strong) UILabel *productDeliveries;
/**商品总价*/
@property (nonatomic, strong) UILabel *productTotalPrice;
/**支付方式*/
@property (nonatomic, strong) UILabel *payMode;
/**下单时间*/
@property (nonatomic, strong) UILabel *orderTime;
@end


@implementation BFModeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFProductDetailCell";
    BFModeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFModeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xF4F4F4);
       // [self setCell];
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    self.deliverieView.frame = CGRectMake(BF_ScaleWidth(20), BF_ScaleHeight(10), BF_ScaleWidth(260), BF_ScaleHeight(50));
//    
//    self.payView.frame = CGRectMake(BF_ScaleWidth(20), BF_ScaleHeight(70), BF_ScaleWidth(260), BF_ScaleHeight(50));
//    
//    self.productDeliveries.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(260), BF_ScaleHeight(12));
//    
//    self.productTotalPrice.frame = CGRectMake(self.productDeliveries.x, CGRectGetMaxY(self.productDeliveries.frame)+BF_ScaleHeight(8), BF_ScaleWidth(260), BF_ScaleHeight(10));
//    
//    self.payMode.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(260), BF_ScaleHeight(12));
//    
//    self.orderTime.frame = CGRectMake(self.payMode.x, CGRectGetMaxY(self.payMode.frame)+BF_ScaleHeight(8), BF_ScaleWidth(260), BF_ScaleHeight(10));
//    
//    
//}

- (void)setModel:(BFProductInfoModel *)model {
    _model = model;
//    self.smallBottomView = [[UIView alloc] init];
//    self.smallBottomView.frame = CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(300), BF_ScaleHeight(70));
//    self.smallBottomView.backgroundColor = BFColor(0xffffff);
//    [self addSubview:self.smallBottomView];
    
    self.bigBottomView = [[UIView alloc] init];
    
    self.bigBottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:self.bigBottomView];
    


    self.deliverieView = [[UIView alloc] init];
    self.deliverieView.frame = CGRectMake(BF_ScaleWidth(20), BF_ScaleHeight(10), BF_ScaleWidth(260), BF_ScaleHeight(50));
    self.deliverieView.layer.borderWidth = 1;
    self.deliverieView.layer.borderColor = BFColor(0xE6E6E6).CGColor;
    [self.bigBottomView addSubview:self.deliverieView];
    self.deliverieView.hidden = YES;
    
    self.payView = [[UIView alloc] init];
    self.payView.frame = CGRectMake(BF_ScaleWidth(20), BF_ScaleHeight(70), BF_ScaleWidth(260), BF_ScaleHeight(50));
    self.payView.layer.borderWidth = 1;
    self.payView.layer.borderColor = BFColor(0xE6E6E6).CGColor;
    [self.bigBottomView addSubview:self.payView];
    self.payView.hidden = YES;
    
    self.productDeliveries = [self setUpLabel];
    self.productDeliveries.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(260), BF_ScaleHeight(12));
    if ([model.freetype isEqualToString:@"0"]) {
        self.productDeliveries.text = @"配送方式：卖家包邮";
    }else if ([model.freetype isEqualToString:@"1"]){
        self.productDeliveries.text = @"配送方式：平邮";
    }else if ([model.freetype isEqualToString:@"3"]){
        self.productDeliveries.text = @"配送方式：EMS";
    }else {
        self.productDeliveries.text = [NSString stringWithFormat:@"配送方式：%@", model.userfree];
    }

    [self.deliverieView addSubview:self.productDeliveries];

    self.productTotalPrice = [self setUpLabel];
    self.productTotalPrice.frame = CGRectMake(self.productDeliveries.x, CGRectGetMaxY(self.productDeliveries.frame)+BF_ScaleHeight(8), BF_ScaleWidth(260), BF_ScaleHeight(10));
    [self.deliverieView addSubview:self.productTotalPrice];
    self.productTotalPrice.text = [NSString stringWithFormat:@"%@", model.order_sumPrice];

    self.payMode = [self setUpLabel];
    self.payMode.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(260), BF_ScaleHeight(12));
    self.payMode.text = [NSString stringWithFormat:@"支付方式：默认付款"];
    [self.payView addSubview:self.payMode];

    self.orderTime = [self setUpLabel];
    self.orderTime.frame = CGRectMake(self.payMode.x, CGRectGetMaxY(self.payMode.frame)+BF_ScaleHeight(8), BF_ScaleWidth(260), BF_ScaleHeight(10));
    [self.payView addSubview:self.orderTime];
    self.orderTime.text = [NSString stringWithFormat:@"下单时间:%@",[BFTranslateTime translateTimeIntoCurrurents:model.add_time]];

    BFLog(@"model.status%lu",(unsigned long)model.status.length);
    if (model.status.length > 0) {
        if ([model.status isEqualToString:@"1"]) {
            self.deliverieView.hidden = NO;
            self.payView.hidden = YES;

            self.modeCellH = BF_ScaleHeight(70);
            self.bigBottomView.frame = CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(300), BF_ScaleHeight(70));
        }else {
            self.deliverieView.hidden = NO;
            self.payView.hidden = NO;
            self.modeCellH = BF_ScaleHeight(130);
            self.bigBottomView.frame = CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(300), BF_ScaleHeight(130));
        }
        
    }
    
}

//- (void)setCell {
//    self.bottomView = [[UIView alloc] init];
//    self.bottomView.backgroundColor = BFColor(0xffffff);
//    
//
//    self.deliverieView = [[UIView alloc] init];
//    self.deliverieView.layer.borderWidth = 1;
//    self.deliverieView.layer.borderColor = BFColor(0xE6E6E6).CGColor;
//    [self.bottomView addSubview:self.deliverieView];
//    
//    self.payView = [[UIView alloc] init];
//    self.payView.layer.borderWidth = 1;
//    self.payView.layer.borderColor = BFColor(0xE6E6E6).CGColor;
//    [self.bottomView addSubview:self.payView];
//
//    self.productDeliveries = [self setUpLabelWithText:@"配送方式：卖家包邮"];
//    [self.deliverieView addSubview:self.productDeliveries];
//    
//    self.productTotalPrice = [self setUpLabelWithText:@"总价:¥150.00"];
//    [self.deliverieView addSubview:self.productTotalPrice];
//    
//    self.payMode = [self setUpLabelWithText:@"支付方式：默认付款"];
//    [self.payView addSubview:self.payMode];
//    
//    self.orderTime = [self setUpLabelWithText:@"下单时间:1970-01-01 08:00:00"];
//    [self.payView addSubview:self.orderTime];
//    
//    [self addSubview:self.bottomView];
//}

- (UILabel *)setUpLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    //label.backgroundColor = [UIColor redColor];
    label.textColor = BFColor(0x5B5B5B);
    return label;
}
@end
