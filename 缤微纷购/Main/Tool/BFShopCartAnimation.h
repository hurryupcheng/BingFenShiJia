//
//  BFShopCartAnimation.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BFShopCartAnimationDelegate <NSObject>
//动画结束后，移除layer
- (void)animationStop;

@end

@interface BFShopCartAnimation : NSObject
/**代理*/
@property (nonatomic, weak) id<BFShopCartAnimationDelegate>delegate;
/**
 *  购物车动画效果
 *
 *  @param layer      需要动画的layer
 *  @param startPoint 动画起点
 *  @param endPoint   动画终点
 *  @param changeX    动画改变点X
 *  @param changeY    动画改变点Y
 *  @param endScale   layer最终的比例
 *  @param duration   动画时长
 *  @param isRotation 是否旋转
 */
- (void)shopCatrAnimationWithLayer:(CALayer *)layer startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint changeX:(CGFloat)changeX changeY:(CGFloat)changeY endScale:(CGFloat)endScale duration:(CFTimeInterval)duration isRotation:(BOOL)isRotation;
@end
