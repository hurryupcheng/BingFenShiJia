//
//  BFMyCouponsCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#define BGViewHeight   BF_ScaleHeight(90)
#import "BFMyCouponsCell.h"

@interface BFMyCouponsCell()
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**分割线*/
@property (nonatomic, strong) UIView *line;
/**优惠券类别*/
@property (nonatomic, strong) UIImageView *categoryImageView;
/**使用说明*/
@property (nonatomic, strong) UILabel *instructionLabel;
/**有效期至*/
@property (nonatomic, strong) UILabel *validDateLabel;
/**优惠价格*/
@property (nonatomic, strong) UILabel *priceLabel;
/**已使用，已过期覆盖层*/
@property (nonatomic, strong) UIImageView *usedImageView;
@end


@implementation BFMyCouponsCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    BFMyCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIntegral"];
    if (!cell) {
        cell = [[BFMyCouponsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyIntegral"];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        self.backgroundColor = [UIColor clearColor];
        [self setCell];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgImageView.frame = CGRectMake(0, 0, ScreenWidth, BGViewHeight);
    
    self.line.frame = CGRectMake(BF_ScaleWidth(12.5), BF_ScaleHeight(63), ScreenWidth - BF_ScaleWidth(25), 1);
    
    self.validDateLabel.frame = CGRectMake(BF_ScaleWidth(120), BF_ScaleHeight(40), BF_ScaleWidth(150), BF_ScaleHeight(14));
    
    self.instructionLabel.frame = CGRectMake(BF_ScaleWidth(53), CGRectGetMaxY(self.line.frame), BF_ScaleWidth(250), BF_ScaleHeight(26));
    
    self.priceLabel.frame = CGRectMake(BF_ScaleWidth(20), BF_ScaleHeight(8), BF_ScaleHeight(90), BF_ScaleHeight(55));
    
    self.categoryImageView.frame = CGRectMake(BF_ScaleWidth(260), BF_ScaleHeight(5), BF_ScaleWidth(33), BF_ScaleWidth(33));
    
    self.usedImageView.frame = CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(90));
}


- (void)setModel:(BFMyCouponsModel *)model {
    _model = model;
    self.instructionLabel.text = model.name;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.money];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.priceLabel.text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(45)] range:NSMakeRange(2,self.priceLabel.text.length-2)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(16)] range:NSMakeRange(0,2)];
    self.priceLabel.attributedText = attributedString;
    
    self.validDateLabel.text = [NSString stringWithFormat:@"有效期至：%@", [BFTranslateTime translateTimeIntoCurrurentDate:model.end_time]];
    //判断类型
    if ([model.offers_range isEqualToString:@"1"]) {
        self.categoryImageView.image = [UIImage imageNamed:@"tong"];
    }else if ([model.offers_range isEqualToString:@"2"]) {
        self.categoryImageView.image = [UIImage imageNamed:@"pin"];
    }else {
        self.categoryImageView.image = [UIImage imageNamed:@"te"];
        
    }
    //判断是否领取
    if ([model.is_used isEqualToString:@"0"]) {
        self.usedImageView.hidden = YES;
        self.bgImageView.image = [UIImage imageNamed:@"get"];

    }else {
        self.bgImageView.image = [UIImage imageNamed:@"use"];
        if ([model.status isEqualToString:@"1"]) {
            self.usedImageView.hidden = NO;
        }else {
            self.usedImageView.hidden = YES;
        }
    }
}

- (void)setCell {
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"get"]];
    [self addSubview:self.bgImageView];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = BFColor(0xADADAD);
    [self addSubview:self.line];
    
    self.validDateLabel = [[UILabel alloc] init];
    self.validDateLabel.text = @"有效期至：2016-02-20";
    self.validDateLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.validDateLabel.textColor = BFColor(0x797979);
    [self addSubview:self.validDateLabel];
    
    self.instructionLabel = [[UILabel alloc] init];
    self.instructionLabel.text = @"仅限购买10斤装洛川苹果使用";
    self.instructionLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.instructionLabel.textColor = BFColor(0x434343);
    [self addSubview:self.instructionLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.text = @"¥10";
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.textColor = BFColor(0xFD8627);
    [self addSubview:self.priceLabel];
    
    
    self.categoryImageView = [[UIImageView alloc] init];
    self.categoryImageView.image = [UIImage imageNamed:@"pin"];
    [self addSubview:self.categoryImageView];
    
    self.usedImageView = [[UIImageView alloc] init];
    self.usedImageView.image = [UIImage imageNamed:@"used"];
    [self addSubview:self.usedImageView];
    
}

@end
