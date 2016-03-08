//
//  BFAdvertisingExpenseInformationCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAdvertisingExpenseInformationCell.h"

@interface BFAdvertisingExpenseInformationCell()
/**背景view*/
@property (nonatomic, strong) UIView *bgView;
/**总佣金*/
@property (nonatomic, strong) UILabel *totalMoneyLabel;
/**说明*/
@property (nonatomic, strong) UILabel *instructionLabel;
@end

@implementation BFAdvertisingExpenseInformationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFAdvertisingExpenseInformation";
    BFAdvertisingExpenseInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFAdvertisingExpenseInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        self.bgView = [UIView new];
        self.bgView.layer.shadowOpacity = 0.3;
        self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
        self.bgView.layer.borderColor = BFColor(0xD4D4D4).CGColor;
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.cornerRadius = 5;
        self.bgView.backgroundColor = BFColor(0xffffff);
        [self.contentView addSubview:self.bgView];
    }
    return self;
}

- (void)setUser:(BFUserModel *)user {
    _user = user;
    if (_user) {
        self.totalMoneyLabel.text = [NSString stringWithFormat:@"本月客户订单总佣金:¥%@已确认",_user.total];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(5), ScreenWidth-BF_ScaleWidth(10), BF_ScaleHeight(80));
    self.totalMoneyLabel.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(10), self.bgView.width-BF_ScaleWidth(10), BF_ScaleHeight(10));
    self.instructionLabel.frame = CGRectMake(BF_ScaleWidth(5), CGRectGetMaxY(self.totalMoneyLabel.frame), self.totalMoneyLabel.width, BF_ScaleHeight(60));
}

/**总佣金*/
- (UILabel *)totalMoneyLabel {
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [UILabel new];
        _totalMoneyLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        //_totalMoneyLabel.backgroundColor = [UIColor redColor];
        [self.bgView addSubview:_totalMoneyLabel];
    }
    return _totalMoneyLabel;
}

/**说明*/
- (UILabel *)instructionLabel {
    if (!_instructionLabel) {
        _instructionLabel = [UILabel new];
        _instructionLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        _instructionLabel.text = @"说明:订单状态为【交易成功】的才能结算佣金，请在个人中心填写银行账号，以便商家打款。(此处仅显示最新50条订单信息)";
        _instructionLabel.numberOfLines = 3;
        //_instructionLabel.backgroundColor = [UIColor redColor];
        [self.bgView addSubview:_instructionLabel];
    }
    return _instructionLabel;
}

@end
