//
//  BFGroupDetailCaptainCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailCaptainCell.h"

@interface BFGroupDetailCaptainCell()
/**底部视图*/
@property (nonatomic, strong) UIImageView *bottomImageView;
/**头像*/
@property (nonatomic, strong) UIImageView *headIcon;
/**团长真牛*/
@property (nonatomic, strong) UIImageView *captainGood;
/**昵称*/
@property (nonatomic, strong) UILabel *nickName;
/**参团时间*/
@property (nonatomic, strong) UILabel *joinTime;
@end

@implementation BFGroupDetailCaptainCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFGroupDetailCaptainCell";
    BFGroupDetailCaptainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFGroupDetailCaptainCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xCACACA);
        [self setCell];
    }
    return self;
}
- (void)setDetailModel:(BFGroupDetailModel *)detailModel {
    _detailModel = detailModel;
    if (detailModel) {
        if ([detailModel.status isEqualToString:@"1"]) {
            self.captainGood.hidden = NO;
        }else {
            self.captainGood.hidden = YES;
        }
    }
}

- (void)setModel:(TeamList *)model {
    _model = model;
    if (model) {
        [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.user_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
        
        self.nickName.text = [NSString stringWithFormat:@"团长%@",model.nickname];
        
        self.joinTime.text = [NSString stringWithFormat:@"%@开团", [BFTranslateTime translateTimeIntoAccurateTime:model.addtime]];
    }
}

- (void)setCell {

    self.bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(15), ScreenWidth, BF_ScaleHeight(55))];
    //self.bottomImageView.backgroundColor = BFColor(0x4da800);
    self.bottomImageView.image = [UIImage imageNamed:@"group_detail_captain_border"];
    [self addSubview:self.bottomImageView];
    
    
    
    self.headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(17.5), BF_ScaleHeight(30), BF_ScaleHeight(30))];
    self.headIcon.layer.masksToBounds = YES;
    self.headIcon.layer.cornerRadius = BF_ScaleHeight(15);
    [self.bottomImageView addSubview:self.headIcon];
    
    
    self.nickName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame)+BF_ScaleWidth(10), BF_ScaleHeight(20), BF_ScaleWidth(200), BF_ScaleHeight(15))];
    self.nickName.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.nickName.textColor = BFColor(0xffffff);
    [self.bottomImageView addSubview:self.nickName];
    
    
    self.joinTime = [[UILabel alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(36), BF_ScaleWidth(305), BF_ScaleWidth(19))];
    self.joinTime.textAlignment = NSTextAlignmentRight;
    self.joinTime.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.joinTime.textColor = BFColor(0xffffff);
    [self.bottomImageView addSubview:self.joinTime];
    
    self.captainGood = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(100), BF_ScaleHeight(5), BF_ScaleHeight(80), BF_ScaleHeight(80))];
    self.captainGood.hidden = YES;
    self.captainGood.image = [UIImage imageNamed:@"group_detail_captain_good"];
    [self addSubview:self.captainGood];
    
    
    UIView *line = [UIView drawLineWithFrame:CGRectMake(BF_ScaleWidth(25), CGRectGetMaxY(self.bottomImageView.frame), 1, BF_ScaleHeight(20))];
    line.backgroundColor = BFColor(0xD5D5D6);
    [self addSubview:line];
    
}


@end
