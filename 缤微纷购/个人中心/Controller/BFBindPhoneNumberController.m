//
//  BFBindPhoneNumberController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFBindPhoneNumberController.h"
#import "HZQRegexTestter.h"

@interface BFBindPhoneNumberController ()<UITextFieldDelegate>{
    __block int         leftTime;
    __block NSTimer     *timer;
}
/**手机号输入框*/
@property (nonatomic, strong) UITextField *phoneNumberTX;
/**保存按钮*/
@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation BFBindPhoneNumberController

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"绑定手机";
    //添加控件
    [self setUpView];
}

#pragma mark -- 创建控件
- (void)setUpView {
    
    self.phoneNumberTX = [UITextField textFieldWithFrame:CGRectMake(0, BF_ScaleHeight(10), BF_ScaleWidth(320), BF_ScaleHeight(30)) image:nil placeholder:@"请输入手机号"];
    self.phoneNumberTX.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberTX.delegate = self;
    self.phoneNumberTX.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.phoneNumberTX];
    
    UIView *line = [UIView drawLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneNumberTX.frame), ScreenWidth, 0.5)];
    [self.view addSubview:line];
    
    UIButton *saveButton = [UIButton buttonWithType:0];
    self.saveButton = saveButton;
    saveButton.frame = CGRectMake(BF_ScaleWidth(15), CGRectGetMaxY(line.frame)+BF_ScaleHeight(20), BF_ScaleWidth(290), BF_ScaleHeight(30));
    saveButton.backgroundColor = BFColor(0xFC940A);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    saveButton.layer.cornerRadius = 5;
    [saveButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}

#pragma mark -- 保存按钮点击事件
- (void)click:(UIButton *)sender {
    [self.view endEditing:YES];
    //点击按钮，2秒内不能点击
    leftTime = 2;
    [self.saveButton setEnabled:NO];
    [self.saveButton setBackgroundColor:BFColor(0xD5D8D1)];
    
    if(timer)
        [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=w_tel"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"tel"] = self.phoneNumberTX.text;
    if (self.phoneNumberTX.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请输入手机号"];
    }else if (![HZQRegexTestter validatePhone:self.phoneNumberTX.text]) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请输入正确的手机号"];
    }else {
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"%@,,%@",responseObject,parameter);
            if (![responseObject[@"msg"] isEqualToString:@"绑定成功"]) {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"手机绑定失败,请重新绑定"];
            }else {
                [BFProgressHUD MBProgressFromView:self.view LabelText:@"手机绑定成功,正在跳转" dispatch_get_main_queue:^{
                    userInfo.tel = self.phoneNumberTX.text;
                    [BFUserDefaluts modifyUserInfo:userInfo];
                    _block(userInfo);
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        } failure:^(NSError *error) {
            BFLog(@"%@",error);
        }];

    }
}

#pragma mark --计时器方法
- (void)timerAction {
    leftTime--;
    if(leftTime<=0)
    {
        [self.saveButton setEnabled:YES];
        self.saveButton.backgroundColor = BFColor(0xFC940A);
    } else {
        
        [self.saveButton setEnabled:NO];
        [self.saveButton setBackgroundColor:BFColor(0xD5D8D1)];
    }
    
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
