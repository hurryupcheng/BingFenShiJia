//
//  BFCustomerServiceView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFCustomerServiceView.h"
#import "UIImageView+LBBlurredImage.h"

@interface BFCustomerServiceView()
/**背景图*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**电话客服*/
@property (nonatomic, strong) UIButton *telephoneService;
/**微信客服*/
@property (nonatomic, strong) UIButton *wechatService;
/**取消按钮*/
@property (nonatomic, strong) UIButton *cancle;
@end


@implementation BFCustomerServiceView



+ (instancetype) createCustomerServiceView {
    BFCustomerServiceView *view = [[BFCustomerServiceView alloc] init];
    [view showView];
    return view;
}

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self setUpView];
        
    }
    return self;
}

- (void)setUpView {
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //self.bgImageView.image = [UIImage imageNamed:@"customerservicebg"];
    [self.bgImageView setImageToBlur:[UIImage imageNamed:@"customerservicebg"] blurRadius:20  completionBlock:nil];
    //self.backgroundColor= [UIColor redColor];
    self.bgImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.bgImageView  addGestureRecognizer:tap];
    [self addSubview:self.bgImageView];
    
    
    self.telephoneService = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(75), BF_ScaleHeight(450)-ScreenHeight, BF_ScaleWidth(55), BF_ScaleWidth(55)) image:@"service_telephone" type:BFCustomerServiceViewButtonTypeTelephone];
    
    
    self.wechatService = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(190), BF_ScaleHeight(450)-ScreenHeight, BF_ScaleWidth(55), BF_ScaleWidth(55)) image:@"service_wechat" type:BFCustomerServiceViewButtonTypeWechat];
    
    
    self.cancle = [UIButton buttonWithType:0];
    self.cancle.frame = CGRectMake(BF_ScaleWidth(147.5), BF_ScaleHeight(530)+ScreenHeight, BF_ScaleWidth(25), BF_ScaleWidth(25));
    //self.cancle.backgroundColor = [UIColor redColor];
    [self.cancle addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancle setImage:[UIImage imageNamed:@"cancle"] forState:UIControlStateNormal];
    [self.bgImageView addSubview:self.cancle];
    
    
}



- (void)showView {
    self.bgImageView.alpha = 0;
    [UIView animateWithDuration:1 delay:0.1f usingSpringWithDamping:0.5f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgImageView.alpha = 1;
        self.telephoneService.y = BF_ScaleHeight(450);
    } completion:nil];
    
    [UIView animateWithDuration:0.8 delay:0.2f usingSpringWithDamping:0.6f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.wechatService.y = BF_ScaleHeight(450);
    } completion:nil];
    
    [UIView animateWithDuration:0.8 delay:0.1f usingSpringWithDamping:1.0f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.cancle.y = BF_ScaleHeight(530);
    } completion:nil];

}

- (void)hideView {
    [UIView animateWithDuration:1 delay:0.12f usingSpringWithDamping:0.6f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgImageView.alpha = 0;
        self.telephoneService.y = BF_ScaleHeight(450) - ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.8 delay:0.1f usingSpringWithDamping:0.6f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.wechatService.y = BF_ScaleHeight(450) - ScreenHeight;
    } completion:^(BOOL finished) {
        //[self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.8 delay:0.1f usingSpringWithDamping:1.0f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.cancle.y = BF_ScaleHeight(530)+ScreenHeight;
    } completion:^(BOOL finished) {
        //[self removeFromSuperview];
    }];
    
}

//取消按钮点击
- (void)cancle:(UIButton *)sender {
    [self hideView];
}

- (void)hide {
   
    [self hideView];
}

- (UIButton *)setUpButtonWithFrame:(CGRect)frame image:(NSString *)image type:(BFCustomerServiceViewButtonType)type {
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = frame;
    button.tag = type;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(chooseCustomerService:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:button];
    return button;
}

- (void)chooseCustomerService:(UIButton *)sender {
    [self hideView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToChooseCustomerServiceWithType:)]) {
        [self.delegate clickToChooseCustomerServiceWithType:sender.tag];
    }
}

@end
