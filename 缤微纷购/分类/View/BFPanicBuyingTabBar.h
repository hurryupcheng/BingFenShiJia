//
//  BFPanicBuyingTabBar.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFPanicBuyingTabBarDelegate <NSObject>

- (void)clickToPanic;

@end

@interface BFPanicBuyingTabBar : UIView
/**代理*/
@property (nonatomic, weak) id<BFPanicBuyingTabBarDelegate>delegate;
@end
