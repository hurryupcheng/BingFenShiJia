//
//  UILabel+Extension.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/2.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (UILabel *)labelWithFrame:(CGRect)frame font:(CGFloat)font textColor:(UIColor *)textColor text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = textColor;
    //label.backgroundColor = [UIColor greenColor];
    label.font = [UIFont systemFontOfSize:font];
    label.text = text;
    return label;
}
@end
