//
//  UITextField+Extension.m
//  Flower
//
//  Created by 程召华 on 16/1/11.
//  Copyright © 2016年 readchen.com. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
+ (UITextField *)textFieldWithTarget:(id)target action:(SEL)action Frame:(CGRect)frame image:(NSString *)image placeholder:(NSString *)placeholder{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.width = BF_ScaleWidth(20);
    imageView.height = BF_ScaleHeight(20);
    imageView.image = [UIImage imageNamed:image];
    imageView.contentMode = UIViewContentModeCenter;
    
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placeholder;
    [textField setValue:BFColor(0x5F5F62) forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:BF_ScaleFont(11)] forKeyPath:@"_placeholderLabel.font"];
    textField.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    textField.leftView = imageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [textField addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return textField;
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame image:(NSString *)image placeholder:(NSString *)placeholder {
    if (image == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = BF_ScaleWidth(10);
        imageView.height = BF_ScaleWidth(15) ;
        imageView.image = [UIImage imageNamed:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UITextField *textField = [[UITextField alloc]initWithFrame:frame];
        textField.placeholder = placeholder;
        textField.leftView = imageView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        return textField;
    }else {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = BF_ScaleWidth(30);
        imageView.height = BF_ScaleWidth(15) ;
        imageView.image = [UIImage imageNamed:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UITextField *textField = [[UITextField alloc]initWithFrame:frame];
        textField.placeholder = placeholder;
        textField.font = [UIFont systemFontOfSize:BF_ScaleFont(16)];
        textField.leftView = imageView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        return textField;
    }
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.width = BF_ScaleWidth(10);
    imageView.height = BF_ScaleWidth(15) ;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.leftView = imageView;
    [textField setValue:BFColor(0xC3C3C9) forKeyPath:@"_placeholderLabel.textColor"];
    textField.layer.borderColor = BFColor(0xC3C3C9).CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 3;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    return textField;

}






@end
