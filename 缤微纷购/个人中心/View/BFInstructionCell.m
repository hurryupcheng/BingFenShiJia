//
//  BFInstructionCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFInstructionCell.h"

@interface BFInstructionCell()
/**头像*/
@property (nonatomic, strong) UIImageView *headImageView;
/**昵称*/
@property (nonatomic, strong) UILabel *nickNameLabel;
/**推荐时间*/
@property (nonatomic, strong) UILabel *recommendTimeLabel;
/**分成金额*/
@property (nonatomic, strong) UILabel *divideMoneyLabel;
/**背景View*/
@property (nonatomic, strong) UIView *bgView;

@end


@implementation BFInstructionCell



+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"InstructionCell";
    BFInstructionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFInstructionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
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

- (void)setUser:(BFUserModel *)user
{
    _user = user;
    if (_user) {
        self.nickNameLabel.text = [NSString stringWithFormat:@"昵称：%@",_user.name];
        self.recommendTimeLabel.text = [NSString stringWithFormat:@"推荐时间：%@",_user.time];
        self.divideMoneyLabel.text = [NSString stringWithFormat:@"分成金额：%@",_user.money];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(5), ScreenWidth-BF_ScaleWidth(10), BF_ScaleHeight(80));
    self.headImageView.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(10), BF_ScaleWidth(60), BF_ScaleHeight(60));
    self.nickNameLabel.frame = CGRectMake(CGRectGetMaxX(self.headImageView.frame)+BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(225), BF_ScaleHeight(10));
    
    self.recommendTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.headImageView.frame)+BF_ScaleHeight(10), CGRectGetMidY(self.headImageView.frame), BF_ScaleWidth(225), BF_ScaleHeight(10));
    
    self.divideMoneyLabel.frame = CGRectMake(CGRectGetMaxX(self.headImageView.frame)+BF_ScaleHeight(10), CGRectGetMaxY(self.headImageView.frame)-BF_ScaleHeight(10), BF_ScaleWidth(225), BF_ScaleHeight(10));
}



/**头像*/
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        _headImageView.image = [UIImage imageNamed:@"touxiang"];
        [self.bgView addSubview:_headImageView];
    }
    return _headImageView;
}

/**昵称*/
- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [UILabel new];
        _nickNameLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        //_nickNameLabel.backgroundColor = [UIColor redColor];
        [self.bgView addSubview:_nickNameLabel];
    }
    return _nickNameLabel;
}

/**推荐时间*/
- (UILabel *)recommendTimeLabel {
    if (!_recommendTimeLabel) {
        _recommendTimeLabel = [UILabel new];
        //_recommendTimeLabel.backgroundColor = [UIColor blueColor];
        _recommendTimeLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        [self.bgView addSubview:_recommendTimeLabel];
    }
    return _recommendTimeLabel;
}

/**分成金额*/
- (UILabel *)divideMoneyLabel {
    if (!_divideMoneyLabel) {
        _divideMoneyLabel = [UILabel new];
        //_divideMoneyLabel.backgroundColor = [UIColor greenColor];
        _divideMoneyLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        [self.bgView addSubview:_divideMoneyLabel];
    }
    return _divideMoneyLabel;
}
@end
