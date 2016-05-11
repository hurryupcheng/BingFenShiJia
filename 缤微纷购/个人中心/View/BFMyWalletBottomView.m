//
//  BFMyWalletBottomView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#define LabelViewH         BF_ScaleHeight(40)
#define LabelViewMargin    BF_ScaleWidth(6)
#import "HZQRegexTestter.h"
#import "BFMyWalletBottomView.h"
#import "BFAgreeButton.h"

@interface BFMyWalletBottomView()<UITextFieldDelegate>{
    __block NSInteger leftTime;
    __block NSTimer *timer;
}

@property (nonatomic, strong) BFAgreeButton *agreeButton;

@property (nonatomic, strong) UIView *getCashView;
/**实付金额*/
@property (nonatomic, strong) UILabel *paidCashLabel;
/**确认提现*/
@property (nonatomic, strong) UIButton *getCashButton;

@end

@implementation BFMyWalletBottomView

- (void)setModel:(BFMyWalletModel *)model {
    _model = model;
    if (!model.true_name) {
        self.recieverLabel.text = @"收款人：";
    }else {
        self.recieverLabel.text = [NSString stringWithFormat:@"收款人：%@", model.true_name];
    }
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = BFColor(0xF2F4F5);
        //提现协议底部图
        UIView *protocalView = [self setUpViewWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(300), BF_ScaleHeight(140))];

        //提现协议
        UILabel *protocalLabel = [self setUpLabelWithSuperView:protocalView Frame:CGRectMake(BF_ScaleWidth(15), BF_ScaleHeight(10), BF_ScaleWidth(150), BF_ScaleHeight(14)) tetx:@"《提现协议》"];
        
        //协议第一条
        UILabel *firstLabel = [self setUpLabelWithSuperView:protocalView Frame:CGRectMake(BF_ScaleWidth(15),CGRectGetMaxY(protocalLabel.frame) + BF_ScaleHeight(8), BF_ScaleWidth(285), BF_ScaleHeight(14)) tetx:@"1、 每个用户每个月只能体现一次。"];
        
        //协议第二条
        UILabel *secondLabel = [self setUpLabelWithSuperView:protocalView Frame:CGRectMake(BF_ScaleWidth(15),CGRectGetMaxY(firstLabel.frame) + BF_ScaleHeight(8), BF_ScaleWidth(285), BF_ScaleHeight(29)) tetx:@"2、 每次提现不超过20000的将直接转账到个人的微信钱包。"];
        secondLabel.numberOfLines = 2;
        //协议第三条
        UILabel *thirdLabel = [self setUpLabelWithSuperView:protocalView Frame:CGRectMake(BF_ScaleWidth(15),CGRectGetMaxY(secondLabel.frame) + BF_ScaleHeight(8), BF_ScaleWidth(285), BF_ScaleHeight(14)) tetx:@"3、 申请提交后5个工作日内处理。"];
        
        //阅读按钮
        self.agreeButton = [[BFAgreeButton alloc] initWithFrame:CGRectMake(BF_ScaleWidth(15), CGRectGetMaxY(thirdLabel.frame) + BF_ScaleHeight(8), BF_ScaleWidth(180), BF_ScaleHeight(15))];
        if (!self.agreeButton.selected) {
            self.agreeButton.agreeImageView.image = [UIImage imageNamed:@"new_feature_share_false"];
        }else {
            self.agreeButton.agreeImageView.image = [UIImage imageNamed:@"new_feature_share_true"];
        }
        self.agreeButton.agreeTitleLabel.text = @"我已阅读并同意以上条款";
        //agreeButton.backgroundColor = [UIColor redColor];
        [self.agreeButton addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
        [protocalView addSubview:self.agreeButton];
        
        //提现金额底部视图
        self.getCashView = [self setUpViewWithFrame:CGRectMake(BF_ScaleWidth(10),CGRectGetMaxY(protocalView.frame)+ BF_ScaleHeight(6), BF_ScaleWidth(300), LabelViewH)];
        
        //提现金额label
        UILabel *getCashLabel = [self setUpLabelWithSuperView:self.getCashView Frame:CGRectMake(BF_ScaleWidth(15), 0, BF_ScaleWidth(60), LabelViewH) tetx:@"提现金额："];
        
        //提现金额输入框
        self.getCashTX = [UITextField textFieldWithFrame:CGRectMake(CGRectGetMaxX(getCashLabel.frame), BF_ScaleHeight(8), BF_ScaleWidth(150), BF_ScaleHeight(24)) image:nil placeholder:nil];
        self.getCashTX.delegate = self;
        self.getCashTX.returnKeyType = UIReturnKeyDone;
        self.getCashTX.layer.cornerRadius = 3;
        self.getCashTX.layer.borderWidth = 1;
        self.getCashTX.layer.borderColor = BFColor(0xDCDCDC).CGColor;
        [self.getCashTX addTarget:self action:@selector(change:) forControlEvents:UIControlEventEditingChanged];
        [self.getCashView addSubview:self.getCashTX];
        
        //实付金额底部视图
        UIView *paidCashView = [self setUpViewWithFrame:CGRectMake(BF_ScaleWidth(10),CGRectGetMaxY(self.getCashView.frame)+ LabelViewMargin, BF_ScaleWidth(300), LabelViewH)];
        
        //实付金额label
        self.paidCashLabel = [self setUpLabelWithSuperView:paidCashView Frame:CGRectMake(BF_ScaleWidth(15), 0, BF_ScaleWidth(260), LabelViewH) tetx:@"实付金额："];
        
        //收款人底部视图
        UIView *recieverView = [self setUpViewWithFrame:CGRectMake(BF_ScaleWidth(10),CGRectGetMaxY(paidCashView.frame)+ LabelViewMargin, BF_ScaleWidth(300), LabelViewH)];
        
        //收款人label
        self.recieverLabel = [self setUpLabelWithSuperView:recieverView Frame:CGRectMake(BF_ScaleWidth(15), 0, BF_ScaleWidth(200), LabelViewH) tetx:@"收款人：叶文敏"];
        
        //确认提现底部视图
        UIView *sureView = [self setUpViewWithFrame:CGRectMake(BF_ScaleWidth(10),CGRectGetMaxY(recieverView.frame)+ LabelViewMargin, BF_ScaleWidth(300), BF_ScaleHeight(40))];
        
        //UIView *line = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleHeight(40), sureView.width, 1)];
        //[sureView addSubview:line];
        
        UILabel *modifyBankLabel = [self setUpLabelWithSuperView:sureView Frame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(200), LabelViewH) tetx:@"我要修改银行信息"];
        modifyBankLabel.textColor = BFColor(0xFC1516);
        
        UIButton *modifyBankButton = [UIButton buttonWithType:0];
        modifyBankButton.frame = CGRectMake(0, 0, sureView.width, LabelViewH);
        [modifyBankButton addTarget:self action:@selector(modifyBankInfo) forControlEvents:UIControlEventTouchUpInside];
        [sureView addSubview:modifyBankButton];
        
        
        UIButton *getCashButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(sureView.frame)+LabelViewMargin, BF_ScaleWidth(300), BF_ScaleHeight(50)) title:@"确认提现" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
        self.getCashButton = getCashButton;
        getCashButton.backgroundColor = BFColor(0xFD8727);
        getCashButton.layer.cornerRadius = 5;
        [getCashButton addTarget:self action:@selector(sureToGetCash) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:getCashButton];
    }
    return self;
}
//确认提现
- (void)sureToGetCash {
    if (self.agreeButton.selected == NO) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请认真阅读并同意条款"];
    }else {
        if ([self.getCashTX.text isEqualToString:@""]) {
            [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入提现金额"];
        }else {
            
            if ([HZQRegexTestter validateFloatingPoint:self.getCashTX.text]) {
                if ([self.getCashTX.text floatValue] < 1.0) {
                    [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"提现金额最少1元"];
                }else {
                    self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%@",self.getCashTX.text];
                    [self endEditing:YES];
                    leftTime = 5;
                    [self.getCashButton setEnabled:NO];
                    [self.getCashButton setBackgroundColor:BFColor(0xD5D8D1)];
                    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoGetCashWithView:)]) {
                        [self.delegate gotoGetCashWithView:self];
                    }
                    BFLog(@"确认提现");
                }
            }else {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的金额..."];
            }
        }
    }
}

