//
//  BFScoreView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Height.h"
#import "Header.h"
#import "ViewController.h"
#import "BFScoreView.h"

@interface BFScoreView ()

@property (nonatomic,retain)NSString *str;
@property (nonatomic,retain)NSString *num;

@end

@implementation BFScoreView

- (instancetype)initWithFrame:(CGRect)frame num:(NSInteger)num{
    if ([super initWithFrame:frame]) {
        
        self.num = [NSString stringWithFormat:@"%d",num];
        
        UIView *black = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, 1)];
        black.backgroundColor = rgb(220, 220, 220, 1.0);
        
        UILabel *socreSay = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(black.frame)+5, kScreenWidth, 30)];
        socreSay.text = @"积分最多抵扣不超过订单金额(除运费外)的50%";
        socreSay.textColor = [UIColor grayColor];
        socreSay.font = [UIFont systemFontOfSize:CGFloatX(16)];
        
        UILabel *units = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-30, CGRectGetMaxY(socreSay.frame)+10, 30, 30)];
        units.text = @"元";
        units.textColor = rgb(0, 128, 0, 1.0);
        units.font = [UIFont systemFontOfSize:CGFloatX(17)];
        
        self.price = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(units.frame)-65, CGRectGetMaxY(socreSay.frame)+8, 60, 35)];
        self.price.textColor = rgb(0, 128, 0, 1.0);
        self.price.layer.borderColor = rgb(220, 220, 220, 1.0).CGColor;
        self.price.layer.cornerRadius = 7;
        self.price.layer.borderWidth = 1;
        self.price.textAlignment = NSTextAlignmentCenter;
        self.price.delegate = self;
        self.price.returnKeyType = UIReturnKeyDone;
        self.price.clearsOnBeginEditing = YES;
        
        UILabel *useScore = [[UILabel alloc]init];
        useScore.text = @"已抵扣(整数金额)";
        useScore.font = [UIFont systemFontOfSize:CGFloatX(17)];
        useScore.textColor = rgb(0, 128, 0, 1.0);
        
        CGFloat width = [Height widthString:useScore.text font:[UIFont systemFontOfSize:CGFloatX(17)]];
        useScore.frame = CGRectMake(CGRectGetMinX(self.price.frame)-width-5, CGRectGetMaxY(socreSay.frame)+10, width, 30);
        
        self.height = CGRectGetMaxY(self.price.frame)+20;
        
        [self addSubview:black];
        [self addSubview:socreSay];
        [self addSubview:units];
        [self addSubview:self.price];
        [self addSubview:useScore];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger number = [self.num integerValue];
    if ([self.price.text integerValue] >= number) {
        self.price.text = self.num;
        _scoreBlock(self.price.text);
    }else{
        _scoreBlock(self.price.text);
    }
    
    [textField resignFirstResponder];
    return YES;
}
// 判断输入的是否是数字
- (BOOL)validateNumberByRegExp:(NSString *)string {
    BOOL isValid = YES;
    NSUInteger len = string.length;

       if (len > 0) {
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
        isValid = [numberPredicate evaluateWithObject:string];
       }
    return isValid;
}

 #pragma mark - UITextFieldDelegate
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
     
    return [self validateNumberByRegExp:string];
}

@end
