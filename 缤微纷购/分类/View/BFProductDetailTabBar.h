//
//  BFProductDetailTabBar.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFShoppingCartButton.h"
typedef enum {
    /**购物车按钮*/
    BFProductDetailTabBarButtonTypeGoCart,
    /**加入购物车按钮*/
    BFProductDetailTabBarButtonTypeAddCart
}BFProductDetailTabBarButtonType;

@protocol BFProductDetailTabBarDelegate <NSObject>

- (void)clickWithType:(BFProductDetailTabBarButtonType)type;

@end

@interface BFProductDetailTabBar : UIView
//购物车按钮
@property (nonatomic, strong) BFShoppingCartButton *shoppingCart;
/**代理*/
@property (nonatomic, weak) id<BFProductDetailTabBarDelegate>delegate;
@end
