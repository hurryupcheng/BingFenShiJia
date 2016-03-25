//
//  BFMyCustomerCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#define MarginW       BF_ScaleWidth(5)
#define MarginH       BF_ScaleHeight(5)
#define LabelHeight   BF_ScaleHeight(27)
#import "BFMyCustomerCell.h"

@interface BFMyCustomerCell()
/**头像*/
@property (nonatomic, strong) UIImageView *headIcon;
/**昵称*/
@property (nonatomic, strong) UILabel *nickName;
/**加入时间*/
@property (nonatomic, strong) UILabel *joinTime;
/**团队人数*/
@property (nonatomic, strong) UILabel *memberCount;
/**底部视图*/
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation BFMyCustomerCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *ID = @"BFMyCustomerCell";
    BFMyCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFMyCustomerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xEBEBEB);
        [self setCell];
    }
    return self;
}

- (void)setModel:(BFCustomerList *)model {
    _model = model;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.user_icon] placeholderImage:[UIImage imageNamed:@"touxiang1"]];
    self.nickName.text = [NSString stringWithFormat:@"昵称：%@", model.nickname];
    self.joinTime.text = [NSString stringWithFormat:@"加入时间：%@", [BFTranslateTime translateTimeIntoAccurateChineseTime:model.reg_time]];
    self.memberCount.text = [NSString stringWithFormat:@"团队人数：%@", model.sub_team_num];
}

- (void)setCell {
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.frame = CGRectMake(MarginW, BF_ScaleHeight(10), BF_ScaleWidth(310), BF_ScaleHeight(100));
    self.bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:self.bottomView];
    
    self.headIcon = [[UIImageView alloc] init];
    self.headIcon.frame = CGRectMake(MarginW, MarginH, BF_ScaleHeight(80), BF_ScaleHeight(80));
    self.headIcon.image = [UIImage imageNamed:@"touxiang"];
    [self.bottomView addSubview:self.headIcon];
    
    
    self.nickName = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame)+BF_ScaleWidth(10), MarginH, BF_ScaleWidth(200), LabelHeight) text:@"昵称：bingo_1458497374"];
    
    self.joinTime = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame)+BF_ScaleWidth(10), CGRectGetMaxY(self.nickName.frame), BF_ScaleWidth(210), LabelHeight) text:@"加入时间：2016年03月21日02时09分"];
    
    self.memberCount = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame)+BF_ScaleWidth(10), CGRectGetMaxY(self.joinTime.frame), BF_ScaleWidth(200), LabelHeight) text:@"团队人数：0"];
    
    
    
}
- (UILabel *)setUpLabelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    label.textColor = BFColor(0x3A3A3A);
    label.text = text;
    //label.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:label];
    return label;
}

@end
