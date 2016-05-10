//
//  BFVipOrderCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define MaginW       BF_ScaleWidth(5)
#define MaginH       BF_ScaleHeight(5)
#define LabelHeight  (BF_ScaleHeight(70)/4)
#import "BFVipOrderCell.h"

@interface BFVipOrderCell()
/**头像*/
@property (nonatomic, strong) UIImageView *productIcon;
/**下单时间*/
@property (nonatomic, strong) UILabel *addOrderTime;
/**订单编号*/
@property (nonatomic, strong) UILabel *orderNumber;
/**订单金额*/
@property (nonatomic, strong) UILabel *orderAmount;
/**订单状态*/
@property (nonatomic, strong) UILabel *orderStatus;
/**运费*/
@property (nonatomic, strong) UILabel *expressCharge;
/**背景View*/
@property (nonatomic, strong) UIView *bgView;


@end

@implementation BFVipOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFVipOrderCell";
    BFVipOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFVipOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCell];
    }
    return self;
}

- (void)setModel:(BFVIPOrderList *)model {
    _model = model;
    if (model) {
        [self.productIcon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
        self.addOrderTime.text = [NSString stringWithFormat:@"下单时间：%@", [BFTranslateTime translateTimeIntoCurrurents:model.add_time]];
        self.orderNumber.text = [NSString stringWithFormat:@"订单编号：%@",model.orderId];
        self.orderAmount.text = [NSString stringWithFormat:@"订单金额：¥%@",model.order_sumPrice];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.orderAmount.text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xFA8931) range:NSMakeRange(5,model.order_sumPrice.length+1)];
        self.orderAmount.attributedText = attributedString;
        
        if ([model.freeprice doubleValue] <= 0.00) {
            self.expressCharge.text = @"运费：包邮";
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.expressCharge.text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xFA8931) range:NSMakeRange(3,2)];
            self.expressCharge.attributedText = attributedString;
        }else {
            self.expressCharge.text = [NSString stringWithFormat:@"运费：¥%@", model.freeprice];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.expressCharge.text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xFA8931) range:NSMakeRange(3,model.freeprice.length+1)];
            self.expressCharge.attributedText = attributedString;
        }
        
        self.orderStatus.text = [NSString stringWithFormat:@"订单状态：%@",model.status_w];
        
        
        
        

    }
}

- (void)setCell {
    self.bgView = [UIView new];
    self.bgView.frame = CGRectMake(MaginW, MaginH, BF_ScaleWidth(310), BF_ScaleHeight(115));
    self.bgView.layer.shadowOpacity = 0.3;
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.borderColor = BFColor(0xD4D4D4).CGColor;
    self.bgView.layer.borderWidth = 1;
    //self.bgView.layer.cornerRadius = 5;
    self.bgView.backgroundColor = BFColor(0xEAEBEC);
    [self.contentView addSubview:self.bgView];
    
    
    self.addOrderTime = [[UILabel alloc] init];
    self.addOrderTime.frame = CGRectMake(0, 0, BF_ScaleHeight(310), BF_ScaleHeight(30));
    self.addOrderTime.text = @"  下单时间：2016-03010 10:05";
    self.addOrderTime.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    self.addOrderTime.backgroundColor = BFColor(0xDFDFDF);
    self.addOrderTime.textColor = BFColor(0x5B5B5B);
    [self.bgView addSubview:self.addOrderTime];
    
    self.productIcon = [[UIImageView alloc] init];
    self.productIcon.frame = CGRectMake(MaginW, CGRectGetMaxY(self.addOrderTime.frame)+MaginH, BF_ScaleHeight(70), BF_ScaleHeight(70));
    self.productIcon.layer.borderColor = BFColor(0xDDDFE0).CGColor;
    self.productIcon.layer.borderWidth = 1;
    self.productIcon.image = [UIImage imageNamed:@"100.jpg"];
    [self.bgView addSubview:self.productIcon];
    
    
    self.orderNumber = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame)+MaginW, CGRectGetMaxY(self.addOrderTime.frame)+MaginH, BF_ScaleWidth(210), LabelHeight) text:@"订单编号：201603101005021016"];
    
    self.orderAmount = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame)+MaginW, CGRectGetMaxY(self.orderNumber.frame), BF_ScaleWidth(210), LabelHeight) text:@"订单金额：¥6.90"];
    
    self.expressCharge = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame)+MaginW, CGRectGetMaxY(self.orderAmount.frame), BF_ScaleWidth(210), LabelHeight) text:@"运费：包邮"];
    
    self.orderStatus = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame)+MaginW, CGRectGetMaxY(self.expressCharge.frame), BF_ScaleWidth(210), LabelHeight) text:@"订单状态：已发货"];
    
    

}

- (UILabel *)setUpLabelWithFrame:(CGRect)frame text:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    label.textColor = BFColor(0x474747);
    label.text = text;
    [self.bgView addSubview:label];
    return label;
}

@end
