//
//  BFForgetPasswordController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFForgetPasswordController.h"
#import "BFForgetPasswordView.h"

@interface BFForgetPasswordController ()<BFForgetPasswordViewDelegate>
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**自定义的view*/
@property (nonatomic, strong) BFForgetPasswordView *forgetPasswordView;
/**手机号保存路径*/
@property (nonatomic, strong) NSString *phonePath;

@end

@implementation BFForgetPasswordController

#pragma mark --懒加载
- (NSString *)phonePath {
    if (!_phonePath) {
        _phonePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"phone.plist"];
    }
    return _phonePath;
}






- (BFForgetPasswordView *)forgetPasswordView {
    if (!_forgetPasswordView) {
        _forgetPasswordView = [[BFForgetPasswordView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _forgetPasswordView.delegate = self;
        [self.bgImageView addSubview:_forgetPasswordView];
    }
    return _forgetPasswordView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = BFColor(0xffffff);
    
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.bgImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.bgImageView.image = [UIImage imageNamed:@"beijin1.jpg"];
    self.bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgImageView];
    //添加自定义view
    [self forgetPasswordView];
}

#pragma mark --自定义view代理
- (void)gotoLoginVC {
    [self.forgetPasswordView.phoneTX.text writeToFile:self.phonePath atomically:YES];
//    NSFileManager * fileManager = [[NSFileManager alloc]init];
//    [fileManager removeItemAtPath:self.passwordPath error:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
