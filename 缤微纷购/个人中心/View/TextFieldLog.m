//
//  TextFieldLog.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "TextFieldLog.h"

@implementation TextFieldLog

- (id)initWithFrame:(CGRect)frame imageV:(NSString *)img placeholder:(NSString *)plac string:(NSString *)str{

    if ([super initWithFrame:frame]) {
        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        images.image = [UIImage imageNamed:img];
        
        self.text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(images.frame)+10, 0, kScreenWidth-120, 30)];
        self.text.placeholder = plac;
        self.text.text = str;
        self.text.delegate = self;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.text.frame), kScreenWidth-120, 1)];
        label.backgroundColor = [UIColor grayColor];
        
        [self addSubview:images];
        [self addSubview:self.text];
        [self addSubview:label];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.text resignFirstResponder];
    return YES;
}

@end
