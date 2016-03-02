//
//  XQCollectionViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "ViewController.h"
#import "Header.h"
#import "XQCollectionViewCell.h"

@interface XQCollectionViewCell ()

@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *number;
@property (nonatomic,retain)UILabel *money;
@property (nonatomic,retain)UIImageView *shopp;

@end

@implementation XQCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    CGFloat x = (kScreenWidth-10-10-10)/2;
    if ([super initWithFrame:frame]) {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, x, x+75)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.layer.cornerRadius = 5;
    imageView.userInteractionEnabled = YES;
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, x-16, x-16)];
//        self.imageView.backgroundColor = [UIColor greenColor];
        self.imageView.layer.borderColor = rgb(245, 245, 245, 1.0).CGColor;
        self.imageView.layer.borderWidth = 1;
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imageView.frame), x-10, 45)];
        self.title.text = @"产品名称";
        self.title.font = [UIFont systemFontOfSize:CGFloatY(16)];
        self.title.numberOfLines = 2;
//        self.title.backgroundColor = [UIColor yellowColor];
        
//        self.number = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.title.frame), x-10, 25)];
//        self.number.text = @"规格";
//        self.number.textColor = [UIColor grayColor];
//        self.number.font = [UIFont systemFontOfSize:CGFloatY(13)];
//        self.number.backgroundColor = [UIColor greenColor];
        
        self.money = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.title.frame)+5, x-10, 30)];
//        self.money.backgroundColor = [UIColor grayColor];
        self.money.textColor = [UIColor orangeColor];
        
        self.shopp = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)-50, CGRectGetMaxY(self.title.frame)-5, 40, 40)];
        self.shopp.image = [UIImage imageNamed:@"bus.png"];
        
        [self.contentView addSubview:imageView];
        [imageView addSubview:self.imageView];
        [imageView addSubview:self.title];
//        [imageView addSubview:self.number];
        [imageView addSubview:self.money];
        [imageView addSubview:self.shopp];
        
    }
    return self;
}

- (void)setXQModel:(XQModel *)xqModel{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:xqModel.img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
    self.title.text = xqModel.title;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",xqModel.price]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:CGFloatY(22)] range:NSMakeRange(2, [xqModel.price length])];
    self.money.attributedText = str;
  
}

@end
