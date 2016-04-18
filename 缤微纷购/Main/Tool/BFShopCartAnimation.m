//
//  BFShopCartAnimation.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFShopCartAnimation.h"

@implementation BFShopCartAnimation

- (void)shopCatrAnimationWithLayer:(CALayer *)layer startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint changeX:(CGFloat)changeX changeY:(CGFloat)changeY endScale:(CGFloat)endScale duration:(CFTimeInterval)duration isRotation:(BOOL)isRotation{
    CAKeyframeAnimation *CHAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddQuadCurveToPoint(path, NULL, changeX, changeY, endPoint.x, endPoint.y);
    CHAnimation.path = path;
    CHAnimation.fillMode = kCAFillModeBoth;
    CHAnimation.duration = duration;
    CHAnimation.delegate = self;
    [CHAnimation setAutoreverses:NO];
    CFRelease(path);
    
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    narrowAnimation.beginTime = 0.5;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    narrowAnimation.duration = duration;
    narrowAnimation.toValue = [NSNumber numberWithFloat:endScale];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.duration = duration;
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.4f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = duration/0.4f;
    
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    if (isRotation) {
        groups.animations = @[CHAnimation,narrowAnimation,rotationAnimation];
    }else {
        groups.animations = @[CHAnimation,narrowAnimation];
    }
    groups.duration = duration;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [layer addAnimation:groups forKey:@"group"];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationStop)]) {
        [self.delegate animationStop];
    }
}

@end
