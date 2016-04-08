//
//  BFModifyBankDetailInfoView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#define LabelH      BF_ScaleHeight(15)
#define TextFieldH  BF_ScaleHeight(30)
#define MarginW     BF_ScaleWidth(15)
#define MarginH     BF_ScaleHeight(10)

#import "BFModifyBankDetailInfoView.h"

@interface BFModifyBankDetailInfoView()<UITextFieldDelegate>


@end

@implementation BFModifyBankDetailInfoView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor blueColor];
        [self setView];
    }
    return self;
}

- (void)setView {
    //银行卡号
    UILabel *carNumberLabel = [self setUpLabelWithFrame:CGRectMake(MarginW, 0, ScreenWidth, LabelH) title:@"银行卡号:"];
    [self addSubview:carNumberLabel];
    
    self.cardNumberTX = [UITextField textFieldWithFrame:CGRectMake(MarginW, CGRectGetMaxY(carNumberLabel.frame) + MarginH, BF_ScaleWidth(290), TextFieldH) placeholder:@"请输入银行卡号"];
    self.cardNumberTX.delegate = self;
    self.cardNumberTX.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.cardNumberTX];
    
    //银行卡开户人
    UILabel *nameLabel = [self setUpLabelWithFrame:CGRectMake(MarginW, CGRectGetMaxY(self.cardNumberTX.frame) + MarginH, ScreenWidth, LabelH) title:@"银行卡开户人:"];
    [self addSubview:nameLabel];
    
    self.nameTX = [UITextField textFieldWithFrame:CGRectMake(MarginW, CGRectGetMaxY(nameLabel.frame) + MarginH, BF_ScaleWidth(290), TextFieldH) placeholder:@"请输入银行卡开户人"];
    self.nameTX.delegate = self;
    self.nameTX.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.nameTX];
    
    
    //昵称:
    UILabel *nickNameLabel = [self setUpLabelWithFrame:CGRectMake(MarginW, CGRectGetMaxY(self.nameTX.frame) + MarginH, ScreenWidth, LabelH) title:@"昵称:"];
    [self addSubview:nickNameLabel];
    
    self.nickNameTX = [UITextField textFieldWithFrame:CGRectMake(MarginW, CGRectGetMaxY(nickNameLabel.frame) + MarginH, BF_ScaleWidth(290), TextFieldH) placeholder:@"请填写您的昵称"];
    self.nickNameTX.delegate = self;
    self.nickNameTX.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.nickNameTX];
    
    
    //手机号码:
    UILabel *telephoneLabel = [self setUpLabelWithFrame:CGRectMake(MarginW, CGRectGetMaxY(self.nickNameTX.frame) + MarginH, ScreenWidth, LabelH) title:@"手机号码:"];
    [self addSubview:telephoneLabel];
    
    self.telephoneTX = [UITextField textFieldWithFrame:CGRectMake(MarginW, CGRectGetMaxY(telephoneLabel.frame) + MarginH, BF_ScaleWidth(290), TextFieldH) placeholder:@"请输入手机号码"];
    self.telephoneTX.delegate = self;
    self.telephoneTX.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.telephoneTX];
    
    
    
}

- (UILabel *)setUpLabelWithFrame:(CGRect)frame title:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = BFColor(0x9D9D9D);
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(15)];
    label.text = title;
    return label;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.cardNumberTX resignFirstResponder];
    [self.nameTX resignFirstResponder];
    [self.nickNameTX resignFirstResponder];
    [self.telephoneTX resignFirstResponder];
    return YES;
}

@end
