//
//  BFHeadSelectionView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]
#import "BFHeadSelectionView.h"

@interface BFHeadSelectionView()
/**背景图*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**相机按钮*/
@property (nonatomic, strong) UIButton *camera;
/**相册按钮*/
@property (nonatomic, strong) UIButton *album;
/**取消按钮*/
@property (nonatomic, strong) UIButton *cancle;

@end


@implementation BFHeadSelectionView

+ (instancetype)headSelectionView {
    BFHeadSelectionView *view = [[BFHeadSelectionView alloc] init];
    [view showHeadSelectionView];
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
//    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    //self.bgImageView.image = [UIImage imageNamed:@"customerservicebg"];
//    [self.bgImageView setImageToBlur:[UIImage imageNamed:@"customerservicebg"] blurRadius:20  completionBlock:nil];
    //self.backgroundColor= [UIColor redColor];
//    self.bgImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self  addGestureRecognizer:tap];
//    [self addSubview:self.bgImageView];
    
    self.camera = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(65), -BF_ScaleWidth(65), BF_ScaleWidth(65), BF_ScaleWidth(65)) image:@"camera" type:BFHeadSelectionViewButtonTypeCamera];
    
    
    self.album = [self setUpButtonWithFrame:CGRectMake(BF_ScaleWidth(190), -BF_ScaleWidth(65), BF_ScaleWidth(65), BF_ScaleWidth(65)) image:@"album" type:BFHeadSelectionViewButtonTypeAlbum];
    
    
    self.cancle = [UIButton buttonWithType:0];
    self.cancle.frame = CGRectMake(BF_ScaleWidth(147.5), ScreenHeight, BF_ScaleWidth(25), BF_ScaleWidth(25));
    //self.cancle.backgroundColor = [UIColor redColor];
    [self.cancle addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancle setImage:[UIImage imageNamed:@"cancle"] forState:UIControlStateNormal];
    [self addSubview:self.cancle];
    
}



- (void)showHeadSelectionView {
    [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:1 delay:0.1f usingSpringWithDamping:0.5f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = windowColor;
        self.camera.y = BF_ScaleHeight(450);
    } completion:nil];
    
    [UIView animateWithDuration:0.8 delay:0.2f usingSpringWithDamping:0.6f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.album.y = BF_ScaleHeight(450);
    } completion:nil];
    
    [UIView animateWithDuration:0.8 delay:0.1f usingSpringWithDamping:1.0f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.cancle.y = BF_ScaleHeight(530);
    } completion:nil];

}

- (void)hideHeadSelectionView {
    
    
    [UIView animateWithDuration:1 delay:0.12f usingSpringWithDamping:0.6f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.camera.y = BF_ScaleHeight(450) - ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.8 delay:0.1f usingSpringWithDamping:0.6f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.album.y = BF_ScaleHeight(450) - ScreenHeight;
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
    [BFSoundEffect playSoundEffect:@"composer_close.wav"];
    [self hideHeadSelectionView];
}

- (void)hide {
    [BFSoundEffect playSoundEffect:@"composer_close.wav"];
    [self hideHeadSelectionView];
}

- (UIButton *)setUpButtonWithFrame:(CGRect)frame image:(NSString *)image type:(BFHeadSelectionViewButtonType)type {
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = frame;
    button.tag = type;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(chooseHeadImage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

- (void)chooseHeadImage:(UIButton *)sender {
    [self hideHeadSelectionView];
    [BFSoundEffect playSoundEffect:@"composer_close.wav"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToChooseModeWithType:)]) {
        [self.delegate clickToChooseModeWithType:sender.tag];
    }
}

@end
