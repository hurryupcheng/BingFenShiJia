//
//  MyorderTableViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "MyorderTableViewCell.h"

@interface MyorderTableViewCell ()

@property (nonatomic,retain)UIImageView *groubImageV;
@property (nonatomic,retain)UIImageView *whiteImage;
@property (nonatomic,retain)UILabel *timeLabel;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UILabel *numberLabel;
@property (nonatomic,retain)UILabel *moneyLabel;
@property (nonatomic,retain)UILabel *fareLabel;
@property (nonatomic,retain)UILabel *stateLabel;

@end

@implementation MyorderTableViewCell

- (UIImageView *)groubImageV{
    if (!_groubImageV) {
        _groubImageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth-10, 150)];
        _groubImageV.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.groubImageV];
    }
    return _groubImageV;
}

- (UIImageView *)whiteImage{
    if (!_whiteImage) {
        _whiteImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight)];
        _whiteImage.backgroundColor = [UIColor whiteColor];
        [self.groubImageV addSubview:self.whiteImage];
    }
    return _whiteImage;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _timeLabel.backgroundColor = [UIColor orangeColor];
        [self.groubImageV addSubview:self.timeLabel];
    }
    return _timeLabel;
}

- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 80, 80)];
        _imageV.backgroundColor = [UIColor redColor];
        [self.whiteImage addSubview:self.imageV];
    }
    return _imageV;
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame), 0, kScreenWidth-80, 25)];
        _numberLabel.backgroundColor = [UIColor greenColor];
        [self.whiteImage addSubview:self.numberLabel];
    }
    return _numberLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame), CGRectGetMaxY(self.numberLabel.frame), kScreenWidth-80, 25)];
        _moneyLabel.backgroundColor = [UIColor orangeColor];
        [self.whiteImage addSubview:self.moneyLabel];
    }
    return _moneyLabel;
}

- (UILabel *)fareLabel{
    if (!_fareLabel) {
        _fareLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame), CGRectGetMaxY(self.moneyLabel.frame), kScreenWidth-80, 25)];
        _fareLabel.backgroundColor = [UIColor greenColor];
        [self.whiteImage addSubview:self.fareLabel];
    }
    return _fareLabel;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame), CGRectGetMaxY(self.fareLabel.frame), kScreenWidth-80, 25)];
        _stateLabel.backgroundColor = [UIColor orangeColor];
        [self.whiteImage addSubview:self.stateLabel];
    }
    return _stateLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
