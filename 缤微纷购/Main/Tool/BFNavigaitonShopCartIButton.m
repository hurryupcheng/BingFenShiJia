//
//  BFNavigaitonShopCartIButton.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFNavigaitonShopCartIButton.h"

@implementation BFNavigaitonShopCartIButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.shoppingCart = [[UIImageView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(5), BF_ScaleWidth(30), BF_ScaleHeight(30))];
        //self.shoppingCart.backgroundColor = [UIColor blueColor];
        self.shoppingCart.image = [UIImage imageNamed:@"ff1"];
        self.shoppingCart.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.shoppingCart];
        
        self.badge = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), BF_ScaleHeight(2), BF_ScaleHeight(18), BF_ScaleHeight(18))];
        self.badge.backgroundColor = [UIColor redColor];
        self.badge.textColor = BFColor(0xffffff);
        self.badge.font = [UIFont systemFontOfSize:BF_ScaleFont(10)];
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.text = @"99";
        self.badge.layer.cornerRadius = BF_ScaleHeight(9);
        self.badge.layer.masksToBounds = YES;
        [self addSubview:self.badge];
    }
    return self;
}


@end
