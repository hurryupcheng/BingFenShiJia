//
//  BFModifyBankCardController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFModifyBankCardController.h"
#import "BFModifyBankCardView.h"
#import "BFModifyNicknameController.h"
#import "BFBindPhoneNumberController.h"

@interface BFModifyBankCardController ()<BFModifyBankCardViewDelegate>
/**自定义修改银行卡view*/
@property (nonatomic, strong) BFModifyBankCardView *modifyView;
/**scrollView*/
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation BFModifyBankCardController

#pragma mark --懒加载
- (BFModifyBankCardView *)modifyView {
    if (!_modifyView) {
        _modifyView = [[BFModifyBankCardView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _modifyView.delegate = self;
        
    } 
    return _modifyView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        _scrollView.contentSize = CGSizeMake(0, ScreenHeight-66);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改银行卡";
    [self scrollView];
    //添加自定义View
    [self.scrollView addSubview:self.modifyView];
    //修改昵称的通知
    [BFNotificationCenter addObserver:self selector:@selector(gotoModifyNickname) name:@"gotoModifyNickname" object:nil];
    //修改手机号的通知
    [BFNotificationCenter addObserver:self selector:@selector(gotoBindPhoneNumber) name:@"gotoBindPhoneNumber" object:nil];
}

- (void)modifyBankInfomation {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --昵称label的通知
- (void)gotoModifyNickname {
    BFModifyNicknameController *modifyNicknameVC = [[BFModifyNicknameController alloc] init];
    modifyNicknameVC.block = ^(BFUserInfo *userInfo) {
        self.modifyView.detailInfo.nickName.text = [NSString stringWithFormat:@"   %@",userInfo.nickname];
        self.modifyView.detailInfo.nickName.textColor = BFColor(0x090909);
        self.modifyView.detailInfo.nickName.userInteractionEnabled = NO;
    };
    [self.navigationController pushViewController:modifyNicknameVC animated:YES];
}
#pragma mark --手机号label的通知
- (void)gotoBindPhoneNumber {
    BFBindPhoneNumberController *bindPhoneNumberVC = [[BFBindPhoneNumberController alloc] init];
    bindPhoneNumberVC.block = ^(BFUserInfo *userInfo) {
      self.modifyView.detailInfo.telephone.text = [NSString stringWithFormat:@"   %@",userInfo.tel];
        self.modifyView.detailInfo.telephone.textColor = BFColor(0x090909);
        self.modifyView.detailInfo.telephone.userInteractionEnabled = NO;
    };
    [self.navigationController pushViewController:bindPhoneNumberVC animated:YES];
}

//如果非显示状态，则不需要监听
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.userInteractionEnabled = YES;

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)hideKeyboard:(NSNotification *)noti{
    
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    //键盘弹起的时间
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect bottomViewFrame = self.scrollView.frame;
    bottomViewFrame.size.height = self.view.frame.size.height;
    //bottomViewFrame.origin.y = self.view.frame.size.height-bottomViewFrame.size.height;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        self.scrollView.frame = bottomViewFrame;
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
    CGRect bottomViewFrame = self.scrollView.frame;
    bottomViewFrame.size.height = self.view.frame.size.height - endframe.size.height;
    //bottomViewFrame.origin.y = endframe.origin.y - bottomViewFrame.size.height;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        self.scrollView.frame = bottomViewFrame;
    } completion:nil];
    [self.view layoutIfNeeded];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    self.tabBarController.tabBar.hidden = YES;
    
}






@end
