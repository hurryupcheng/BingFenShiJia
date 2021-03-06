//
//  BFVipOrderIntroduceCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFVipOrderIntroduceCell.h"

@interface BFVipOrderIntroduceCell()
/**背景view*/
@property (nonatomic, strong) UIView *bgView;
/**总佣金*/
@property (nonatomic, strong) UILabel *totalMoneyLabel;
/**说明*/
@property (nonatomic, strong) UILabel *instructionLabel;

@end

@implementation BFVipOrderIntroduceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFVipOrderIntroduceCell";
    BFVipOrderIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFVipOrderIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        self.bgView = [UIView new];
        self.bgView.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(4.5), BF_ScaleWidth(310), BF_ScaleHeight(110));
        self.bgView.layer.shadowOpacity = 0.3;
        self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
        self.bgView.layer.borderColor = BFColor(0xD4D4D4).CGColor;
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.cornerRadius = 5;
        self.bgView.backgroundColor = BFColor(0xffffff);
        [self.contentView addSubview:self.bgView];
        
        
        self.totalMoneyLabel = [UILabel new];
        self.totalMoneyLabel.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(10), BF_ScaleWidth(300), 0);
        self.totalMoneyLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        self.totalMoneyLabel.numberOfLines = 0;
        self.totalMoneyLabel.text = [NSString stringWithFormat:@"本月总佣金：¥0.00（其中¥0.00已确认，¥0.00待确认）"];
        
        //_totalMoneyLabel.backgroundColor = [UIColor redColor];
        [self.bgView addSubview:self.totalMoneyLabel];
        [self.totalMoneyLabel sizeToFit];
        
        
        
        self.instructionLabel = [UILabel new];
        self.instructionLabel.frame = CGRectMake(BF_ScaleWidth(5), CGRectGetMaxY(self.totalMoneyLabel.frame)+BF_ScaleHeight(4.5), BF_ScaleWidth(300), BF_ScaleHeight(70));
        self.instructionLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        self.instructionLabel.text = @"说明：订单状态为【交易成功】的才能结算佣金，请在个人中心填写银行账号，以便商家打款。（此处仅显示最新50条订单信息）";
        self.instructionLabel.numberOfLines = 0;
        [self setLineSpace:BF_ScaleHeight(4.5) headIndent:0 text:_instructionLabel.text label:_instructionLabel];
        //_instructionLabel.backgroundColor = [UIColor greenColor];
        [self.bgView addSubview:self.instructionLabel];
        [self.instructionLabel sizeToFit];
        
        
    }
    return self;
}

- (void)setModel:(BFVIPOrderModel *)model {
    _model = model;
    self.totalMoneyLabel.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(10), BF_ScaleWidth(300), 0);
    _totalMoneyLabel.text = [NSString stringWithFormat:@"本月总佣金：¥%@（其中¥%@已确认，¥%@待确认）", model.proxy_order_money, model.proxy_order_money_confirm, model.proxy_order_money_need_confirm];
    [self setLineSpace:BF_ScaleHeight(4.5) headIndent:0 text:_totalMoneyLabel.text label:_totalMoneyLabel];
    [_totalMoneyLabel sizeToFit];
    
    //self.instructionLabel.frame = CGRectMake(BF_ScaleWidth(5), CGRectGetMaxY(self.totalMoneyLabel.frame)+BF_ScaleHeight(4.5), BF_ScaleWidth(300), BF_ScaleHeight(70));
    
    
}





- (void)setLineSpace:(CGFloat)lineSpace  headIndent:(CGFloat)headIndent text:(NSString *)text label:(UILabel *)lable{
    NSMutableAttributedString *detailAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *detailParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [detailParagraphStyle setLineSpacing:lineSpace];//调整行间距
    [detailParagraphStyle setFirstLineHeadIndent:headIndent];
    [detailAttributedString addAttribute:NSParagraphStyleAttributeName value:detailParagraphStyle range:NSMakeRange(0, [text length])];
    lable.attributedText = detailAttributedString;
}


@end
