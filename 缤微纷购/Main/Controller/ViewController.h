//
//  ViewController.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

CG_INLINE
CGRect CGRectMake1(CGFloat x,CGFloat y,CGFloat Width,CGFloat Height){
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    CGRect rect;
    rect.origin.x = x * app.proportionX;
    rect.origin.y = y * app.proportionY;
    rect.size.width = Width * app.proportionX;
    rect.size.height = Height * app.proportionY;
    return rect;
}

CG_INLINE
CGFloat CGFloatY(CGFloat y){
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    return y * app.proportionX;
}


@interface ViewController : UIViewController


@end

