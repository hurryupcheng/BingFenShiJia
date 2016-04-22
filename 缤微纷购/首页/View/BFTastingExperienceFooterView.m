//
//  BFTastingExperienceFooterView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/22.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFTastingExperienceFooterView.h"

@interface BFTastingExperienceFooterView()
/**已申请人数*/
@property (nonatomic, strong) UILabel *haveApply;
/**活到到期日期*/
@property (nonatomic, strong) UILabel *endDate;
@end

@implementation BFTastingExperienceFooterView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setModel:(BFTastingExperienceModel *)model {
    _model = model;
    if (model) {
        UIView *line = [UIView drawLineWithFrame:CGRectMake(ScreenWidth/2-0.5, BF_ScaleHeight(20), 1, BF_ScaleHeight(40))];
        line.backgroundColor = BFColor(0xB1B0BA);
        [self addSubview:line];
        
        
        UILabel *haveApplyLabel = [self setUpLabelWithFrame:CGRectMake(0, BF_ScaleHeight(20), BF_ScaleWidth(135), BF_ScaleHeight(12)) textAlimenment:NSTextAlignmentRight textColor:BFColor(0x9593A2) text:@"已申请"];
        [self addSubview:haveApplyLabel];
        
        UIImageView *haveApplyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(80), BF_ScaleHeight(18), BF_ScaleWidth(16), BF_ScaleHeight(16))];
        haveApplyImageView.image = [UIImage imageNamed:@"fire"];
        [self addSubview:haveApplyImageView];
        
        
        UIImageView *endDateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(185), BF_ScaleHeight(18), BF_ScaleWidth(16), BF_ScaleHeight(16))];
        endDateImageView.image = [UIImage imageNamed:@"date"];
        [self addSubview:endDateImageView];
        
        UILabel *endDateLabel = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(endDateImageView.frame)+BF_ScaleWidth(5), BF_ScaleHeight(20), BF_ScaleWidth(135), BF_ScaleHeight(12)) textAlimenment:NSTextAlignmentLeft textColor:BFColor(0x9593A2) text:@"到期日"];
        [self addSubview:endDateLabel];
        
        
        self.haveApply = [self setUpLabelWithFrame:CGRectMake(haveApplyImageView.x, BF_ScaleHeight(40), BF_ScaleWidth(50), BF_ScaleHeight(12)) textAlimenment:NSTextAlignmentLeft textColor:BFColor(0x262626) text:model.first_stock];
        [self addSubview:self.haveApply];
        
        self.endDate = [self setUpLabelWithFrame:CGRectMake(endDateImageView.x, BF_ScaleHeight(40), BF_ScaleWidth(150), BF_ScaleHeight(12)) textAlimenment:NSTextAlignmentLeft textColor:BFColor(0x262626) text:[BFTranslateTime translateTimeIntoMonthDayHour:model.endtime]];
        [self addSubview:self.endDate];
        
        
        UIButton *applyButton = [UIButton buttonWithType:0];
        applyButton.frame = CGRectMake(BF_ScaleWidth(100), CGRectGetMaxY(line.frame) + BF_ScaleHeight(15), BF_ScaleWidth(120), BF_ScaleHeight(30));
        applyButton.backgroundColor = BFColor(0xFD8627);
        [applyButton setTitle:@"申请" forState:UIControlStateNormal];
        [applyButton setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
        applyButton.layer.cornerRadius = BF_ScaleHeight(15);
        [applyButton addTarget:self action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:applyButton];
    }
}


- (void)apply {
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoApply)]) {
        [self.delegate gotoApply];
    }
}


- (UILabel *)setUpLabelWithFrame:(CGRect)frame textAlimenment:(NSTextAlignment)textAlimenment  textColor:(UIColor *)textColor text:(NSString *)text {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.numberOfLines = 0;
    label.textAlignment = textAlimenment;
    label.text = text;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    label.textColor = textColor;

    return label;
}


@end
