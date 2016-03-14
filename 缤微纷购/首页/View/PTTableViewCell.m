//
//  PTTableViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/25.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "Height.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "PTTableViewCell.h"

@interface PTTableViewCell ()

@property (nonatomic,retain)UIView *backV;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UIImageView *logV;
@property (nonatomic,retain)UILabel *logLabel;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *infoLabel;
@property (nonatomic,retain)UIImageView *txImageV;
@property (nonatomic,retain)UILabel *moneyLabel;
@property (nonatomic,retain)UILabel *goLabel;

@end

@implementation PTTableViewCell





- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _backV = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 0)];
        _backV.backgroundColor = [UIColor whiteColor];
        _backV.layer.borderWidth = 1;
        _backV.layer.borderColor = [UIColor blackColor].CGColor;
        
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _backV.frame.size.width, kScreenWidth/2)];
        //        _imageV.backgroundColor = [UIColor greenColor];
        
        _logV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _logV.image = [UIImage imageNamed:@"f_1.png"];
//        _logV.layer.borderWidth = 2;
//        _logV.layer.borderColor = [UIColor redColor].CGColor;
//        _logV.layer.cornerRadius = 15;
//        _logV.layer.masksToBounds = YES;
//        _logV.backgroundColor = [UIColor greenColor];
        
        _logLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -5, 30, 30)];
        _logLabel.font = [UIFont systemFontOfSize:BF_ScaleWidth(9)];
//        _logLabel.layer.borderColor = [UIColor redColor].CGColor;
//        _logLabel.layer.borderWidth = 1;
        _logLabel.layer.cornerRadius = 15;
//        _logLabel.center = CGPointMake(25/2, 25/2);
        _logLabel.textAlignment = NSTextAlignmentCenter;
        _logLabel.layer.masksToBounds = YES;
        _logLabel.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_imageV.frame), _backV.frame.size.width-10, 0)];
//                _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.numberOfLines = 0;
        
        _infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_titleLabel.frame)+5, kScreenWidth-10, 0)];
//        _infoLabel.backgroundColor = [UIColor orangeColor];
        _infoLabel.font = [UIFont systemFontOfSize:13];
        _infoLabel.numberOfLines = 0;
        _infoLabel.textColor = [UIColor grayColor];
        [_infoLabel sizeToFit];
        
        _goLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_backV.frame)-kScreenWidth/4-20, CGRectGetMaxY(_infoLabel.frame)+10, kScreenWidth/4, 30)];
        _goLabel.backgroundColor = [UIColor redColor];
        _goLabel.layer.cornerRadius = 15;
        _goLabel.layer.masksToBounds = YES;
        _goLabel.textAlignment = NSTextAlignmentCenter;
        _goLabel.text = @"  去开团 >";
        _goLabel.textColor = [UIColor whiteColor];
        _goLabel.font = [UIFont systemFontOfSize:CGFloatY(16)];

        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_goLabel.frame)-kScreenWidth/3+15, CGRectGetMaxY(_infoLabel.frame)+10, kScreenWidth/3, 30)];
        _moneyLabel.backgroundColor = [UIColor grayColor];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = [UIFont systemFontOfSize:CGFloatY(16)];
        
        _txImageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_moneyLabel.frame)-30, CGRectGetMaxY(_infoLabel.frame)+5, 40, 40)];
        _txImageV.image = [UIImage imageNamed:@"f_01.png"];
        //[_txImageV bringSubviewToFront:_moneyLabel];

        [_backV addSubview:_imageV];
        
        [_logLabel addSubview:_logV];
        [_backV addSubview:_titleLabel];
        [_backV addSubview:_infoLabel];
        [_backV addSubview:_goLabel];
        [_backV addSubview:_moneyLabel];
        [_backV addSubview:_txImageV];
        
        [self addSubview:_backV];
        [self addSubview:_logLabel];
    }
    return self;
}



- (void)setModel:(PTModel *)model {
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
    self.titleLabel.text = model.title;
    self.infoLabel.text = model.intro;
    [self.infoLabel sizeToFit];
    self.logLabel.text = model.team_discount;
    self.moneyLabel.text = [NSString stringWithFormat:@"  %@人团  %@",model.team_num,model.team_price];
    
    self.titleLabel.frame = CGRectMake(5, CGRectGetMaxY(_imageV.frame), _backV.frame.size.width-10, [Height heightString:self.titleLabel.text font:16]);
    self.infoLabel.frame = CGRectMake(5, CGRectGetMaxY(_titleLabel.frame)+5, kScreenWidth-30, [Height heightString:self.infoLabel.text font:13]);
    _goLabel.frame = CGRectMake(CGRectGetMaxX(_backV.frame)-kScreenWidth/4-20, CGRectGetMaxY(_infoLabel.frame)+10, kScreenWidth/4, 30);
    _moneyLabel.frame = CGRectMake(CGRectGetMinX(_goLabel.frame)-kScreenWidth/3+15, CGRectGetMaxY(_infoLabel.frame)+10, kScreenWidth/3, 30);
    _txImageV.frame = CGRectMake(CGRectGetMinX(_moneyLabel.frame)-30, CGRectGetMaxY(_infoLabel.frame)+5, 40, 40);
    _backV.height = CGRectGetMaxY(_moneyLabel.frame)+20;
    self.cellHeight = _backV.height;
    

}

- (void)setFrame:(CGRect)frame{
    frame.origin.y += 10;
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
