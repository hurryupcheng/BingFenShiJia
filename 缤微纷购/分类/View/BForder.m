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

- (instancetype)initWithFrame:(CGRect)frame img:(NSString *)img title:(NSString *)title money:(NSString *)money guige:(NSString *)guige number:(NSString *)number color:(NSString *)color{
    if ([super initWithFrame:frame]) {
        
       UIImageView *imge = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth/4, kScreenWidth/4)];
        [imge sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
        
       UILabel *titles = [[UILabel alloc]init];
       titles.text = title;
       titles.frame = CGRectMake(CGRectGetMaxX(imge.frame)+5, 5, (self.frame.size.width-(kScreenWidth/4))-50,[Height heightString:title font:CGFloatX(14)]);
       titles.numberOfLines = 2;
       titles.font = [UIFont systemFontOfSize:CGFloatX(15)];
        [titles sizeToFit];
//        self.title.backgroundColor = [UIColor redColor];
  
       UILabel *guiges = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imge.frame)+5, CGRectGetMaxY(titles.frame)+5, (self.frame.size.width-(kScreenWidth/4))-50, 15)];
        guiges.text = [NSString stringWithFormat:@"%@  %@",color,guige];
        guiges.font = [UIFont systemFontOfSize:CGFloatX(14)];
        guiges.textColor = [UIColor grayColor];
//        self.guige.backgroundColor = [UIColor greenColor];

       UILabel *moneys = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imge.frame)+5, CGRectGetMaxY(guiges.frame), kScreenWidth, self.frame.size.height-titles.size.height-guiges.frame.size.height)];
        double price = [money doubleValue];
        moneys.text = [NSString stringWithFormat:@"¥%.2f",price];
        moneys.textColor = [UIColor orangeColor];
//        self.money.backgroundColor = [UIColor orangeColor];
        
       UILabel *numbers = [[UILabel alloc]init];
       numbers.text = [NSString stringWithFormat:@"x %@",number];
       numbers.textColor = [UIColor grayColor];
//        self.number.backgroundColor = [UIColor greenColor];
       numbers.font = [UIFont systemFontOfSize:CGFloatX(15)];
        
        CGFloat width = [Height widthString:numbers.text font:[UIFont systemFontOfSize:CGFloatX(15)]];
        numbers.frame = CGRectMake(CGRectGetMaxX(self.frame)-width-15, (self.frame.size.height/2)-10, width, 30);
        
        [self addSubview:imge];
        [self addSubview:titles];
        [self addSubview:guiges];
        [self addSubview:moneys];
        [self addSubview:numbers];
    }
    return self;
}

@end
