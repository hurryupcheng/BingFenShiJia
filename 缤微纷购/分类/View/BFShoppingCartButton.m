//
//  BFShoppingCartButton.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFShoppingCartButton.h"

@implementation BFShoppingCartButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.shoppingCart = [[UIImageView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(8), BF_ScaleWidth(120), BF_ScaleHeight(34))];
        self.shoppingCart.image = [UIImage imageNamed:@"shoppingCart"];
        self.shoppingCart.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.shoppingCart];
    }
    return self;
}

@end
