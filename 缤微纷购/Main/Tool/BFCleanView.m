//
//  BFCleanView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]
#import "BFCleanView.h"

@interface BFCleanView()
/**imageview*/
@property (nonatomic, strong) UIImageView *clean;
@end

@implementation BFCleanView

+ (instancetype)cleanView {
    BFCleanView *clean = [[BFCleanView alloc] init];
    [clean showView];
    return clean;
}

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.clean = [[UIImageView alloc] init];
    self.clean.centerX = self.centerX;
    self.clean.centerY = self.centerY;
    self.clean.width = 0;
    self.clean.height = 0;
    self.clean.image = [UIImage imageNamed:@"clean"];
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(M_PI );
    self.clean.transform = endAngle;
    [self addSubview:self.clean];
}

- (void)showView {
    [BFSoundEffect playSoundEffect:@"composer_open.wav"];
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:1 delay:0.5f usingSpringWithDamping:0.5f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.clean.transform = CGAffineTransformRotate(self.clean.transform, M_PI);
        self.clean.width = BF_ScaleWidth(100);
        self.clean.height = BF_ScaleWidth(100);
        self.clean.centerX = self.centerX;
        self.clean.centerY = self.centerY;
        self.backgroundColor = windowColor;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.clean.width = BF_ScaleWidth(120);
            self.clean.height = BF_ScaleWidth(120);
            self.clean.centerX = self.centerX;
            self.clean.centerY = self.centerY;
        } completion:^(BOOL finished) {
            [BFSoundEffect playSoundEffect:@"composer_close.wav"];
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1.f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.clean.width = 0;
                self.clean.height = 0;
                self.clean.centerX = self.centerX;
                self.clean.centerY = self.centerY;
                self.backgroundColor = [UIColor clearColor];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }];
}

@end
