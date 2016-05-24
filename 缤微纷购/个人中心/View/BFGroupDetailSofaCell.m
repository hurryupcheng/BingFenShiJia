//
//  BFGroupDetailSofaCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/24.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailSofaCell.h"

@interface BFGroupDetailSofaCell()
/**bottomView*/
@property (nonatomic, strong) UIView *bottomView;
/**bottomView*/
@property (nonatomic, strong) UIImageView *bottomImageView;
/***/
@property (nonatomic, strong) UIImageView *headIcon;

@property (nonatomic, strong) UILabel *nickName;

@property (nonatomic, strong) UILabel *joinTime;

@end

@implementation BFGroupDetailSofaCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFGroupDetailSofaCell";
    BFGroupDetailSofaCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFGroupDetailSofaCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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

- (void)setModel:(TeamList *)model {
    _model = model;
    BFLog(@"setModel----%@", model.nickname);
    if (model) {
        
        self.bottomImageView.image = [UIImage imageNamed:@"group_detail_sofa_border"];
        
        [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.user_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
        
        self.nickName.text = model.nickname;
        
        self.joinTime.text = [NSString stringWithFormat:@"%@参团", [BFTranslateTime translateTimeIntoAccurateTime:model.addtime]];
        
    }
}

- (void)setCell {
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(45))];
    self.bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:self.bottomView];
    
    self.headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(7.5), BF_ScaleHeight(30), BF_ScaleHeight(30))];
    self.headIcon.layer.masksToBounds = YES;
    self.headIcon.layer.cornerRadius = BF_ScaleHeight(15);
    [self.bottomView addSubview:self.headIcon];
    
    
    self.nickName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame)+BF_ScaleWidth(10), BF_ScaleHeight(12.5), BF_ScaleWidth(200), BF_ScaleHeight(15))];
    self.nickName.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.nickName.textColor = BFColor(0x0E0E0E);
    [self.bottomView addSubview:self.nickName];
    
    
    self.joinTime = [[UILabel alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(26), BF_ScaleWidth(305), BF_ScaleWidth(19))];
    self.joinTime.textAlignment = NSTextAlignmentRight;
    self.joinTime.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.joinTime.textColor = BFColor(0x8C8C8C);
    [self.bottomView addSubview:self.joinTime];
    
    self.bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(48))];
    [self addSubview:self.bottomImageView];
    
    UIView *line = [UIView drawLineWithFrame:CGRectMake(BF_ScaleWidth(25), CGRectGetMaxY(self.bottomView.frame), 1, BF_ScaleHeight(20))];
    line.backgroundColor = BFColor(0xD5D5D6);
    [self addSubview:line];
    
}


@end
