//
//  BForder.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "Height.h"
#import "Header.h"
#import "BForder.h"

@implementation BForder

- (instancetype)initWithFrame:(CGRect)frame img:(NSString *)img title:(NSString *)title money:(NSString *)money guige:(NSString *)guige number:(NSString *)number{
    if ([super initWithFrame:frame]) {
        
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth/4, kScreenWidth/4)];
        [self.img sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
        
        self.title = [[UILabel alloc]init];
        self.title.text = title;
        self.title.frame = CGRectMake(CGRectGetMaxX(self.img.frame)+5, 5, (self.frame.size.width-(kScreenWidth/4))-50,[Height heightString:title font:CGFloatX(14)]);
        self.title.numberOfLines = 2;
        self.title.font = [UIFont systemFontOfSize:CGFloatX(15)];
        [self.title sizeToFit];
//        self.title.backgroundColor = [UIColor redColor];
        
        self.guige = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.img.frame)+5, CGRectGetMaxY(self.title.frame)+5, kScreenWidth, 15)];
        self.guige.text = guige;
        self.guige.font = [UIFont systemFontOfSize:CGFloatX(14)];
        self.guige.textColor = [UIColor grayColor];
//        self.guige.backgroundColor = [UIColor greenColor];
        
        self.money = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.img.frame)+5, CGRectGetMaxY(self.guige.frame), kScreenWidth, self.frame.size.height-self.title.size.height-self.guige.frame.size.height)];
        double price = [money doubleValue];
        self.money.text = [NSString stringWithFormat:@"¥%.2f",price];
        self.money.textColor = [UIColor orangeColor];
//        self.money.backgroundColor = [UIColor orangeColor];
        
        self.number = [[UILabel alloc]init];
        self.number.text = [NSString stringWithFormat:@"x %@",number];
        self.number.textColor = [UIColor grayColor];
//        self.number.backgroundColor = [UIColor greenColor];
        self.number.font = [UIFont systemFontOfSize:CGFloatX(15)];
        
        CGFloat width = [Height widthString:self.number.text font:[UIFont systemFontOfSize:CGFloatX(15)]];
        self.number.frame = CGRectMake(CGRectGetMaxX(self.frame)-width-15, (self.frame.size.height/2)-10, width, 30);
        
        [self addSubview:self.img];
        [self addSubview:self.title];
        [self addSubview:self.guige];
        [self addSubview:self.money];
        [self addSubview:self.number];
    }
    return self;
}

@end
