//
//  BFCustomerOrderCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define MaginW       BF_ScaleWidth(5)
#define MaginH       BF_ScaleHeight(5)
#define LabelHeight  BF_ScaleHeight(20)
#import "BFCustomerOrderCell.h"

@interface BFCustomerOrderCell()
/**头像*/
@property (nonatomic, strong) UIImageView *headImageView;
/**下单时间*/
@property (nonatomic, strong) UILabel *addOrderTime;
/**订单编号*/
@property (nonatomic, strong) UILabel *orderNumber;
/**订单金额*/
@property (nonatomic, strong) UILabel *orderAmount;
/**订单状态*/
@property (nonatomic, strong) UILabel *orderStatus;
/**我的佣金*/
@property (nonatomic, strong) UILabel *myCommission;
/**背景View*/
@property (nonatomic, strong) UIView *bgView;

@end

@implementation BFCustomerOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFCustomerOrderCell";
    BFCustomerOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFCustomerOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        
        [self setCell];
        
        
    }
    return self;
}

- (void)setModel:(ProxyOrderList *)model {
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"touxiang1"]];
    self.addOrderTime.text = [NSString stringWithFormat:@"下单时间：%@", [BFTranslateTime translateTimeIntoCurrurents:model.add_time]];
    self.orderNumber.text = [NSString stringWithFormat:@"订单编号：%@",model.orderId];
    self.orderAmount.text = [NSString stringWithFormat:@"订单金额：%@",model.order_sumPrice];
    self.orderStatus.text = [NSString stringWithFormat:@"订单状态：%@",model.status_w];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.orderStatus.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xFD6268) range:NSMakeRange(5,model.status_w.length)];
    self.orderStatus.attributedText = attributedString;

    
    self.myCommission.text = [NSString stringWithFormat:@"我的佣金：%@",model.jiner];
    
}

- (void)setCell {
    self.bgView = [UIView new];
    self.bgView.frame = CGRectMake(MaginW, MaginH, BF_ScaleWidth(310), BF_ScaleHeight(130));
    self.bgView.layer.shadowOpacity = 0.3;
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.borderColor = BFColor(0xD4D4D4).CGColor;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.cornerRadius = 5;
    self.bgView.backgroundColor = BFColor(0xE8E9E8);
    [self.contentView addSubview:self.bgView];
    
    
    self.addOrderTime = [[UILabel alloc] init];
    self.addOrderTime.frame = CGRectMake(0, 0, BF_ScaleHeight(310), BF_ScaleHeight(35));
    self.addOrderTime.text = @"  下单时间：2016-03010 10:05";
    self.addOrderTime.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    self.addOrderTime.backgroundColor = BFColor(0xDFDFDF);
    self.addOrderTime.textColor = BFColor(0x5B5B5B);
    [self.bgView addSubview:self.addOrderTime];
    
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.frame = CGRectMake(MaginW, CGRectGetMaxY(self.addOrderTime.frame)+MaginH, BF_ScaleHeight(80), BF_ScaleHeight(80));
    self.headImageView.image = [UIImage imageNamed:@"touxiang"];
    [self.bgView addSubview:self.headImageView];
    

    self.orderNumber = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.headImageView.frame)+MaginW, CGRectGetMaxY(self.addOrderTime.frame)+MaginH, BF_ScaleWidth(210), LabelHeight) text:@"订单编号：201603101005021016"];
    
    self.orderAmount = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.headImageView.frame)+MaginW, CGRectGetMaxY(self.orderNumber.frame), BF_ScaleWidth(210), LabelHeight) text:@"订单金额：¥6.90"];
    
    self.orderStatus = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.headImageView.frame)+MaginW, CGRectGetMaxY(self.orderAmount.frame), BF_ScaleWidth(210), LabelHeight) text:@"订单状态：已发货"];
    
    self.myCommission = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.headImageView.frame)+MaginW, CGRectGetMaxY(self.orderStatus.frame), BF_ScaleWidth(210), LabelHeight) text:@"我的佣金：¥0.61"];

}

- (UILabel *)setUpLabelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    label.textColor = BFColor(0x474747);
    label.text = text;
    [self.bgView addSubview:label];
    return label;
}

@end
