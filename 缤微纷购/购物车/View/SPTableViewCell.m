//
//  SPTableViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "ViewController.h"
#import "SPTableViewCell.h"

@interface SPTableViewCell ()<UITextFieldDelegate>

@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *hetLabel;
@property (nonatomic,retain)UILabel *moneyLabel;

@end

@implementation SPTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.isEdit = NO;
        self.needV = [[UIButton alloc]initWithFrame:CGRectMake(10, self.contentView.frame.size.height/2+CGFloatY(25/2), CGFloatY(25), CGFloatY(25))];
        self.needV.backgroundColor = [UIColor redColor];
        self.needV.layer.cornerRadius = CGFloatY(25/2);
        self.needV.layer.masksToBounds = YES;
        [self.needV setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [self.needV setImage:[UIImage imageNamed:@"0"] forState:UIControlStateSelected];
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.needV.frame)+10, 5, 90, 90)];
        self.imageV.backgroundColor = [UIColor greenColor];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame)+5, 5, kScreenWidth-self.needV.width-self.imageV.width-70, 50)];
        self.titleLabel.backgroundColor = [UIColor orangeColor];
        
        self.hetLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame)+5, CGRectGetMaxY(self.titleLabel.frame), kScreenWidth-self.needV.width-self.imageV.width-70, 30)];
        self.hetLabel.backgroundColor = [UIColor greenColor];
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame)+5, CGRectGetMaxY(self.hetLabel.frame), kScreenWidth-self.needV.width-self.imageV.width-140, 30)];
        self.moneyLabel.backgroundColor = [UIColor orangeColor];
        
        self.close = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 5, 30, 30)];
        self.close.backgroundColor = [UIColor redColor];
        
        self.add = [[AddShopping alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.moneyLabel.frame), CGRectGetMaxY(self.hetLabel.frame), kScreenWidth, 30)];
        self.add.textF.userInteractionEnabled = NO;
        self.add.textF.text = @"1";
        
        [self.contentView addSubview:self.needV];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.hetLabel];
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.close];
        [self.contentView addSubview:self.add];

    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _add.textF = textField;
    if ([self isPureInt:_add.textF.text]) {
        if ([_add.textF.text integerValue] < 0) {
            _add.textF.text = @"1";
        }
    }else{
    _add.textF.text = @"1";
    }
   
    if ([_add.textF.text isEqualToString:@""] || [_add.textF.text isEqualToString:@"0"]) {
        _add.textF.text = @"1";
    }
    NSString *numTextF = _add.textF.text;
//    if ([numTextF intValue]>) {
//        <#statements#>
//    }
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner *scanner = [NSScanner scannerWithString:string];
    int val;
    return [scanner scanInt:&val] && [scanner isAtEnd];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
