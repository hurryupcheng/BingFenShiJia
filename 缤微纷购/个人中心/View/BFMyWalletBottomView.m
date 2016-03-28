//
//  BFMyWalletBottomView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "HZQRegexTestter.h"
#import "BFMyWalletBottomView.h"
#import "BFAgreeButton.h"

@interface BFMyWalletBottomView()<UITextFieldDelegate>

@property (nonatomic, strong) BFAgreeButton *agreeButton;

@property (nonatomic, strong) UIView *getCashView;
/**收款人*/
@property (nonatomic, strong) UILabel *recieverLabel;
/**实付金额*/
@property (nonatomic, strong) UILabel *paidCashLabel;


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

        self.backgroundColor = BFColor(0xE7E7E7);
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
        self.getCashView = [self setUpViewWithFrame:CGRectMake(BF_ScaleWidth(10),CGRectGetMaxY(protocalView.frame)+ BF_ScaleHeight(6), BF_ScaleWidth(300), BF_ScaleHeight(30))];
        
        //提现金额label
        UILabel *getCashLabel = [self setUpLabelWithSuperView:self.getCashView Frame:CGRectMake(BF_ScaleWidth(15), 0, BF_ScaleWidth(60), self.getCashView.height) tetx:@"提现金额："];
        
        //提现金额输入框
        self.getCashTX = [UITextField textFieldWithFrame:CGRectMake(CGRectGetMaxX(getCashLabel.frame), BF_ScaleHeight(5), BF_ScaleWidth(150), BF_ScaleHeight(20)) image:nil placeholder:nil];
        self.getCashTX.delegate = self;
        self.getCashTX.returnKeyType = UIReturnKeyDone;
        self.getCashTX.layer.cornerRadius = 3;
        self.getCashTX.layer.borderWidth = 1;
        self.getCashTX.layer.borderColor = BFColor(0xDCDCDC).CGColor;
        [self.getCashView addSubview:self.getCashTX];
        
        //实付金额底部视图
        UIView *paidCashView = [self setUpViewWithFrame:CGRectMake(BF_ScaleWidth(10),CGRectGetMaxY(self.getCashView.frame)+ BF_ScaleHeight(6), BF_ScaleWidth(300), BF_ScaleHeight(30))];
        
        //实付金额label
        self.paidCashLabel = [self setUpLabelWithSuperView:paidCashView Frame:CGRectMake(BF_ScaleWidth(15), 0, BF_ScaleWidth(260), paidCashView.height) tetx:@"实付金额："];
        
        //收款人底部视图
        UIView *recieverView = [self setUpViewWithFrame:CGRectMake(BF_ScaleWidth(10),CGRectGetMaxY(paidCashView.frame)+ BF_ScaleHeight(6), BF_ScaleWidth(300), BF_ScaleHeight(30))];
        
        //收款人label
        self.recieverLabel = [self setUpLabelWithSuperView:recieverView Frame:CGRectMake(BF_ScaleWidth(15), 0, BF_ScaleWidth(200), paidCashView.height) tetx:@"收款人：叶文敏"];
        
        //确认提现底部视图
        UIView *sureView = [self setUpViewWithFrame:CGRectMake(BF_ScaleWidth(10),CGRectGetMaxY(recieverView.frame)+ BF_ScaleHeight(6), BF_ScaleWidth(300), self.height-(CGRectGetMaxY(recieverView.frame)+ BF_ScaleHeight(7)))];
        
        UIView *line = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleHeight(30), sureView.width, 1)];
        [sureView addSubview:line];
        
        UILabel *modifyBankLabel = [self setUpLabelWithSuperView:sureView Frame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(200), BF_ScaleHeight(30)) tetx:@"我要修改银行信息"];
        modifyBankLabel.textColor = BFColor(0xFC1516);
        
        UIButton *modifyBankButton = [UIButton buttonWithType:0];
        modifyBankButton.frame = CGRectMake(0, 0, sureView.width, BF_ScaleHeight(30));
        [modifyBankButton addTarget:self action:@selector(modifyBankInfo) forControlEvents:UIControlEventTouchUpInside];
        [sureView addSubview:modifyBankButton];
        
        
        UIButton *getCashButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(20), CGRectGetMaxY(line.frame)+BF_ScaleWidth(5), BF_ScaleWidth(260), sureView.height-BF_ScaleHeight(40)) title:@"确认提现" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
        getCashButton.backgroundColor = BFColor(0xFD8727);
        getCashButton.layer.cornerRadius = 5;
        [getCashButton addTarget:self action:@selector(sureToGetCash) forControlEvents:UIControlEventTouchUpInside];
        [sureView addSubview:getCashButton];
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
                self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%@",self.getCashTX.text];
                [self endEditing:YES];
                if (self.delegate && [self.delegate respondsToSelector:@selector(gotoGetCashWithView:)]) {
                    [self.delegate gotoGetCashWithView:self];
                }
                BFLog(@"确认提现");
            }else {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的金额..."];
            }

            
        }
        
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


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([HZQRegexTestter validateFloatingPoint:self.getCashTX.text]) {
        self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%@",self.getCashTX.text];
        [self.getCashTX resignFirstResponder];
    }else {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的金额..."];
    }

    [self endEditing:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length == 0) {
        [self.getCashTX resignFirstResponder];
    }else {
        if ([HZQRegexTestter validateFloatingPoint:textField.text]) {
            self.paidCashLabel.text = [NSString stringWithFormat:@"实付金额：%@",textField.text];
            [self.getCashTX resignFirstResponder];
        }else {
            [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的金额..."];
        }

    }
    return YES;
}
@end
