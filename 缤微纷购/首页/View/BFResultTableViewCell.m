//
//  BFResultTableViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/5/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "ViewController.h"
#import "BFResultTableViewCell.h"

@interface BFResultTableViewCell ()

@property (nonatomic,retain)UIImageView *img;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *stock;
@property (nonatomic,retain)UILabel *price;
@property (nonatomic,retain)UIButton *selectedBut;

@end

@implementation BFResultTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGFloatX(80), CGFloatX(80))];
//        _img.backgroundColor = [UIColor redColor];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_img.frame)+5, 0, kScreenWidth-_img.size.width-15, CGFloatX(30))];
//        _title.backgroundColor = [UIColor greenColor];
        _title.font = [UIFont systemFontOfSize:CGFloatX(16)];
        
        _stock = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_img.frame)+5, CGRectGetMaxY(_title.frame), kScreenWidth-_img.size.width-15, CGFloatX(30))];
//        _stock.backgroundColor = [UIColor orangeColor];
        _stock.font = [UIFont systemFontOfSize:CGFloatX(14)];
        _stock.textColor = rgb(220, 220, 220, 1.0);
        
        _price = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_img.frame)+5, CGRectGetMaxY(_stock.frame), (kScreenWidth-_img.size.width-15)/2, CGFloatX(30))];
//        _price.backgroundColor = [UIColor yellowColor];
        _price.textColor = [UIColor orangeColor];
        
        _buy = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-40, CGRectGetMaxY(_stock.frame), CGFloatX(40), CGFloatX(40))];
//        _buy.backgroundColor = [UIColor greenColor];
        [_buy setBackgroundImage:[UIImage imageNamed:@"bus.png"] forState:UIControlStateNormal];
        [_buy addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
        
        _cellHeigh = CGRectGetMaxY(_price.frame)+10;
        
        [self addSubview:_img];
        [self addSubview:_title];
        [self addSubview:_stock];
        [self addSubview:_price];
        [self addSubview:_buy];
    }
    return self;
}

- (void)setmodel:(BFSosoSubOtherModel *)model{
    NSLog(@"img = %@,title = %@",model.shopID,model.title);
    
    [_img sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
    _title.text = model.title;
    _stock.text = [NSString stringWithFormat:@"%@   %@",model.choose,model.color];
    _price.text = [NSString stringWithFormat:@"¥%@",model.price];
    
}

- (void)buy:(UIButton *)but{
    self.selectedBut.selected = NO;
    but.selected = YES;
    self.selectedBut = but;
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(resultDelegate:)]) {
        [self.delegate resultDelegate:but.tag];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
