//
//  BFMyOrderCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyOrderCell.h"

@interface BFMyOrderCell()
/**下单时间*/
@property (nonatomic, strong) UILabel *orderingTimeLabel;
/**商品图片*/
@property (nonatomic, strong) UIImageView *goodsImageView;
/**订单编号*/
@property (nonatomic, strong) UILabel *orderNumberLabel;
/**订单金额*/
@property (nonatomic, strong) UILabel *orderMoneyLabel;
/**运费*/
@property (nonatomic, strong) UILabel *orderFreightLabel;
/**订单状态*/
@property (nonatomic, strong) UILabel *orderStatusLabel;
@end

@implementation BFMyOrderCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"myOrder";
    BFMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFMyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCell];
    }
    return self;
}

- (void)setModel:(BFMyOrderModel *)model {
    _model = model;
    NSString *timeString = [BFTranslateTime translateTimeIntoCurrurents:model.add_time];
    self.orderingTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",timeString];
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.orderId];
    self.orderMoneyLabel.text = [NSString stringWithFormat:@"订单金额：¥%@",model.order_sumPrice];
    if ([model.freetype isEqualToString:@"0"]) {
        self.orderFreightLabel.text = @"运费：包邮";
    }else {
         self.orderFreightLabel.text = [NSString stringWithFormat:@"运费：¥%@",model.freeprice];
    }
    self.orderStatusLabel.text = [NSString stringWithFormat:@"订单状态：%@",model.status_w];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"goodsImage"]];
}


- (void)setCell {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth-10, BF_ScaleHeight(120))];
    bgView.backgroundColor = [UIColor blueColor];
    bgView.layer.shadowOpacity = 0.6;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    //bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    [self addSubview:bgView];
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgView.width, BF_ScaleHeight(30))];
    timeView.backgroundColor = BFColor(0xDDDFE0);
    [bgView addSubview:timeView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(30)-0.5, bgView.width, 0.5)];
    line.backgroundColor = BFColor(0xC7C8C9);
    [timeView addSubview:line];
    
    UIView *detailView = [[UIView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(30), bgView.width, BF_ScaleHeight(90))];
    detailView.backgroundColor = BFColor(0xE6E9E9);
    [bgView addSubview:detailView];
    
    self.orderingTimeLabel = [UILabel labelWithFrame:CGRectMake(5, 0, timeView.width, timeView.height) font:BF_ScaleFont(13) textColor:BFColor(0x5B5C5D) text:@"下单时间：2015-01-06 11:59"];
    [timeView addSubview:self.orderingTimeLabel];
    

    self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, BF_ScaleHeight(5), BF_ScaleHeight(76), BF_ScaleHeight(76))];
    self.goodsImageView.image = [UIImage imageNamed:@"goodsImage"];
    [detailView addSubview:self.goodsImageView];
    
    self.orderNumberLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImageView.frame)+BF_ScaleWidth(8), BF_ScaleHeight(5), BF_ScaleWidth(200), BF_ScaleHeight(19)) font:BF_ScaleFont(11) textColor:BFColor(0x5B5C5D) text:@"订单编号：2016010611593111644"];
    [detailView addSubview:self.orderNumberLabel];
    
    self.orderMoneyLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImageView.frame)+BF_ScaleWidth(8), CGRectGetMaxY(self.orderNumberLabel.frame), BF_ScaleWidth(200), BF_ScaleHeight(19)) font:BF_ScaleFont(11) textColor:BFColor(0x5B5C5D) text:@"订单金额：¥199.00"];
    [detailView addSubview:self.orderMoneyLabel];
    
    self.orderFreightLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImageView.frame)+BF_ScaleWidth(8), CGRectGetMaxY(self.orderMoneyLabel.frame), BF_ScaleWidth(200), BF_ScaleHeight(19)) font:BF_ScaleFont(11) textColor:BFColor(0x5B5C5D) text:@"运费：包邮"];
    [detailView addSubview:self.orderFreightLabel];
    
    self.orderStatusLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImageView.frame)+BF_ScaleWidth(8), CGRectGetMaxY(self.orderFreightLabel.frame), BF_ScaleWidth(200), BF_ScaleHeight(19)) font:BF_ScaleFont(11) textColor:BFColor(0x5B5C5D) text:@"订单状态：已发货"];
    [detailView addSubview:self.orderStatusLabel];
    
    UIImageView *rightArrawhead = [[UIImageView alloc] initWithFrame:CGRectMake(detailView.width-BF_ScaleWidth(30), 0, BF_ScaleWidth(30), detailView.height)];
    rightArrawhead.image = [UIImage imageNamed:@"select_right"];
    rightArrawhead.contentMode = UIViewContentModeScaleAspectFit;
    [detailView addSubview:rightArrawhead];
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
