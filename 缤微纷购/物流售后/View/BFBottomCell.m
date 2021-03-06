//
//  BFBottomCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFBottomCell.h"

@interface BFBottomCell()
/**实付金额*/
@property (nonatomic, strong) UILabel *productTotalPrice;
/**底部放buttonView*/
@property (nonatomic, strong) UIView *buttonView;
/**售后按钮*/
@property (nonatomic, strong) UIButton *applyAfterSale;
/**物流查询*/
@property (nonatomic, strong) UIButton *checkLogistics;
/**确认收货*/
@property (nonatomic, strong) UIButton *confirmReceipt;

@end


@implementation BFBottomCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFBottomCell";
    BFBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFBottomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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

- (void)setModel:(BFLogisticsModel *)model {
    _model = model;
    self.productTotalPrice.text = [NSString stringWithFormat:@"共%ld个商品 实付金额:¥%@",(long)model.item_num, model.order_sumPrice];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.productTotalPrice.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xF98522) range:NSMakeRange(self.productTotalPrice.text.length-model.order_sumPrice.length-1, model.order_sumPrice.length+1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(8)] range:NSMakeRange(self.productTotalPrice.text.length-model.order_sumPrice.length-1, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(13)] range:NSMakeRange(self.productTotalPrice.text.length-model.order_sumPrice.length, model.order_sumPrice.length)];
    self.productTotalPrice.attributedText = attributedString;
    
    if ([model.status isEqualToString:@"3"]) {
        self.checkLogistics.hidden = NO;
        self.confirmReceipt.hidden = NO;
        self.checkLogistics.frame = CGRectMake(BF_ScaleWidth(185), BF_ScaleHeight(5), BF_ScaleWidth(55), BF_ScaleHeight(20));
        self.confirmReceipt.frame = CGRectMake(BF_ScaleWidth(245), BF_ScaleHeight(5), BF_ScaleWidth(55), BF_ScaleHeight(20));
    } else if ([model.status isEqualToString:@"4"]) {
        self.checkLogistics.hidden = NO;
        self.confirmReceipt.hidden = YES;
        self.checkLogistics.frame = CGRectMake(BF_ScaleWidth(245), BF_ScaleHeight(5), BF_ScaleWidth(55), BF_ScaleHeight(20));
    }
}

- (void)setCell {
    UIView *firstLine = [self setUpLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [self addSubview:firstLine];
    
    self.productTotalPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BF_ScaleWidth(310), BF_ScaleHeight(40))];
    self.productTotalPrice.textColor =  BFColor(0x000000);
    self.productTotalPrice.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    self.productTotalPrice.textAlignment = NSTextAlignmentRight;
    self.productTotalPrice.text = @"共1个商品 实付金额:¥32.00";
    [self addSubview:self.productTotalPrice];
    
    
    UIView *secondLine = [self setUpLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.productTotalPrice.frame)-0.5, ScreenWidth, 0.5)];
    [self addSubview:secondLine];
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.productTotalPrice.frame), ScreenWidth, BF_ScaleHeight(30))];
    self.buttonView = buttonView;
    //buttonView.backgroundColor = [UIColor redColor];
    [self addSubview:buttonView];
    
    UIButton *applyAfterSale = [self setUpButtonWithType:BFLogisticsCellButtonTypeApplyAfterSale color:BFColor(0xffffff) title:nil];
    self.applyAfterSale = applyAfterSale;
    self.applyAfterSale.hidden = YES;
    [buttonView addSubview:applyAfterSale];
    
    UIButton *checkLogistics = [self setUpButtonWithType:BFLogisticsCellButtonTypeCheckLogistics color:BFColor(0x3086CF) title:@"物流查询"];
    self.checkLogistics = checkLogistics;
    self.checkLogistics.hidden = YES;
    [buttonView addSubview:checkLogistics];
    
    UIButton *confirmReceipt = [self setUpButtonWithType:BFLogisticsCellButtonTypeConfirmReceipt color:BFColor(0xFA7B00) title:@"确认收货"];
    self.confirmReceipt = confirmReceipt;
    self.confirmReceipt.hidden = YES;
    [buttonView addSubview:confirmReceipt];
    
    
    UIView *thirdLine = [self setUpLineWithFrame:CGRectMake(0, BF_ScaleHeight(70)-0.5, ScreenWidth, 0.5)];
    [self addSubview:thirdLine];

    

}


//- (void)layoutSubviews {
//    [super layoutSubviews];
//    NSInteger count = self.buttonView.subviews.count;
//    for (NSInteger i = 0; i < count; i++) {
//        UIButton *button = self.buttonView.subviews[i];
//        button.x = BF_ScaleWidth(125)+BF_ScaleWidth(60)*i;
//        button.y = BF_ScaleHeight(5);
//        button.width = BF_ScaleWidth(55);
//        button.height = BF_ScaleHeight(20);
//    }
//}

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
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToOperateWithCell:model:Type:)]) {
        [self.delegate clickToOperateWithCell:self model:self.model Type:sender.tag];
    }
}



- (UIView *)setUpLineWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = BFColor(0xBDBEC0);
    return line;
}


@end
