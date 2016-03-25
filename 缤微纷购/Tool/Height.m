//
//  Height.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "Height.h"

@implementation Height

+ (CGFloat)heightString:(NSString *)str font:(NSInteger)font{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kScreenWidth-10, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
 
}

+ (CGFloat)widthString:(NSString *)str font:(UIFont *)font{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10000, 0)];
    label.text = str;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

@end
