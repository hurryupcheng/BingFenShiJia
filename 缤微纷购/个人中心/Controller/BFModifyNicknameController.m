//
//  BFModifyNicknameController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFModifyNicknameController.h"

@interface BFModifyNicknameController ()<UITextFieldDelegate>{
    __block int         leftTime;
    __block NSTimer     *timer;
}
/**昵称输入框*/
@property (nonatomic, strong) UITextField *nickNameTF;
/**保存按钮*/
@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation BFModifyNicknameController

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"修改昵称";
    //添加控件
    [self setUpView];
}
#pragma mark --创建控件
- (void)setUpView {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    self.nickNameTF = [UITextField textFieldWithFrame:CGRectMake(0, BF_ScaleHeight(10), BF_ScaleWidth(320), BF_ScaleHeight(30)) image:nil placeholder:@"请输入昵称"];
    self.nickNameTF.text = userInfo.nickname;
    self.nickNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nickNameTF.delegate = self;
    self.nickNameTF.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.nickNameTF];
    
    UIView *line = [UIView drawLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.nickNameTF.frame), ScreenWidth, 0.5)];
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

#pragma mark --保存按钮点击事件
- (void)click:(UIButton *)sender {
    [self.view endEditing:YES];
    //点击后2秒内，按钮不可用
    leftTime = 2;
    [self.saveButton setEnabled:NO];
    [self.saveButton setBackgroundColor:BFColor(0xD5D8D1)];
    
    if(timer)
        [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=up_nickname"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"nickname"] = self.nickNameTF.text;
    if (self.nickNameTF.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"请输入昵称"];
    }else if (self.nickNameTF.text.length > 16) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"昵称不得超过16个字符"];
    }else if ([userInfo.nickname isEqualToString:self.nickNameTF.text]) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"没有改动，不需修改"];
    }else {
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"%@,,%@,,%@",responseObject, parameter, url);
            if ([responseObject[@"msg"] isEqualToString:@"修改成功"]) {
                [BFProgressHUD MBProgressFromView:self.view LabelText:@"昵称修改成功,正在跳转" dispatch_get_main_queue:^{
                    userInfo.nickname = self.nickNameTF.text;
                    [BFUserDefaluts modifyUserInfo:userInfo];
                    _block(userInfo);
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }else {
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"修改失败"];
            }
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络异常"];
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
#pragma mark --点击屏幕收起键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma mark --textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nickNameTF resignFirstResponder];
    return YES;
}
@end
