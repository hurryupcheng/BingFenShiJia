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

@interface BFModifyPasswordController ()<BFModifyPasswordViewDelegate>
/**自定义的view*/
@property (nonatomic, strong) BFModifyPasswordView *modifyPasswordView;
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation BFModifyPasswordController
#pragma mark --懒加载
- (BFModifyPasswordView *)modifyPasswordView {
    if (!_modifyPasswordView) {
        _modifyPasswordView = [[BFModifyPasswordView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
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
    
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.bgImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.bgImageView.image = [UIImage imageNamed:@"beijin1.jpg"];
    self.bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgImageView];
    //添加自定义的view
    [self modifyPasswordView];
}

#pragma mark --BFModifyPasswordViewDelegate
- (void)clickToModifyPasswordWithView:(BFModifyPasswordView *)modifyPasswordView {
    [BFProgressHUD MBProgressWithLabelText:@"正在修改密码" dispatch_get_main_queue:^(MBProgressHUD *hud) {
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
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"密码修改失败"];
            }else {
                userInfo.password = [MyMD5 md5:modifyPasswordView.setting.text];
                [BFUserDefaluts modifyUserInfo:userInfo];
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressFromView:self.view LabelText:@"密码修改成功,正在跳转..." dispatch_get_main_queue:^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            }
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressOnlyWithLabelText:@"网络异常"];
            BFLog(@"%@",error);
        }];

    }];
    
}


#pragma mark --viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}
#pragma mark --viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}


@end
