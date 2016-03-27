//
//  BFBottomHeaderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFBottomHeaderView.h"

@interface BFBottomHeaderView()

/**箭头图片*/
@property (nonatomic, strong) UIImageView *arrawImageView;
@end

@implementation BFBottomHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    _clickButton = [UIButton buttonWithType:0];
    _clickButton.tag = 10000;
    _clickButton.frame = CGRectMake(0, 0, ScreenWidth, 44);
    _clickButton.selected = NO;
    _clickButton.backgroundColor = BFColor(0xffffff);
    [_clickButton setTitleColor:BFColor(0x000000) forState:UIControlStateNormal];
    [_clickButton addTarget:self action:@selector(clickToLookDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_clickButton];
    
    
    _timeLabel = [UILabel new];
    _timeLabel.frame = CGRectMake(0, 0, ScreenWidth, 44);
    _timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(15)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    // _timeLabel.backgroundColor = BFColor(0xffffff);
    _timeLabel.layer.cornerRadius = 5;
    _timeLabel.layer.borderWidth = 1;
    _timeLabel.layer.shadowOffset = CGSizeMake(0, 0);
    _timeLabel.layer.shadowColor = BFColor(0x000000).CGColor;
    _timeLabel.layer.shadowOpacity = 0.3;
    _timeLabel.layer.borderColor = BFColor(0xD4D4D4).CGColor;
    _timeLabel.textColor = BFColor(0x000000);
    //_timeLabel.text = @"2016年01月";
    [self addSubview:_timeLabel];
    
    
    self.arrawImageView = [UIImageView new];
    self.arrawImageView.frame = CGRectMake(ScreenWidth-25, 0, 15, 44);
    self.arrawImageView.image = [UIImage imageNamed:@"arrow_select"];
    self.arrawImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.arrawImageView];

}


- (void)clickToLookDetail:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToChangeStatus:)]) {
        [self setArrowImageViewWithIfUnfold:sender.selected];
        [self.delegate clickToChangeStatus:sender];
    }
}

- (void)click {
    [self clickToLookDetail:self.clickButton];
}

/**
 *   设置图片箭头旋转
 */

-(void)setArrowImageViewWithIfUnfold:(BOOL)unfold
{
    double degree;
    if(unfold){
        degree = M_PI;
    } else {
        degree = 0;
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.arrawImageView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}


@end
