//
//  BFCouponView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "ViewController.h"
#import "BFCouponView.h"

@implementation BFCouponView

- (instancetype)initWithFrame:(CGRect)frame type:(NSMutableArray *)type name:(NSMutableArray *)name price:(NSMutableArray *)price end:(NSMutableArray *)end{
    if ([super initWithFrame:frame]) {
        for (int i = 0; i < name.count; i++) {
            self.couponBt = [[UIButton alloc]initWithFrame:CGRectMake(0, CGFloatY(90)*i+(i*10), kScreenWidth, CGFloatY(90))];
            [_couponBt setBackgroundImage:[UIImage imageNamed:@"use"] forState:UIControlStateNormal];
            self.couponBt.tag = i;
            [_couponBt addTarget:self action:@selector(bt:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, CGFloatX(100)+10, CGFloatX(60))];
            if ([type[i] isEqualToString:@"1"]) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",price[i]]];
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:CGFloatX(42)] range:NSMakeRange(1, [price[i] length])];
                money.attributedText = str;
            }else {
                if ([price[i] hasSuffix:@"0"]) {
                    //self.priceLabel.text = [NSString stringWithFormat:@"%.0f折",[model.discount floatValue]];
                    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.0f折",[price[i] floatValue]]];
                    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:CGFloatX(42)] range:NSMakeRange(0, [price[i] length]-2)];
                    money.attributedText = str;
                }else {
                    //self.priceLabel.text = [NSString stringWithFormat:@"%.1f折",[model.discount floatValue]];
                    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.1f折",[price[i] floatValue]]];
                    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:CGFloatX(42)] range:NSMakeRange(0, [price[i] length])];
                    money.attributedText = str;
                }

                
            }
            
 
            
//            money.backgroundColor = [UIColor redColor];
            
            money.textColor = [UIColor orangeColor];
            money.textAlignment = NSTextAlignmentRight;
            
            UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(money.frame)+13, self.couponBt.size.height/2-CGFloatX(12), kScreenWidth, CGFloatX(30))];
            
            NSDateFormatter *date = [[NSDateFormatter alloc]init];
            [date setDateFormat:@"yyyy-MM-dd"];
            NSDate *times = [NSDate dateWithTimeIntervalSince1970:[end[i] doubleValue]];
            
            //NSLog(@"%@",times);
            NSString *strs = [date stringFromDate:times];
            time.text = [NSString stringWithFormat:@"有效期至: %@",strs];
            time.font = [UIFont systemFontOfSize:CGFloatX(16)];
        
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(money.frame)+3, kScreenWidth-60, CGFloatX(25))];
//            title.backgroundColor = [UIColor greenColor];
            title.text = name[i];
            title.font = [UIFont systemFontOfSize:CGFloatX(16)];
            title.textColor = [UIColor blackColor];
            
            [self addSubview:_couponBt];
            [_couponBt addSubview:money];
            [_couponBt addSubview:time];
            [_couponBt addSubview:title];
        }
        self.height = CGRectGetMaxY(_couponBt.frame)+10;
    }
    return self;
}

- (void)bt:(UIButton *)but{
    if (self.couponDelegate != nil && [self.couponDelegate respondsToSelector:@selector(BFCouponViewDelegate:index:)]) {
        [self.couponDelegate BFCouponViewDelegate:self index:but.tag];
    }
}

@end
