//
//  MyMoneyViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyWalletController.h"
#import "BFMyWalletTopView.h"

@interface BFMyWalletController()
/**背景图片*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**自定义*/
@property (nonatomic, strong) BFMyWalletTopView *topView;
@end

@implementation BFMyWalletController

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
    self.navigationController.navigationBar.translucent = YES;
    
    
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
    [self bgImageView];
    [self topView];
}














- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
}

@end
