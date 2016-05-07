//
//  BFMyBusinessCardController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyBusinessCardController.h"
#import "NSString+QRCode.h"

@interface BFMyBusinessCardController ()

/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**二维码图片*/
@property (nonatomic, strong) UIImageView *qrCode;
/**缤微纷购图标*/
@property (nonatomic, strong) UIImageView *icon;
/**用户头像图标*/
@property (nonatomic, strong) UIImageView *headIcon;
/**用户昵称*/
@property (nonatomic, strong) UILabel *nickName;
/**用户昵称*/
@property (nonatomic, strong) BFUserInfo *userInfo;
@end

@implementation BFMyBusinessCardController
#pragma mark --懒加载

//- (BFUserInfo *)userInfo {
//    if (!_userInfo) {
//        
//    }
//    return _userInfo;
//}

- (UIImageView *)qrCode {
    if (!_qrCode) {
        _qrCode = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(95), BF_ScaleHeight(335), BF_ScaleWidth(130), BF_ScaleWidth(130))];
        _qrCode.backgroundColor = BFColor(0xffffff);
        _qrCode.image = [@"1231239049049081" imageForQRCode:_qrCode.frame.size.width];

        [self.bgImageView addSubview:_qrCode];
    }
    return _qrCode;
}


- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(140), BF_ScaleHeight(380), BF_ScaleWidth(40), BF_ScaleWidth(40))];
        _icon.image = [UIImage imageNamed:@"icon"];
        _icon.layer.cornerRadius = BF_ScaleWidth(5);
        [self.bgImageView addSubview:_icon];
    }
    return _icon;
}




- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(21), ScreenWidth, ScreenHeight)];
        _bgImageView.image =  [UIImage imageNamed:@"business_card"];
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}


#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];

    //self.title = @"我的名片";
    self.view.backgroundColor = BFColor(0xffffff);
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];

    _userInfo = [BFUserDefaluts getUserInfo];
    //添加背景图片
    [self bgImageView];
    //添加返回按钮
    //[self setUpBackButton];
    //添加用户头像和昵称
    [self setUpHeadIconAndNickname];
    //添加二维码图片
    [self qrCode];
    //缤纷图标
    [self icon];
    //用户头像
    [self headIcon];
    //用户昵称
    [self nickName];
}

#pragma mark -- 添加用户头像和昵称
- (void)setUpHeadIconAndNickname {
    _headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(105), BF_ScaleHeight(25), BF_ScaleWidth(75), BF_ScaleWidth(75))];
    _headIcon.backgroundColor = BFColor(0xffffff);
    _headIcon.layer.borderWidth = 1;
    _headIcon.layer.borderColor = BFColor(0xffffff).CGColor;
    if (_userInfo.app_icon.length != 0) {
        [_headIcon sd_setImageWithURL:[NSURL URLWithString:_userInfo.app_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
    }else {
        [_headIcon sd_setImageWithURL:[NSURL URLWithString:_userInfo.user_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
    }
    _headIcon.layer.cornerRadius = BF_ScaleWidth(75)/2;
    _headIcon.layer.masksToBounds = YES;
    [self.bgImageView addSubview:_headIcon];

    _nickName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame)+BF_ScaleWidth(5), BF_ScaleHeight(65), BF_ScaleWidth(140), BF_ScaleHeight(11))];
    _nickName.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(11)];
    _nickName.text = [NSString stringWithFormat:@"我是%@", _userInfo.nickname];
    [_bgImageView addSubview:_nickName];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.nickName.x, CGRectGetMaxY(self.nickName.frame)+BF_ScaleHeight(5), BF_ScaleWidth(140), BF_ScaleHeight(11))];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(11)];
    label.text = @"我为缤纷世家代言";
    [_bgImageView addSubview:label];
    
}


#pragma mark -- 添加返回按钮
//- (void)setUpBackButton {
//    UIButton *back = [UIButton buttonWithType:0];
//    back.frame = CGRectMake(5, 22, 35, 40);
//    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:back];
//
//}
//
//- (void)back {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}

@end
