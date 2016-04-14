//
//  BFTimeView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define ViewH    BF_ScaleHeight(15)
#define MarginH  BF_ScaleHeight(5)
#import "BFTimeView.h"

@interface BFTimeView()
/**说明*/
@property (nonatomic, strong) UILabel *timeLabel;
/**时*/
@property (nonatomic, strong) UILabel *hour;
/**分*/
@property (nonatomic, strong) UILabel *minute;
/**秒*/
@property (nonatomic, strong) UILabel *second;

@end

@implementation BFTimeView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xFA8728);
    }
    return self;
}

- (void)setModel:(BFDailySpecialProductList *)model {
    _model = model;
    if (model) {
        UIImageView *clock = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(8), MarginH, BF_ScaleWidth(15), ViewH)];
        clock.image = [UIImage imageNamed:@"clock"];
        [self addSubview:clock];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(clock.frame)+BF_ScaleWidth(5), MarginH, BF_ScaleWidth(40), ViewH)];
        self.timeLabel.textColor = BFColor(0xffffff);
        self.timeLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        self.timeLabel.backgroundColor = BFColor(0x4da800);
        self.timeLabel.text = @"距开始";
        [self addSubview:self.timeLabel];
        
    }
}
@end