- (void)timeAction {
    BFLog(@"----------");
    leftTime--;
    if (leftTime <= 0) {
        [self.getCashButton setEnabled:YES];
        [self.getCashButton setBackgroundColor:BFColor(0xFD8727)];
        [timer invalidate];
        timer = nil;
    }else {
        [self.getCashButton setEnabled:NO];
        [self.getCashButton setBackgroundColor:BFColor(0xD5D8D1)];
    }
}


//修改银行信息
- (void)modifyBankInfo {
    if (self.getCashTX.text.length == 0) {
        [self.getCashTX resignFirstResponder];
        if (self.delegate && [self.delegate respondsToSelector:@selector(goToModifyBankCardInformation)]) {
            [self.delegate goToModifyBankCardInformation];
        }
        BFLog(@"我要修改银行信息");
    }else {
        if ([HZQRegexTestter validateFloatingPoint:self.getCashTX.text]) {
            self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%@",self.getCashTX.text];
            [self.getCashTX resignFirstResponder];
            if (self.delegate && [self.delegate respondsToSelector:@selector(goToModifyBankCardInformation)]) {
                [self.delegate goToModifyBankCardInformation];
            }
            BFLog(@"我要修改银行信息");
        }else {
            [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的金额..."];
        }
        
    }
    
   

}

//我以阅读按钮
- (void)agreeClick:(BFAgreeButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected) {
        sender.agreeImageView.image = [UIImage imageNamed:@"new_feature_share_false"];
    }else {
        sender.agreeImageView.image = [UIImage imageNamed:@"new_feature_share_true"];
    }
    BFLog(@"同意%d",sender.selected);
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
}

