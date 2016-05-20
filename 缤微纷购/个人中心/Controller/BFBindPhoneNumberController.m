//
//  BFBindPhoneNumberController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFBindPhoneNumberController.h"
#import "HZQRegexTestter.h"
#import "BFBindPhoneNumberView.h"
@interface BFBindPhoneNumberController ()<UITextFieldDelegate, BFBindPhoneNumberViewDelegate>/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**手机号输入框*/
@property (nonatomic, strong) UITextField *phoneNumberTX;
/**验证码*/
@property (nonatomic, strong) UITextField *verificationCodeTX;
/**保存按钮*/
@property (nonatomic, strong) UIButton *saveButton;
/**发送验证码*/
@property (nonatomic, strong) UIButton *sendVerificationCodeButton;

@property (nonatomic, strong) BFBindPhoneNumberView *bindView;

@end

@implementation BFBindPhoneNumberController


- (BFBindPhoneNumberView *)bindView {
    if (!_bindView) {
        _bindView = [[BFBindPhoneNumberView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bindView.delegate = self;
        [self.view addSubview:_bindView];
    }
    return _bindView;
}


#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"绑定手机";
    
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.bgImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.bgImageView.image = [UIImage imageNamed:@"beijin1.jpg"];
    self.bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgImageView];
    //添加控件
    [self bindView];
    //[self setUpView];
}

- (void)gotoLoginController:(BFUserInfo *)userInfo {
    _block(userInfo);
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}



#pragma mark -- 点击屏幕收起键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -- textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.phoneNumberTX resignFirstResponder];
    return YES;
}

@end
