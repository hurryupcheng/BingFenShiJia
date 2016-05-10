//
//  BFGroupDetailTabbar.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/30.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define MarginW  BF_ScaleWidth(10)
#define MarginH  BF_ScaleHeight(15)
#define ButtonH  BF_ScaleHeight(40)
#import "BFGroupDetailTabbar.h"

@interface BFGroupDetailTabbar()
/** 返回首页 */
@property (nonatomic, strong) UIButton *homeButton;
/** 分享 */
@property (nonatomic, strong) UIButton *shareButton;

/** (团长分享)我要参团 */
@property (nonatomic, strong) UIButton *joinButton;
/** 组团成功，我要开新团*/
@property (nonatomic, strong) UIButton *successButton;
/** 组团失败，我要开新团*/
@property (nonatomic, strong) UIButton *failButton;
/** 还差几人组团成功*/
@property (nonatomic, strong) UIButton *lackButton;

@end

@implementation BFGroupDetailTabbar

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setTabbar];
    }
    return self;
}

- (void)setModel:(BFGroupDetailModel *)model {
    _model = model;
    if (model) {
        if ([model.status isEqualToString:@"1"]) {
            self.payButton.hidden = YES;
            self.payToJoinButton.hidden = YES;
            self.joinButton.hidden = YES;
            self.failButton.hidden = YES;
            self.successButton.hidden = NO;
            self.lackButton.hidden = YES;
        }else if ([model.status isEqualToString:@"2"]) {
            self.payButton.hidden = YES;
            self.payToJoinButton.hidden = YES;
            self.joinButton.hidden = YES;
            self.failButton.hidden = NO;
            self.successButton.hidden = YES;
            self.lackButton.hidden = YES;
        }else if ([model.status isEqualToString:@"0"]){
            if ([model.xinxi isEqualToString:@"1"]) {
                self.payButton.hidden = NO;
                self.payToJoinButton.hidden = YES;
                self.joinButton.hidden = YES;
                self.failButton.hidden = YES;
                self.successButton.hidden = YES;
                self.lackButton.hidden = YES;
            } else if ([model.xinxi isEqualToString:@"4"]) {
                self.payButton.hidden = YES;
                self.payToJoinButton.hidden = NO;
                self.joinButton.hidden = YES;
                self.failButton.hidden = YES;
                self.successButton.hidden = YES;
                self.lackButton.hidden = YES;
            } else if ([model.xinxi isEqualToString:@"2"]) {
                self.payButton.hidden = YES;
                self.payToJoinButton.hidden = YES;
                self.joinButton.hidden = YES;
                self.failButton.hidden = YES;
                self.successButton.hidden = YES;
                self.lackButton.hidden = NO;
                [self.lackButton setTitle:[NSString stringWithFormat:@"还差%ld人组团成功", (long)(model.havenum-model.thisteam.count)] forState:UIControlStateNormal];
            } else {
                self.payButton.hidden = YES;
                self.payToJoinButton.hidden = YES;
                self.joinButton.hidden = NO;
                self.failButton.hidden = YES;
                self.successButton.hidden = YES;
                self.lackButton.hidden = YES;
            }
        }
    }
}


- (void)setTabbar {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(70))];
    bottomView.backgroundColor = BFColor(0x000000);
    bottomView.alpha = 0.5;
    [self addSubview:bottomView];
    
    
    self.homeButton = [self setUpButtonWithFrame:CGRectMake(MarginW, MarginH, BF_ScaleWidth(40), ButtonH) image:@"group_detail_home" backgroundColor:BFColor(0x646464) type:BFGroupDetailTabbarButtonTypeHome title:nil];
    
    self.shareButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(self.homeButton.frame) + MarginW, MarginH, BF_ScaleWidth(40), ButtonH) image:@"group_detail_share" backgroundColor:BFColor(0x646464) type:BFGroupDetailTabbarButtonTypeShare title:nil];
    
    self.payButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(self.shareButton.frame) + MarginW, MarginH, BF_ScaleWidth(200), ButtonH) image:nil backgroundColor:BFColor(0xD4041E) type:BFGroupDetailTabbarButtonTypePay title:@"立即支付"];
    self.payButton.hidden = YES;
    
    self.payToJoinButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(self.shareButton.frame) + MarginW, MarginH, BF_ScaleWidth(200), ButtonH) image:nil backgroundColor:BFColor(0xD4041E) type:BFGroupDetailTabbarButtonTypePayToJoin title:@"立即支付参团"];
    self.payToJoinButton.hidden = YES;
    
    self.joinButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(self.shareButton.frame) + MarginW, MarginH, BF_ScaleWidth(200), ButtonH) image:nil backgroundColor:BFColor(0xD4041E) type:BFGroupDetailTabbarButtonTypeJoin title:@"我也要参团"];
    self.joinButton.hidden = YES;
    
    self.successButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(self.shareButton.frame) + MarginW, MarginH, BF_ScaleWidth(200), ButtonH) image:nil backgroundColor:BFColor(0xD4041E) type:BFGroupDetailTabbarButtonTypeSuccess title:@"组团成功，我要开新团"];
    self.successButton.hidden = YES;
    
    self.failButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(self.shareButton.frame) + MarginW, MarginH, BF_ScaleWidth(200), ButtonH) image:nil backgroundColor:BFColor(0xD4041E) type:BFGroupDetailTabbarButtonTypeFail title:@"组团失败，我要开新团"];
    self.failButton.hidden = YES;
    
    self.lackButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(self.shareButton.frame) + MarginW, MarginH, BF_ScaleWidth(200), ButtonH) image:nil backgroundColor:BFColor(0xD4041E) type:BFGroupDetailTabbarButtonTypeLack title:@"还差几人组团成功"];
    self.lackButton.hidden = YES;
}


- (UIButton *)setUpButtonWithFrame:(CGRect)frame image:(NSString *)image backgroundColor:(UIColor *)backgroundColor type:(BFGroupDetailTabbarButtonType)type title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:0];
    button.tag = type;
    button.backgroundColor = backgroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    button.frame = frame;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    //[button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return button;
}

- (void)click:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickEventWithType:)]) {
        [self.delegate clickEventWithType:sender.tag];
    }
}

@end
