//
//  MyMoneyViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyWalletController.h"
#import "BFMyWalletTopView.h"
#import "BFMyWalletBottomView.h"
#import "BFModifyBankCardController.h"

@interface BFMyWalletController()<UITextFieldDelegate, BFMyWalletBottomViewDelegate>
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**自定义我的钱包页面上班部分*/
@property (nonatomic, strong) BFMyWalletTopView *topView;
/**自定义我的钱包页面下半部分*/
@property (nonatomic, strong) BFMyWalletBottomView *bottomView;
/**用户信息*/
@property (nonatomic, strong) BFUserInfo *userInfo;
@end

@implementation BFMyWalletController

/**定义*/
- (BFMyWalletBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[BFMyWalletBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight*0.42, ScreenWidth, ScreenHeight*0.58)];
        _bottomView.delegate = self;
        //_bottomView.backgroundColor = BFColor(0xF4F4F6);
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

/**定义*/
- (BFMyWalletTopView *)topView {
    if (!_topView) {
        _topView = [[BFMyWalletTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.42)];
        [self.view addSubview:_topView];
    }
    return _topView;
}


/**bgImageView*/
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame]
        ;
        _bgImageView.image = [UIImage imageNamed:@"beijin1.jpg"];
        _bgImageView.userInteractionEnabled = YES;
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBar.translucent = YES;
    self.userInfo = [BFUserDefaluts getUserInfo];
    if ([self.userInfo.tel isEqualToString:@""] || [self.userInfo.bank_name isEqualToString:@""] || [self.userInfo.card_id isEqualToString:@""] || [self.userInfo.card_address isEqualToString:@""] || [self.userInfo.nickname isEqualToString:@""] || [self.userInfo.true_name isEqualToString:@""]) {
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"请先完善银行信息" dispatch_get_main_queue:^{
            BFModifyBankCardController *modifyBankCardVC = [BFModifyBankCardController new];
            [self.navigationController pushViewController:modifyBankCardVC animated:YES];
            
        }];
        
    }
    
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    //添加背景图片
    [self bgImageView];
    //获取数据
    [self getData];
    //添加上面视图
    [self topView];
    //添加下面视图
    [self bottomView];
    
    
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)getData {
   
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=withdraw_deposit"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = self.userInfo.ID;
    parameter[@"token"] = self.userInfo.token;
    
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        BFLog(@"responseObject%@",responseObject);
//        if ([responseObject[@"msg"] isEqualToString:@"请先完善银行信息"]) {
//            self.view.userInteractionEnabled = NO;
//        [BFProgressHUD MBProgressFromWindowWithLabelText:@"请先完善银行信息" dispatch_get_main_queue:^{
//            BFModifyBankCardController *modifyBankCardVC = [BFModifyBankCardController new];
//            [self.navigationController pushViewController:modifyBankCardVC animated:YES];
//
//        }];
//    }
    } failure:^(NSError *error) {
        BFLog(@"error%@",error);
    }];
}


#pragma mark -- BFMyWalletBottomViewDelegate 
- (void)goToModifyBankCardInformation {
    BFModifyBankCardController *modifyBankCardVC = [BFModifyBankCardController new];
    [self.navigationController pushViewController:modifyBankCardVC animated:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//如果非显示状态，则不需要监听
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.view.userInteractionEnabled = YES;
    self.navigationController.navigationBar.translucent = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)hideKeyboard:(NSNotification *)noti{
    
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    //键盘弹起的时间
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect bottomViewFrame = _bottomView.frame;
    bottomViewFrame.origin.y = self.view.frame.size.height-bottomViewFrame.size.height;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        _bottomView.frame = bottomViewFrame;
    } completion:nil];
    //为了显示动画
    [self.view layoutIfNeeded];
    
}
-(void)showKeyboard:(NSNotification *)noti{
    //NSLog(@"userInfo %@",noti.userInfo);
    //键盘出现后的位置
    CGRect endframe = [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //键盘弹起时的动画效果
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    //键盘弹起的时间
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect bottomViewFrame = _bottomView.frame;
    bottomViewFrame.origin.y = endframe.origin.y - bottomViewFrame.size.height;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
         _bottomView.frame = bottomViewFrame;
    } completion:nil];
    [self.view layoutIfNeeded];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];

}



@end
