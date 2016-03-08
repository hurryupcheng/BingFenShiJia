//
//  BFAddRecommenderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAddRecommenderView.h"

@interface BFAddRecommenderView()
//背景图
@property (nonatomic, strong) UIView *blackV;

@end

@implementation BFAddRecommenderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    self.blackV = [[UIView alloc]initWithFrame:self.bounds];
    self.blackV.alpha = YES;
    self.blackV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.blackV addGestureRecognizer:tap];
    [self addSubview:self.blackV];
    
    UILabel *label = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(150), BF_ScaleWidth(300), BF_ScaleHeight(15)) font:BF_ScaleFont(15) textColor:BFColor(0xffffff) text:@"请输入推荐人ID号："];
    [self.blackV addSubview:label];
    
    self.IDTextField = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(label.frame)+BF_ScaleHeight(5), BF_ScaleWidth(300), BF_ScaleHeight(30)) image:nil placeholder:nil];
    self.IDTextField .backgroundColor = BFColor(0xffffff);
    self.IDTextField .layer.borderColor = BFColor(0xffffff).CGColor;
    self.IDTextField .layer.borderWidth = 1;
    self.IDTextField .layer.cornerRadius = 3;
    [self.blackV addSubview:self.IDTextField ];
    
    UIButton *sureButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.IDTextField .frame)+BF_ScaleHeight(20), BF_ScaleWidth(80), BF_ScaleHeight(30)) title:@"确定" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
    sureButton.layer.cornerRadius = 3;
    sureButton.backgroundColor = BFColor(0xD70011);
    [sureButton addTarget:self action:@selector(makeSureToAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.blackV addSubview:sureButton];
    
    UIButton *cancleButton = [UIButton buttonWithFrame:CGRectMake(ScreenWidth/2+BF_ScaleWidth(20), CGRectGetMaxY(self.IDTextField .frame)+BF_ScaleHeight(20), BF_ScaleWidth(80), BF_ScaleHeight(30)) title:@"取消" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
    cancleButton.layer.cornerRadius = 3;
    cancleButton.backgroundColor = BFColor(0x0BBC0E);
    [cancleButton addTarget:self action:@selector(cancleToAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.blackV addSubview:cancleButton];

}

- (void)makeSureToAdd {
    [self endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sureToAddRecommenderWithView:)]) {
        [self.delegate sureToAddRecommenderWithView:self];
    }
    BFLog(@"确定添加");
}

- (void)cancleToAdd {
    BFLog(@"取消添加");
    [self dismissView];
}

- (void)showView {
    self.isShow = YES;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    window.frame = self.frame;
}

- (void)dismissView {
    [self removeFromSuperview];
}

- (void)closeKeyboard {
    [self endEditing:YES];
}

@end
