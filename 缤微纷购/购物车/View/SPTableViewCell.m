//
//  SPTableViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Height.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "ViewController.h"
#import "SPTableViewCell.h"

@interface SPTableViewCell ()<UITextFieldDelegate>

@property (nonatomic,retain)UIButton *needV;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *hetLabel;
@property (nonatomic,retain)UILabel *moneyLabel;

@end

@implementation SPTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.needV = [[UIButton alloc]initWithFrame:CGRectMake(10, self.contentView.frame.size.height/2+CGFloatY(25/2), CGFloatY(25), CGFloatY(25))];
        self.needV.layer.cornerRadius = CGFloatY(25/2);
        self.needV.layer.masksToBounds = YES;
        [self.needV setImage:[UIImage imageNamed:@"gx02.png"] forState:UIControlStateNormal];
        [self.needV setImage:[UIImage imageNamed:@"gx01.png"] forState:UIControlStateSelected];
        [self.needV addTarget:self action:@selector(selectButClick:) forControlEvents:UIControlEventTouchUpInside];
        self.needV.selected = self.isSelected;
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.needV.frame)+10, 5, CGFloatX(80), CGFloatX(80))];
//        self.imageV.backgroundColor = [UIColor greenColor];
        self.imageV.layer.borderWidth = 1;
        self.imageV.layer.borderColor = [UIColor grayColor].CGColor;
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame)+5, 5, kScreenWidth-self.needV.width-self.imageV.width-70, 0)];
        self.titleLabel.font = [UIFont systemFontOfSize:CGFloatY(15)];
        self.titleLabel.numberOfLines = 2;
        
        self.hetLabel = [[UILabel alloc]init];
//        self.hetLabel.text = @"111";
//        self.hetLabel.backgroundColor = [UIColor greenColor];
        
        self.moneyLabel = [[UILabel alloc]init];
//        self.moneyLabel.backgroundColor = [UIColor orangeColor];
        self.moneyLabel.textColor = [UIColor orangeColor];
        
        self.close = [[UIButton alloc]init];
        [self.close setBackgroundImage:[UIImage imageNamed:@"guanbis.png"] forState:UIControlStateNormal];
        
        self.add = [[AddShopping alloc]init];
        self.add.textF.userInteractionEnabled = NO;
//        self.add.backgroundColor = [UIColor yellowColor];
        
        [self.add.maxBut addTarget:self action:@selector(maxButton) forControlEvents:UIControlEventTouchUpInside];
        [self.add.minBut addTarget:self action:@selector(minButton) forControlEvents:UIControlEventTouchUpInside];
        
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
// 选中点击事件
- (void)selectButClick:(UIButton *)button{
    button.selected = !button.selected;
    if (self.selBlock) {
        self.selBlock(button.selected);
    }
}
// 添加
- (void)maxButton{
    if (self.numAddBlock) {
        self.numAddBlock();
    }

}

// 减少
- (void)minButton{
    if (self.numCutBlock) {
        self.numCutBlock();
    }
}

- (void)reloadDataWith:(BFStorage *)model{

    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
    self.titleLabel.text = model.title;
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame)+5, 5, kScreenWidth-self.needV.width-self.imageV.width-70, [Height heightString:model.title font:CGFloatY(17)]);
    [self.titleLabel sizeToFit];
    
    self.hetLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame)+5, CGRectGetMaxY(self.titleLabel.frame), kScreenWidth-self.needV.width-self.imageV.width-70, CGFloatY(30));
    
    self.moneyLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame)+5, CGRectGetMaxY(self.hetLabel.frame), kScreenWidth-self.needV.width-self.imageV.width-150, CGFloatY(30));

    self.close.frame = CGRectMake(CGRectGetMaxX(self.frame)-25, 5, CGFloatX(20), CGFloatX(20));
    
    self.add.frame = CGRectMake(CGRectGetMaxX(self.moneyLabel.frame), CGRectGetMaxY(self.hetLabel.frame), kScreenWidth, CGFloatY(35));
//    self.add.backgroundColor = [UIColor redColor];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥ %@",model.money];

    self.add.textF.text = [NSString stringWithFormat:@"%d",model.numbers];
    self.hetLabel.text = model.spec;
    self.needV.selected = self.isSelected;
    self.cellHeight = CGRectGetMaxY(self.add.frame)+10;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
