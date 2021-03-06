//
//  BFOrderDetailInfoCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define cellHeight   BF_ScaleWidth(44)
#import "BFOrderDetailInfoCell.h"

@interface BFOrderDetailInfoCell()

/**应付款/实付款*/
@property (nonatomic, strong) UILabel *paymentAmount;
/**下单时间*/
@property (nonatomic, strong) UILabel *addOrderTime;
/**商品总价*/
@property (nonatomic, strong) UILabel *productTotalPrice;
/**运费*/
@property (nonatomic, strong) UILabel *freight;
/**积分抵扣*/
@property (nonatomic, strong) UILabel *integralOffset;
/**优惠券抵扣*/
@property (nonatomic, strong) UILabel *couponsOffset;
/**实付款*/
@property (nonatomic, strong) UILabel *actualPayment;

@end


@implementation BFOrderDetailInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFOrderDetailInfoCell";
    BFOrderDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFOrderDetailInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xffffff);
        [self setCell];
    }
    return self;
}

- (void)setModel:(BFProductInfoModel *)model {
    _model = model;
    if ([model.status isEqualToString:@"1"]) {
        self.paymentAmount.text = @"应付款";
    }else {
        self.paymentAmount.text = @"实付款";
    }
    
    self.addOrderTime.text = [BFTranslateTime translateTimeIntoAccurateTime:model.add_time];
    
    self.productTotalPrice.text = [NSString stringWithFormat:@"¥ %@", model.goods_sumPrice];
    
    self.freight.text = [NSString stringWithFormat:@"¥ %@", model.freeprice];
    
    self.integralOffset.text = [NSString stringWithFormat:@"- ¥ %.2f", [model.use_score floatValue]/100];
    
    self.couponsOffset.text = [NSString stringWithFormat:@"- ¥ %.2f", [model.coupon_money floatValue]];
    
    float payMoney = [model.order_sumPrice floatValue];
    
    self.actualPayment.text = [NSString stringWithFormat:@"¥ %.2f", payMoney];
}

- (void)setCell {
    NSArray *array = @[@"下单时间", @"商品总价", @"运费", @"积分抵扣", @"优惠券抵扣"];
    for (NSInteger i = 0; i < array.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(15), cellHeight * i, BF_ScaleWidth(150), cellHeight)];
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
        [self addSubview:label];
    }
    
    for (NSInteger i = 0; i < array.count+1; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (cellHeight-0.5)*i, ScreenWidth, 0.5)];
        line.backgroundColor = BFColor(0xC3C0C9);
        [self addSubview:line];
    }
    
    self.paymentAmount = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(15), BF_ScaleHeight(220), BF_ScaleWidth(150), cellHeight)];
    self.paymentAmount.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    [self addSubview:self.paymentAmount];
    
    
    self.addOrderTime = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(160), 0, BF_ScaleWidth(145), cellHeight) textColor:BFColor(0x000000) text:@"2016-01-22 11:22:33"];
    self.addOrderTime.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
  
    self.productTotalPrice = [self setUpLabelWithFrame:CGRectMake(self.addOrderTime.x, CGRectGetMaxY(self.addOrderTime.frame), BF_ScaleWidth(145), self.addOrderTime.height) textColor:BFColor(0xFD8627) text:@"¥ 69.00"];
    
    self.freight = [self setUpLabelWithFrame:CGRectMake(self.addOrderTime.x, CGRectGetMaxY(self.productTotalPrice.frame), BF_ScaleWidth(145), self.addOrderTime.height) textColor:BFColor(0xFD8627) text:@"¥ 0.00"];
    
    self.integralOffset = [self setUpLabelWithFrame:CGRectMake(self.addOrderTime.x, CGRectGetMaxY(self.freight.frame), BF_ScaleWidth(145), self.addOrderTime.height) textColor:BFColor(0x5E5E60) text:@"- ¥ 0.00"];
    
    self.couponsOffset = [self setUpLabelWithFrame:CGRectMake(self.addOrderTime.x, CGRectGetMaxY(self.integralOffset.frame), BF_ScaleWidth(145), self.addOrderTime.height) textColor:BFColor(0x5E5E60) text:@"- ¥ 40.00"];
    
    self.actualPayment = [self setUpLabelWithFrame:CGRectMake(self.addOrderTime.x, CGRectGetMaxY(self.couponsOffset.frame), BF_ScaleWidth(145), self.addOrderTime.height) textColor:BFColor(0xFD8627) text:@"¥ 29.00"];
    self.actualPayment.font = [UIFont systemFontOfSize:BF_ScaleFont(20)];
}


- (UILabel *)setUpLabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(16)];
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = textColor;
    [self addSubview:label];
    return label;
}

@end
