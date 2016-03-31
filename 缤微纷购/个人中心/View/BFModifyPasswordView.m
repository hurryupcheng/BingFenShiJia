//
//  BFModifyPasswordView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFModifyPasswordView.h"
#import "MyMD5.h"

@interface BFModifyPasswordView()<UITextFieldDelegate>


@end

@implementation BFModifyPasswordView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    
    UIView *firstLine = [self setUpLineWithFrame:CGRectMake(0, BF_ScaleHeight(50), ScreenWidth, 0.5)];
    [self addSubview:firstLine];
    
    self.original = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(15), BF_ScaleHeight(50), ScreenWidth, BF_ScaleHeight(45)) image:nil placeholder:@"原密码"];
    self.original.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    self.original.delegate = self;
    self.original.secureTextEntry = YES;
    self.original.returnKeyType = UIReturnKeyNext;
    [self addSubview:self.original];
    
    UIView *secondLine = [self setUpLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.original.frame), ScreenWidth, 0.5)];
    [self addSubview:secondLine];
    
    self.setting = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(15), CGRectGetMaxY(self.original.frame), ScreenWidth, BF_ScaleHeight(45)) image:nil placeholder:@"设置新密码(至少六位)"];
    self.setting.delegate = self;
    self.setting.secureTextEntry = YES;
    self.setting.returnKeyType = UIReturnKeyNext;
    self.setting.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    [self addSubview:self.setting];
    
    UIView *thirdLine = [self setUpLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.setting.frame), ScreenWidth, 0.5)];
    [self addSubview:thirdLine];
    
    self.confirm = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(15), CGRectGetMaxY(self.setting.frame), ScreenWidth, BF_ScaleHeight(45)) image:nil placeholder:@"确认新密码"];
    self.confirm.delegate = self;
    self.confirm.secureTextEntry = YES;
    self.confirm.returnKeyType = UIReturnKeyDone;
    self.confirm.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    [self addSubview:self.confirm];
    
    UIView *fourthLine = [self setUpLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.confirm.frame), ScreenWidth, 0.5)];
    [self addSubview:fourthLine];
    
    
    UIButton *modifyPasswordButton = [UIButton buttonWithType:0];
    self.modifyPasswordButton = modifyPasswordButton;
    modifyPasswordButton.frame = CGRectMake(BF_ScaleWidth(85), CGRectGetMaxY(self.confirm.frame)+BF_ScaleHeight(10), BF_ScaleWidth(150), BF_ScaleHeight(30));
    [modifyPasswordButton setTitle:@"修改密码" forState:UIControlStateNormal];
    modifyPasswordButton.backgroundColor = BFColor(0xFD8627);
    modifyPasswordButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(15)];
    modifyPasswordButton.layer.cornerRadius = BF_ScaleHeight(15);
    [modifyPasswordButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:modifyPasswordButton];
    
}

- (void)click:(UIButton *)sender {
    [self endEditing:YES];
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (self.original.text.length == 0 || self.setting.text.length == 0 || self.confirm.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请完善信息"];
    }else if (![[MyMD5 md5:self.original.text] isEqualToString:userInfo.password]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"原密码错误"];
    }else if (self.setting.text.length < 6 || self.confirm.text.length < 6) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入最少六位数密码"];
    }else if (![self.setting.text isEqualToString:self.confirm.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"两次密码不一致,请重新输入"];
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickToModifyPasswordWithView:)]) {
            [self.delegate clickToModifyPasswordWithView:self];
        }
    }
}

- (UIView *)setUpLineWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = BFColor(0xD5D5D5);
    return line;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    BOOL retValue = NO;
    if (textField == self.original) {
        [self.setting becomeFirstResponder];
        retValue = NO;
    } else if (textField == self.setting)
    {
        [self.confirm becomeFirstResponder];
        retValue = NO;
    } else {
        [self.confirm resignFirstResponder];
    }
    return retValue;
}

@end
