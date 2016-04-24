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
/**缤微纷购图标*/
@property (nonatomic, strong) UIImageView *headIcon;
@end

@implementation BFMyBusinessCardController
#pragma mark --懒加载

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
        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        _headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(125), BF_ScaleHeight(80), BF_ScaleWidth(70), BF_ScaleWidth(70))];
        [_headIcon sd_setImageWithURL:[NSURL URLWithString:userInfo.user_icon]];
        _headIcon.layer.cornerRadius = BF_ScaleWidth(35);
        [self.bgImageView addSubview:_headIcon];
    }
    return _headIcon;
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
    //添加背景图片
    [self bgImageView];
    //添加二维码图片
    [self qrCode];
    //缤纷图标
    [self icon];
    //用户头像
    [self headIcon];
}


@end