- (UILabel *)setUpLabelWithSuperView:(UIView *)superView Frame:(CGRect)frame tetx:(NSString *)text {
    UILabel *label = [UILabel labelWithFrame:frame font:BF_ScaleFont(12) textColor:BFColor(0x373737) text:text];
    [superView addSubview:label];
    return label;
}

- (UIView *)setUpViewWithFrame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = BFColor(0xffffff);
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 2;
    view.layer.borderColor = BFColor(0xEAEAEA).CGColor;
    [self addSubview:view];
    return view;
}


#pragma mark -- 点击done收起键盘
- (void)change:(UITextField *)textField {
    if (self.getCashTX.text.length == 0) {
        self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%@",textField.text];
    }else if (![HZQRegexTestter validateFloatingPoint:textField.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的金额..."];
    }else {
        if ([textField.text floatValue] <= 3500) {
            self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%@",textField.text];
        }else if ([textField.text floatValue] > 3500 && [textField.text floatValue] <= 5000) {
            self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%.2f",[textField.text floatValue] - ([textField.text floatValue] - 3500) * 0.03];
        }else if ([textField.text floatValue] > 5000 && [textField.text floatValue] <= 8000) {
            self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%.2f", [textField.text floatValue] - ([textField.text floatValue] - 3500) * 0.1 + 105];
        }else if ([textField.text floatValue] > 8000 && [textField.text floatValue] <= 12500) {
            self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%.2f", [textField.text floatValue] - ([textField.text floatValue] - 3500) * 0.2 + 555];
        }else if ([textField.text floatValue] > 12500 && [textField.text floatValue] <= 38500) {
            self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%.2f", [textField.text floatValue] - ([textField.text floatValue] - 3500) * 0.25 + 1005];
        }else if ([textField.text floatValue] > 38500 && [textField.text floatValue] <= 58500) {
            self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%.2f", [textField.text floatValue] - ([textField.text floatValue] - 3500) * 0.3 + 2755];
        }else if ([textField.text floatValue] > 58500 && [textField.text floatValue] <= 83500) {
            self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%.2f", [textField.text floatValue] - ([textField.text floatValue] - 3500) * 0.35 + 5505];
        }else if ([textField.text floatValue] > 83500) {
            self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%.2f", [textField.text floatValue] - ([textField.text floatValue] - 3500) * 0.45 + 13505];
        }
    }
}

#pragma mark -- 点击done收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self.getCashTX resignFirstResponder];
        return YES;
}

#pragma mark -- 点击view结束编辑
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
    
}

@end
