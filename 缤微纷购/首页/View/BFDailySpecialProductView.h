//
//  BFDailySpecialProductView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFDailySpecialModel.h"

@interface BFDailySpecialProductView : UIView
/**抢购商品模型*/
@property (nonatomic, strong) BFDailySpecialProductList *model;
/**购物车按钮*/
@property (nonatomic, strong) UIButton *shoppingCart;
@end
