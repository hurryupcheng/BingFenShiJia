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
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    //银行卡号
    UILabel *carNumberLabel = [self setUpLabelWithFrame:CGRectMake(MarginW, 0, ScreenWidth, LabelH) title:@"银行卡号:"];
    [self addSubview:carNumberLabel];
    
    self.cardNumberTX = [UITextField textFieldWithFrame:CGRectMake(MarginW, CGRectGetMaxY(carNumberLabel.frame) + MarginH, BF_ScaleWidth(290), TextFieldH) placeholder:@"请输入银行卡号"];
    self.cardNumberTX.text = userInfo.card_id;
    self.cardNumberTX.delegate = self;
    self.cardNumberTX.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.cardNumberTX];
    
    //银行卡开户人
    UILabel *nameLabel = [self setUpLabelWithFrame:CGRectMake(MarginW, CGRectGetMaxY(self.cardNumberTX.frame) + MarginH, ScreenWidth, LabelH) title:@"银行卡开户人:"];
    [self addSubview:nameLabel];
    
    self.nameTX = [UITextField textFieldWithFrame:CGRectMake(MarginW, CGRectGetMaxY(nameLabel.frame) + MarginH, BF_ScaleWidth(290), TextFieldH) placeholder:@"请输入银行卡开户人"];
    self.nameTX.text = userInfo.true_name;
    self.nameTX.delegate = self;
    self.nameTX.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.nameTX];
    
    
    //昵称:
    UILabel *nickNameLabel = [self setUpLabelWithFrame:CGRectMake(MarginW, CGRectGetMaxY(self.nameTX.frame) + MarginH, ScreenWidth, LabelH) title:@"昵称:"];
    [self addSubview:nickNameLabel];
    
    UIView *nickNameView = [[UIView alloc] initWithFrame:CGRectMake(MarginW, CGRectGetMaxY(nickNameLabel.frame) + MarginH, BF_ScaleWidth(290), TextFieldH)];
    //nickNameView.backgroundColor = [UIColor redColor];
    [self addSubview:nickNameView];
    
    self.nickName = [self setUpDetailLabelWithFrame:CGRectMake(0, 0, BF_ScaleWidth(290), TextFieldH)];
    BFLog(@"%@,%lu",userInfo.nickname, (unsigned long)userInfo.nickname.length);
    if (userInfo.nickname.length != 0) {
        self.nickName.textColor = BFColor(0x090909);
        self.nickName.text = [NSString stringWithFormat:@"   %@", userInfo.nickname];
    }else {
        self.nickName.text = @"   点击修改昵称";
        self.nickName.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToModify)];
        [self.nickName addGestureRecognizer:tap];
    }
    [nickNameView addSubview:self.nickName];
    
    //手机号码:
    UILabel *telephoneLabel = [self setUpLabelWithFrame:CGRectMake(MarginW, CGRectGetMaxY(nickNameView.frame) + MarginH, ScreenWidth, LabelH) title:@"手机号码:"];
    [self addSubview:telephoneLabel];
    
    UIView *telephoneView = [[UIView alloc] initWithFrame:CGRectMake(MarginW, CGRectGetMaxY(telephoneLabel.frame) + MarginH, BF_ScaleWidth(290), TextFieldH)];
    //telephoneView.backgroundColor = [UIColor redColor];
    [self addSubview:telephoneView];
    
    self.telephone = [self setUpDetailLabelWithFrame:CGRectMake(0, 0, BF_ScaleWidth(290), TextFieldH)];
    BFLog(@"%@,%lu",userInfo.tel, (unsigned long)userInfo.tel.length);
    if (userInfo.tel.length != 0) {
        self.telephone.textColor = BFColor(0x090909);
        self.telephone.text = [NSString stringWithFormat:@"   %@", userInfo.tel];
    }else {
        self.telephone.text = @"   点击修改手机号";
        self.telephone.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToBind)];
        [self.telephone addGestureRecognizer:tap];
    }
    [telephoneView addSubview:self.telephone];
}

- (void)clickToModify {
    BFLog(@"----");
    [BFNotificationCenter postNotificationName:@"gotoModifyNickname" object:nil];
}

- (void)clickToBind {
    BFLog(@"----");
    [BFNotificationCenter postNotificationName:@"gotoBindPhoneNumber" object:nil];
}

- (UILabel *)setUpDetailLabelWithFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = BFColor(0xC3C3C9);
    label.layer.borderColor = BFColor(0xC3C3C9).CGColor;
    label.layer.borderWidth = 1;
    label.layer.cornerRadius = 3;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];

    return label;
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
    return YES;
}

@end
