//
//  ClassCollectionViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "ViewController.h"
#import "ClassCollectionViewCell.h"
#import "UIImageView+WebCache.h"

#define x ((kScreenWidth-(fen_x))-5-5-5-5)/3
@interface ClassCollectionViewCell ()

@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,retain)UILabel *titleLabel;

@end

@implementation ClassCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, x, x)];
//        _imageView.backgroundColor = [UIColor greenColor];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), x, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:CGFloatX(14)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 2;
        
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_imageView];
        
    }
    return self;
}

- (void)setClassifcationOther:(ClassificationSubModel *)classifcation index:(NSInteger)index{
    if (index == 0) {
    self.titleLabel.text = classifcation.name;
    self.imageView.frame = CGRectMake(0, 0, x, x);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:classifcation.imageUrl] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
//    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), x, 30);
    }else{
        self.titleLabel.text = @"全部";
        self.imageView.frame = CGRectMake(15, 15, x-30, x-30);
        self.imageView.image = [UIImage imageNamed:@"qbj.png"];
    }
    
}


@end
