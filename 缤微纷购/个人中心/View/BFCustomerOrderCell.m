//
//  BFCustomerOrderCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFCustomerOrderCell.h"

@interface BFCustomerOrderCell()
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

@implementation BFCustomerOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFCustomerOrderCell";
    BFCustomerOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFCustomerOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
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


- (void)setModel:(BFCustomerOrderList *)model {
    _model = model;
    if (model) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
        //self.nickNameLabel.text = [NSString stringWithFormat:@"昵称：%@", model.nickname];
        self.recommendTimeLabel.text = [NSString stringWithFormat:@"推荐时间：%@", [BFTranslateTime translateTimeIntoAccurateChineseTime:model.add_time]];
        self.divideMoneyLabel.text = [NSString stringWithFormat:@"分成金额：%@", model.jiner];
    }
}

- (void)setCell {
    self.bgView = [UIView new];
    self.bgView.layer.shadowOpacity = 0.3;
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.borderColor = BFColor(0xD4D4D4).CGColor;
    self.bgView.layer.borderWidth = 1;
    //self.bgView.layer.cornerRadius = 5;
    self.bgView.backgroundColor = BFColor(0xffffff);
    [self.contentView addSubview:self.bgView];
    
    
    self.headImageView = [UIImageView new];
    self.headImageView.image = [UIImage imageNamed:@"100.jpg"];
    self.headImageView.layer.borderWidth = 1;
    self.headImageView.layer.borderColor = BFColor(0xA2A2A2).CGColor;
    [self.bgView addSubview:self.headImageView];
    
    
    self.nickNameLabel = [UILabel new];
    self.nickNameLabel.textColor = BFColor(0xA2A2A2);
    self.nickNameLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    self.nickNameLabel.text = @"昵称：哈哈";
    //_nickNameLabel.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:self.nickNameLabel];
    
    self.recommendTimeLabel = [UILabel new];
    self.recommendTimeLabel.textColor = BFColor(0xA2A2A2);
    self.recommendTimeLabel.text = @"推荐时间：asdasd";
    //_recommendTimeLabel.backgroundColor = [UIColor blueColor];
    self.recommendTimeLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    [self.bgView addSubview:self.recommendTimeLabel];
    
    self.divideMoneyLabel = [UILabel new];
    self.divideMoneyLabel.textColor = BFColor(0xA2A2A2);
    self.divideMoneyLabel.text = @"分成金额：0.3";
    //_divideMoneyLabel.backgroundColor = [UIColor greenColor];
    self.divideMoneyLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    [self.bgView addSubview:self.divideMoneyLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(5), ScreenWidth-BF_ScaleWidth(10), BF_ScaleHeight(100));
    self.headImageView.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(15), BF_ScaleWidth(70), BF_ScaleHeight(70));
    self.nickNameLabel.frame = CGRectMake(CGRectGetMaxX(self.headImageView.frame)+BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(225), BF_ScaleHeight(80)/3);
    
    self.recommendTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.headImageView.frame)+BF_ScaleHeight(10), CGRectGetMaxY(self.nickNameLabel.frame), BF_ScaleWidth(225), BF_ScaleHeight(80)/3);
    
    self.divideMoneyLabel.frame = CGRectMake(CGRectGetMaxX(self.headImageView.frame)+BF_ScaleHeight(10), CGRectGetMaxY(self.recommendTimeLabel.frame), BF_ScaleWidth(225), BF_ScaleHeight(80)/3);
}

@end
