//
//  BFProductDetailTabBar.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFProductDetailTabBar.h"



@interface BFProductDetailTabBar()

@property (strong, nonatomic) NSMutableArray<CALayer *> *redLayers;




@end


@implementation BFProductDetailTabBar

- (NSMutableArray<CALayer *> *)redLayers {
    if (!_redLayers) {
        _redLayers = [NSMutableArray array];
    }
    return _redLayers;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    BFShoppingCartButton *shoppingCart = [BFShoppingCartButton buttonWithType:0];
    self.shoppingCart = shoppingCart;
    shoppingCart.frame = CGRectMake(0, 0, BF_ScaleWidth(120), BF_ScaleHeight(50));
    shoppingCart.tag = BFProductDetailTabBarButtonTypeGoCart;
    [shoppingCart addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shoppingCart];
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:nil];
    //[[CXArchiveShopManager sharedInstance]startArchiveShop];
    NSArray *array = [[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop];
    if (array.count == 0 || userInfo == nil) {
        shoppingCart.badge.hidden = YES;
    }else {
        shoppingCart.badge.hidden = NO;
        shoppingCart.badge.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
    }
    
    UIButton *addToCart = [UIButton buttonWithType:0];
    addToCart.frame = CGRectMake(BF_ScaleWidth(180), BF_ScaleHeight(9), BF_ScaleWidth(105), BF_ScaleHeight(32));
    addToCart.tag = BFProductDetailTabBarButtonTypeAddCart;
    addToCart.backgroundColor = BFColor(0xF56B0A);
    [addToCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    addToCart.layer.cornerRadius = BF_ScaleHeight(9);
    [addToCart setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    [addToCart addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addToCart];
  
}

- (void)click:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithType:)]) {
        [self.delegate clickWithType:sender.tag];
    }
}






@end
