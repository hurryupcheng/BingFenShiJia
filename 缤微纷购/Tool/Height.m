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

@end
