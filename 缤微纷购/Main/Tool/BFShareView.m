//
//  BFShareView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define navigationViewHeight 44.0f
#define pickViewViewHeight  BF_ScaleHeight(250)
#define buttonWidth 60.0f
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]
#define ButtonWH  BF_ScaleWidth(50)


#import "BFShareView.h"


@interface BFShareView ()
/**微信朋友圈分享按钮*/
@property (nonatomic, strong) UIButton *moments;
/**QQ空间分享按钮*/
@property (nonatomic, strong) UIButton *QQZone;
/**QQ好友分享按钮*/
@property (nonatomic, strong) UIButton *QQFriends;
/**新浪分享按钮*/
@property (nonatomic, strong) UIButton *sinaBlog;
/**微信好友分享按钮*/
@property (nonatomic, strong) UIButton *wechatFriends;
@end

@implementation BFShareView

+ (instancetype) shareView {
    BFShareView *share = [[BFShareView alloc] init];
    [share showShareView];
    return share;
}

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self setUpView];
        [self addTapGestureRecognizerToSelf];
    }
    return self;
}
- (void)addTapGestureRecognizerToSelf {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
}

- (void)setUpView {
    self.moments = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(135), ScreenHeight, ButtonWH, ButtonWH) image:@"Momments" type:BFShareButtonTypeMoments];
    
    self.QQZone = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(75), ScreenHeight+BF_ScaleHeight(40), ButtonWH, ButtonWH) image:@"QQZone" type:BFShareButtonTypeQQZone];

    
    self.QQFriends = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(100), ScreenHeight+BF_ScaleHeight(110), ButtonWH, ButtonWH) image:@"QQFriends" type:BFShareButtonTypeQQFriends];
    
    self.sinaBlog = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(170), ScreenHeight+BF_ScaleHeight(110), ButtonWH, ButtonWH) image:@"SinaBlog" type:BFShareButtonTypeSinaBlog];
    
    self.wechatFriends = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(195), ScreenHeight+BF_ScaleHeight(40), ButtonWH, ButtonWH) image:@"WechatFriends" type:BFShareButtonTypeWechatFriends];
    
}


- (void)showShareView {
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.8 delay:0.1f usingSpringWithDamping:0.5f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.moments.y = BF_ScaleHeight(120);
        self.backgroundColor = windowColor;
    } completion:nil];
    
    [UIView animateWithDuration:1.0 delay:0.08f usingSpringWithDamping:0.5f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.QQZone.y = BF_ScaleHeight(160);
    } completion:nil];
    
    [UIView animateWithDuration:1.2 delay:0.1f usingSpringWithDamping:0.5f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.QQFriends.y = BF_ScaleHeight(230);
    } completion:nil];
    
    [UIView animateWithDuration:1.2 delay:0.08f usingSpringWithDamping:0.5f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.sinaBlog.y = BF_ScaleHeight(230);
    } completion:nil];
    
    [UIView animateWithDuration:1.0 delay:0.1f usingSpringWithDamping:0.5f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.wechatFriends.y = BF_ScaleHeight(160);
    } completion:nil];
}

- (void)hideShareView {
    [UIView animateWithDuration:1 delay:0.2f usingSpringWithDamping:1.0f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.moments.y = ScreenHeight;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:1 delay:0.16f usingSpringWithDamping:1.0f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.QQZone.y = ScreenHeight+BF_ScaleHeight(40);
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:0.12f usingSpringWithDamping:1.0f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.wechatFriends.y = ScreenHeight+BF_ScaleHeight(40);
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:0.08f usingSpringWithDamping:1.0f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.QQFriends.y = ScreenHeight+BF_ScaleHeight(110);
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:0.04f usingSpringWithDamping:1.0f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.sinaBlog.y = ScreenHeight+BF_ScaleHeight(110);
    } completion:nil];
    
}

- (void)hide {
    [self hideShareView];
}

- (UIButton *)setUpButtonWithFrame:(CGRect)frame image:(NSString *)image type:(BFShareButtonType)type{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.tag = type;
    button.layer.shadowOffset = CGSizeMake(0, 0);
    button.layer.shadowColor = BFColor(0x000000).CGColor;
    button.layer.shadowOpacity = 0.7;
    //button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(clickToShare:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self addSubview:button];
    return button;
}

- (void)clickToShare:(UIButton *)sender {
    [self removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(bfShareView:type:)]) {
        [self.delegate bfShareView:self type:sender.tag];
    }
    
    BFLog(@"点击了分享");
}

@end
