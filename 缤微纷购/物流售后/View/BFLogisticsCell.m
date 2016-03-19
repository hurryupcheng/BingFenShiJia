//
//  BFLogisticsCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFLogisticsCell.h"
#import "BFProductInfoView.h"
@interface BFLogisticsCell()
/**订单编号*/
@property (nonatomic, strong) UILabel *orderID;
/**订单状态*/
@property (nonatomic, strong) UILabel *statusLabel;
/**订单状态*/
@property (nonatomic, strong) UILabel *productTotalPrice;
/***/
@property (nonatomic, strong) BFProductInfoView *productView;

@property (nonatomic, strong) UIView *buttonView;
@end

@implementation BFLogisticsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFLogisticsCell";
    BFLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFLogisticsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xF2F4F5);
        [self setCell];
    }
    return self;
}




- (void)setCell {
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(190))];
    bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:bottomView];
    
    
    UIView *firstLine = [self setUpLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [bottomView addSubview:firstLine];
    
    self.orderID = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(200), BF_ScaleHeight(25))];
    self.orderID.text = @"订单编号：160589998";
    self.orderID.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    //self.orderID.backgroundColor = [UIColor redColor];
    [bottomView addSubview:self.orderID];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(220), 0, BF_ScaleWidth(90), self.orderID.height)];
    self.statusLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    self.statusLabel.textAlignment = NSTextAlignmentRight;
    self.statusLabel.textColor = BFColor(0x4992D3);
    //self.statusLabel.backgroundColor = [UIColor greenColor];
    self.statusLabel.text = @"已发货";
    [bottomView addSubview:self.statusLabel];
    
    UIView *secondLine = [self setUpLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.orderID.frame)-0.5, ScreenWidth, 0.5)];
    [bottomView addSubview:secondLine];
    
    self.productView = [[BFProductInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.orderID.frame), ScreenWidth, BF_ScaleHeight(95))];
    [bottomView addSubview:self.productView];
    
    
    self.productTotalPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.productView.frame), BF_ScaleWidth(310), BF_ScaleHeight(40))];
    self.productTotalPrice.textAlignment = NSTextAlignmentRight;
    self.productTotalPrice.text = @"共1个商品 实付金额:¥32.00";
    [bottomView addSubview:self.productTotalPrice];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.productTotalPrice.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0x000000) range:NSMakeRange(0, 11)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(11)] range:NSMakeRange(0, 11)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xDC6B00) range:NSMakeRange(11, self.productTotalPrice.text.length - 11)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(14)] range:NSMakeRange(11, self.productTotalPrice.text.length - 11)];
    self.productTotalPrice.attributedText = attributedString;
    
    
    UIView *thirdLine = [self setUpLineWithFrame:CGRectMake(0, BF_ScaleHeight(160)-0.5, ScreenWidth, 0.5)];
    [bottomView addSubview:thirdLine];
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.productTotalPrice.frame), ScreenWidth, BF_ScaleHeight(30))];
    self.buttonView = buttonView;
    [bottomView addSubview:buttonView];
    
    UIButton *applyAfterSale = [self setUpButtonWithType:BFLogisticsCellButtonTypeApplyAfterSale color:BFColor(0x3086CF) title:@"申请售后"];
    [buttonView addSubview:applyAfterSale];
    
    UIButton *checkLogistics = [self setUpButtonWithType:BFLogisticsCellButtonTypeCheckLogistics color:BFColor(0x3086CF) title:@"物流查询"];
    [buttonView addSubview:checkLogistics];
    
    UIButton *confirmReceipt = [self setUpButtonWithType:BFLogisticsCellButtonTypeConfirmReceipt color:BFColor(0xFA7B00) title:@"确认收货"];
    [buttonView addSubview:confirmReceipt];
    
    
    UIView *fourthLine = [self setUpLineWithFrame:CGRectMake(0, bottomView.height-0.5, ScreenWidth, 0.5)];
    [bottomView addSubview:fourthLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = self.buttonView.subviews.count;
    BFLog(@"%@",self.buttonView.subviews);
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = self.buttonView.subviews[i];
        button.x = BF_ScaleWidth(125)+BF_ScaleWidth(60)*i;
        button.y = BF_ScaleHeight(5);
        button.width = BF_ScaleWidth(55);
        button.height = BF_ScaleHeight(20);
    }
}

- (UIButton *)setUpButtonWithType:(BFLogisticsCellButtonType)type color:(UIColor *)color title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.tag = type;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = color.CGColor;
    button.layer.cornerRadius = BF_ScaleHeight(10);
    button.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(10)];
    [button addTarget:self action:@selector(clickToJump:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)clickToJump:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToOperateWithType:)]) {
        [self.delegate clickToOperateWithType:sender.tag];
    }
}

- (UIView *)setUpLineWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = BFColor(0xEAEAEA);
    return line;
}

@end
