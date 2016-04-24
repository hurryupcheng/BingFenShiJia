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
        _qrCode = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(60), BF_ScaleHeight(170), BF_ScaleWidth(200), BF_ScaleWidth(200))];
        _qrCode.backgroundColor = BFColor(0xffffff);
        _qrCode.image = [@"1231239049049081" imageForQRCode:_qrCode.frame.size.width];

        [self.bgImageView addSubview:_qrCode];
    }
    return _qrCode;
}


- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(140), BF_ScaleHeight(250), BF_ScaleWidth(40), BF_ScaleWidth(40))];
        _icon.image = [UIImage imageNamed:@"icon"];
        _icon.layer.cornerRadius = BF_ScaleWidth(5);
        [self.bgImageView addSubview:_icon];
    }
    return _icon;
}


- (UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(125), BF_ScaleHeight(40), BF_ScaleWidth(70), BF_ScaleWidth(70))];
        _headIcon.backgroundColor = BFColor(0xffffff);
        _headIcon.layer.borderWidth = 1;
        _headIcon.layer.borderColor = BFColor(0xffffff).CGColor;
        if (_userInfo.app_icon.length != 0) {
            [_headIcon sd_setImageWithURL:[NSURL URLWithString:_userInfo.app_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
        }else {
            [_headIcon sd_setImageWithURL:[NSURL URLWithString:_userInfo.user_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
        }
        _headIcon.layer.cornerRadius = BF_ScaleWidth(35);
        _headIcon.layer.masksToBounds = YES;
        [self.bgImageView addSubview:_headIcon];
    }
    return _headIcon;
}

- (UILabel *)nickName {
    if (!_nickName) {
        _nickName = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headIcon.frame)+BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(20))];
        _nickName.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(20)];
        _nickName.text = _userInfo.nickname;
        _nickName.textAlignment = NSTextAlignmentCenter;
        [_bgImageView addSubview:_nickName];
    }
    return _nickName;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _bgImageView.image =  [UIImage imageNamed:@"beijin1.jpg"];
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}


#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的名片";
    self.view.backgroundColor = BFColor(0xffffff);
    _userInfo = [BFUserDefaluts getUserInfo];
    //添加背景图片
    [self bgImageView];
    //添加二维码图片
    [self qrCode];
    //缤纷图标
    [self icon];
    //用户头像
    [self headIcon];
    //用户昵称
    [self nickName];
}


@end
