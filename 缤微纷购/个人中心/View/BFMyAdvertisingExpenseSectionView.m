//
//  BFMyAdvertisingExpenseSectionView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyAdvertisingExpenseSectionView.h"

@interface BFMyAdvertisingExpenseSectionView()
/**时间日期label*/
@property (nonatomic, strong) UILabel *timeLabel;
/**按钮*/
@property (nonatomic, strong) UIButton *clickButton;
/**箭头图片*/
@property (nonatomic, strong) UIImageView *arrawImageView;
@end


@implementation BFMyAdvertisingExpenseSectionView

+ (BFMyAdvertisingExpenseSectionView *)myHeadViewWithTableView:(UITableView *)tableView {
    static NSString * JFHeaderViewID = @"headerView";
    BFMyAdvertisingExpenseSectionView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:JFHeaderViewID];
    if (headView == nil) {
        headView = [[BFMyAdvertisingExpenseSectionView alloc]initWithReuseIdentifier:JFHeaderViewID];
        
        //headView.contentView.backgroundColor = BFColor(0xffffff);
    }
    return headView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    return self;
}

-(void)setGroup:(BFMyAdvertisingExpenseModel *)group {
    _group = group;
    if (_group) {
        //self.timeLabel.text = group.date;
        [self.clickButton setTitle:group.date forState:UIControlStateNormal];
            //BFLog(@"clickToLookDetail,,%d,,%d",group.isOpen,!group.isOpen);
        [self setArrowImageViewWithIfUnfold:self.group.isOpen];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.timeLabel.frame = CGRectMake(BF_ScaleWidth(5), BF_ScaleWidth(5), ScreenWidth-BF_ScaleWidth(10), 44-BF_ScaleWidth(10));
    self.clickButton.frame = CGRectMake(0, 0, ScreenWidth, 44);
    self.arrawImageView.frame = CGRectMake(ScreenWidth-44, 0, 44, 44);
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
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
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)clickButton {
    if (!_clickButton) {
        _clickButton = [UIButton buttonWithType:0];
        _clickButton.backgroundColor = BFColor(0xffffff);
        [_clickButton setTitleColor:BFColor(0x000000) forState:UIControlStateNormal];
        [_clickButton addTarget:self action:@selector(clickToLookDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_clickButton];
    }
    return _clickButton;
}

- (UIImageView *)arrawImageView {
    if (!_arrawImageView) {
        _arrawImageView = [UIImageView new];
        _arrawImageView.image = [UIImage imageNamed:@"select_right"];
        _arrawImageView.contentMode = UIViewContentModeCenter;
        [_clickButton addSubview:_arrawImageView];
    }
    return _arrawImageView;
}

- (void)clickToLookDetail:(UIButton *)sender {
    self.group.isOpen = !self.group.isOpen;
    //self.group.isOpen = sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(myAdvertisingExpenseSectionView:didButton:)]) {
        [self.delegate myAdvertisingExpenseSectionView:self didButton:sender];
    }
    BFLog(@"点击了");
}

/**
 *   设置图片箭头旋转
 */

-(void)setArrowImageViewWithIfUnfold:(BOOL)unfold
{
    double degree;
    if(unfold){
        degree = M_PI/2;
    } else {
        degree = 0;
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.arrawImageView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}

@end
