//
//  BFGroupDetailProductCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/30.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailProductCell.h"

@interface BFGroupDetailProductCell()
/**商品图片*/
@property (nonatomic, strong) UIImageView *cover;
/**商品图片*/
@property (nonatomic, strong) UIImageView *productIcon;
/**商品标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**商品拼团人数*/
@property (nonatomic, strong) UILabel *teamNumber;

@end


@implementation BFGroupDetailProductCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"myOrder";
    BFGroupDetailProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFGroupDetailProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCell];
    }
    return self;
}

- (void)setDetailModel:(BFGroupDetailModel *)detailModel {
    _detailModel = detailModel;
    if (detailModel) {
        if ([detailModel.status isEqualToString:@"1"]) {
            self.cover.image = [UIImage imageNamed:@"group_detail_group_success"];
        }else if ([detailModel.status isEqualToString:@"2"]) {
            self.cover.image = [UIImage imageNamed:@"group_detail_group_fail"];
        }
    }
}

- (void)setModel:(ItemModel *)model {
    _model = model;
    if (model) {
        [self.productIcon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        
        self.productTitle.text = model.title;
        
        self.teamNumber.text = [NSString stringWithFormat:@"%@人团：¥%@/件", model.team_num, model.team_price];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.teamNumber.text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(9)] range:NSMakeRange(model.team_num.length + 3,(self.teamNumber.text.length - model.team_num.length - 3))];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(17)] range:NSMakeRange(model.team_num.length + 4,model.team_price.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xD00000) range:NSMakeRange(model.team_num.length + 3,(self.teamNumber.text.length - model.team_num.length - 3))];
        self.teamNumber.attributedText = attributedString;

    }
    
}

- (void)setCell {
    UIView *firstLine = [UIView drawLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [self addSubview:firstLine];
    
    self.cover = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(210), 0, BF_ScaleWidth(90), BF_ScaleHeight(110))];
    self.cover.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.cover];
    
    self.productIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(90), BF_ScaleHeight(90))];
    self.productIcon.image = [UIImage imageNamed:@"goodsImage"];
    [self addSubview:self.productIcon];
    
    
    self.productTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame)+BF_ScaleWidth(10), BF_ScaleHeight(20), BF_ScaleWidth(200), 0)];
    self.productTitle.numberOfLines = 0;
    self.productTitle.textColor = BFColor(0x444444);
    self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    self.productTitle.text = @"【早餐佳选】慕思妮慕丝蛋糕1000g 早餐点心";
    [self addSubview:self.productTitle];
    [self.productTitle sizeToFit];
    
    
    self.teamNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.productTitle.x, CGRectGetMaxY(self.productTitle.frame)+BF_ScaleHeight(10), BF_ScaleWidth(200), BF_ScaleHeight(20))];
    self.teamNumber.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.teamNumber.textColor = BFColor(0x444444);
    self.teamNumber.text = @"3人团：¥39.90/件";
    [self addSubview:self.teamNumber];
    
    
    
    
    
    
    UIView *secondLine = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleHeight(110)-0.5, ScreenWidth, 0.5)];
    [self addSubview:secondLine];
    
    
    
}

@end
