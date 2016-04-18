//
//  BFModifyPasswordController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFModifyPasswordController.h"
#import "BFModifyPasswordView.h"
#import "MyMD5.h"

@interface BFModifyPasswordController ()<BFModifyPasswordViewDelegate>{
    __block int         leftTime;
    __block NSTimer     *timer;
}
/**自定义的view*/
@property (nonatomic, strong) BFModifyPasswordView *modifyPasswordView;
@end

@implementation BFModifyPasswordController
#pragma mark --懒加载
- (BFModifyPasswordView *)modifyPasswordView {
    if (!_modifyPasswordView) {
        _modifyPasswordView = [[BFModifyPasswordView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _modifyPasswordView.delegate = self;
        [self.view addSubview:_modifyPasswordView];
    }
    return _modifyPasswordView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.view.backgroundColor = BFColor(0xffffff);
    //添加自定义的view
    [self modifyPasswordView];
}

#pragma mark --BFModifyPasswordViewDelegate
- (void)clickToModifyPasswordWithView:(BFModifyPasswordView *)modifyPasswordView {
    leftTime = 2;
    [self.modifyPasswordView.modifyPasswordButton setEnabled:NO];
    [self.modifyPasswordView.modifyPasswordButton setBackgroundColor:BFColor(0xD5D8D1)];
    
    if(timer)
        [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=up_pass"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"old_pass"] = [MyMD5 md5:modifyPasswordView.original.text];
    parameter[@"news_pass"] = [MyMD5 md5:modifyPasswordView.setting.text];
    [BFHttpTool POST:url params:parameter success:^(id responseObject) {
        BFLog(@"%@",responseObject);
        
        if (![responseObject[@"msg"] isEqualToString:@"修改成功"]) {
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"密码修改失败"];
        }else {
            [BFProgressHUD MBProgressFromView:self.view LabelText:@"密码修改成功,正在跳转" dispatch_get_main_queue:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
}


- (void)timerAction {
    leftTime--;
    if(leftTime<=0)
    {
        [self.modifyPasswordView.modifyPasswordButton setEnabled:YES];
        self.modifyPasswordView.modifyPasswordButton.backgroundColor = BFColor(0xFD8727);
    } else
    {
        
        [self.modifyPasswordView.modifyPasswordButton setEnabled:NO];
        [self.modifyPasswordView.modifyPasswordButton setBackgroundColor:BFColor(0xD5D8D1)];
    }
    
}




@end
