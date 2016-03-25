//
//  BFMyIntegralHeaderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyIntegralHeaderView.h"

@interface BFMyIntegralHeaderView()
@property (nonatomic, strong) UILabel *integeralLabel;

@end


@implementation BFMyIntegralHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xE5E6E7);
        [self setView];
    }
    return self;
}


- (void)setTotalScore:(NSString *)totalScore {
    _totalScore = totalScore;
    self.integeralLabel.text = totalScore;
}

- (void)setView{

    
    UIView *topLine = [UIView drawLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [self addSubview:topLine];
    
    UIView *bottomLine = [UIView drawLineWithFrame:CGRectMake(0, HeaderH-0.5, ScreenWidth, 0.5)];
    [self addSubview:bottomLine];
    
    
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(90), HeaderH) font:BF_ScaleFont(12) textColor:BFColor(0x000000) text:@"当前可用积分："];
    [self addSubview:titleLabel];
    
    self.integeralLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, BF_ScaleWidth(180), HeaderH) font:BF_ScaleFont(20) textColor:BFColor(0xFD8727) text:@"1001"];
    self.integeralLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(18)];
    [self addSubview:self.integeralLabel];
}

@end