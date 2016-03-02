//
//  TextFieldLog.h
//  缤微纷购
//
//  Created by 郑洋 on 16/2/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldLog : UIView<UITextFieldDelegate>

@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)NSString *string;
@property (nonatomic,retain)UITextField *text;

- (id)initWithFrame:(CGRect)frame imageV:(NSString *)img placeholder:(NSString *)plac string:(NSString *)str;

@end
