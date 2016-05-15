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
#import "BFMyWalletModel.h"
#import "BFWithdrawalRecordController.h"

@interface BFMyWalletController()<UITextFieldDelegate, BFMyWalletBottomViewDelegate, BFMyWalletTopViewDelegate>
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**自定义我的钱包页面上班部分*/
@property (nonatomic, strong) BFMyWalletTopView *topView;
/**自定义我的钱包页面下半部分*/
@property (nonatomic, strong) BFMyWalletBottomView *bottomView;
/**用户信息*/
//@property (nonatomic, strong) BFUserInfo *userInfo;
/**我的钱包模型*/
@property (nonatomic, strong) BFMyWalletModel *model;
/**scrollview*/
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation BFMyWalletController
#pragma mark --懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight)];
        _scrollView.contentSize = CGSizeMake(0, BF_ScaleHeight(400)+0.42*ScreenHeight);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


//- (BFUserInfo *)userInfo {
//    if (!_userInfo) {
//        _userInfo = [BFUserDefaluts getUserInfo];
//    }
//    return _userInfo;
//}

/**定义*/
- (BFMyWalletBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[BFMyWalletBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight*0.42, ScreenWidth, BF_ScaleHeight(400))];
        _bottomView.delegate = self;
        //_bottomView.backgroundColor = BFColor(0xF4F4F6);
        //[self.view addSubview:_bottomView];
    }
    return _bottomView;
}

/**定义*/
- (BFMyWalletTopView *)topView {
    if (!_topView) {
        _topView = [[BFMyWalletTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.42)];
        _topView.delegate = self;
        //[self.view addSubview:_topView];
    }
    return _topView;
}


/**bgImageView*/
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]
        ;
        _bgImageView.image = [UIImage imageNamed:@"beijin1.jpg"];
        _bgImageView.userInteractionEnabled = YES;
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];

    //添加背景图片
    [self bgImageView];
    //添加scrollView
    [self.bgImageView addSubview:_scrollView];
    //获取数据
    [self getData];
    //添加上面视图
    [self.scrollView addSubview:self.topView];
    //添加下面视图
    [self.scrollView addSubview:self.bottomView];
    //添加返回按钮
    [self setUpBackButton];
    [BFNotificationCenter addObserver:self selector:@selector(modifyNickName) name:@"modifyNickName" object:nil];
    
}
- (void)modifyNickName {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    self.topView.nickName.text = [NSString stringWithFormat:@"%@", userInfo.nickname];
}



- (void)setUpBackButton {
    UIButton *back = [UIButton buttonWithType:0];
    back.frame = CGRectMake(5, 22, 35, 40);
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=withdraw_deposit"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading..." dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"responseObject%@",responseObject);
            if (responseObject) {
                self.model = [BFMyWalletModel parse:responseObject];
                self.topView.model = self.model;
                self.bottomView.model = self.model;
                
            }
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.y = 0;
            }];
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
            BFLog(@"error%@",error);
        }];
    }];
}


#pragma mark -- BFMyWalletTopViewDelegate
- (void)goToCheckWithdrawalRecordWithType:(BFMyWalletTopButtonType)type {
    switch (type) {
        case BFMyWalletTopButtonTypeRecord:{
            BFWithdrawalRecordController *withdrawalRecordVC = [[BFWithdrawalRecordController alloc] init];
            withdrawalRecordVC.user_account = self.model.user_account;
            [self.navigationController pushViewController:withdrawalRecordVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark -- BFMyWalletBottomViewDelegate 
- (void)gotoGetCashWithView:(BFMyWalletBottomView *)view {
    if ([view.getCashTX.text floatValue] > [self.model.user_account floatValue]) {
        [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"余额不足，请重新输入"];
    }else if ([self.model.bank_status isEqualToString:@"0"]) {
        [BFProgressHUD MBProgressFromView:self.view LabelText:@"请先完善银行信息" dispatch_get_main_queue:^{
            BFModifyBankCardController *modifyBankCardVC = [BFModifyBankCardController new];
            [self.navigationController pushViewController:modifyBankCardVC animated:YES];
        }];
    }else {
        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=withdraw_deposit_do"];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"uid"] = userInfo.ID;
        parameter[@"token"] = userInfo.token;
        parameter[@"money"] = view.getCashTX.text;
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"responseObject%@,,%@",responseObject,parameter);
            if (responseObject) {
                if ([responseObject[@"msg"] isEqualToString:@"提现成功，请等待工作人员处理"]) {
                    [BFProgressHUD MBProgressFromWindowWithLabelText:@"正在处理提交申请,请稍后" dispatch_get_main_queue:^{
                        double delayInSeconds = 1;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [BFProgressHUD MBProgressFromView:self.view rightLabelText:@"提现成功,请等待工作人员处理!"];
                            view.getCashTX.text = @"";
                            view.paidCashLabel.text = @"实付金额：";
                            [self regetData];
                        });
                    }];
                }else if ([responseObject[@"msg"] isEqualToString:@"每月只能申请提现一次！请等下个月再提现。"]) {
                    [BFProgressHUD MBProgressFromView:self.view wrongLabelText:@"亲,每月只能申请提现一次哦!"];
                }else {
                    [BFProgressHUD MBProgressFromView:self.view wrongLabelText:@"提现失败,请稍后再试"];
                }
            }
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromWindowWithLabelText:@"网络问题"];
            BFLog(@"error%@",error);
        }];

    }
}

- (void)regetData {

    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=withdraw_deposit"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
       [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        BFLog(@"responseObject%@",responseObject);
        if (responseObject) {
            self.model = [BFMyWalletModel parse:responseObject];
            self.topView.model = self.model;
        }

    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
        BFLog(@"error%@",error);
    }];
}




#pragma mark -- BFMyWalletBottomViewDelegate 
- (void)goToModifyBankCardInformation {
    BFModifyBankCardController *modifyBankCardVC = [BFModifyBankCardController new];
    modifyBankCardVC.block = ^(BFUserInfo *userInfo) {
        self.bottomView.recieverLabel.text = [NSString stringWithFormat:@"收款人：%@", userInfo.true_name];
        //self.userInfo = userInfo;
    };
    [self.navigationController pushViewController:modifyBankCardVC animated:YES];
}



//如果非显示状态，则不需要监听
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.view.userInteractionEnabled = YES;
    self.navigationController.navigationBar.hidden = YES;
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
        _scrollView.y = 0;
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
         _scrollView.y = -0.3*ScreenHeight;
    } completion:nil];
    [self.view layoutIfNeeded];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    self.tabBarController.tabBar.hidden = YES;

}



//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}

@end
