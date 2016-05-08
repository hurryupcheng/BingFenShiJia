//
//  BFRecommendDividedCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/25.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFRecommendDividedCell.h"

@interface BFRecommendDividedCell()
/**背景view*/
@property (nonatomic, strong) UIView *bgView;
/**总佣金*/
@property (nonatomic, strong) UILabel *totalMoneyLabel;
/**说明*/
@property (nonatomic, strong) UILabel *instructionLabel;

@end


@implementation BFRecommendDividedCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFRecommendDividedCell";
    BFRecommendDividedCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFRecommendDividedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(BFRecommendDividedModel *)model {
    _model = model;
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"本月推荐分成总佣金：¥%@已确认",model.proxy_order_money_confirm];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        self.bgView = [UIView new];
        self.bgView.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(4.5), BF_ScaleWidth(310), BF_ScaleHeight(85));
        self.bgView.layer.shadowOpacity = 0.3;
        self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
        self.bgView.layer.borderColor = BFColor(0xD4D4D4).CGColor;
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.cornerRadius = 5;
        self.bgView.backgroundColor = BFColor(0xffffff);
        [self.contentView addSubview:self.bgView];
        
        
        _totalMoneyLabel = [UILabel new];
        self.totalMoneyLabel.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(10), BF_ScaleWidth(300), 0);
        _totalMoneyLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        _totalMoneyLabel.numberOfLines = 0;
        _totalMoneyLabel.text = [NSString stringWithFormat:@"本月推荐分成总佣金：¥0.00已确认"];
        
        //_totalMoneyLabel.backgroundColor = [UIColor redColor];
        [self.bgView addSubview:_totalMoneyLabel];
        [self.totalMoneyLabel sizeToFit];
        
        
        
        _instructionLabel = [UILabel new];
        self.instructionLabel.frame = CGRectMake(BF_ScaleWidth(5), CGRectGetMaxY(self.totalMoneyLabel.frame)+BF_ScaleHeight(4.5), BF_ScaleWidth(300), 0);
        _instructionLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        _instructionLabel.text = @"说明：请在个人中心填写银行账号,以便商家打款。(此处仅显示最新20条订单信息)";
        _instructionLabel.numberOfLines = 0;
        [self setLineSpace:BF_ScaleHeight(4.5) headIndent:0 text:_instructionLabel.text label:_instructionLabel];
        //_instructionLabel.backgroundColor = [UIColor greenColor];
        [self.bgView addSubview:_instructionLabel];
        [_instructionLabel sizeToFit];
        
        
    }
    return self;
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
