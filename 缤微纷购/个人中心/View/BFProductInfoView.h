//
//  BFProductInfoView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFProductInfoView : UIView
/**商品图片*/
@property (nonatomic, strong) UIImageView *productIcon;
/**商品标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**商品颜色*/
@property (nonatomic, strong) UILabel *productColor;
/**商品尺寸*/
@property (nonatomic, strong) UILabel *productSize;
/**商品数量*/
@property (nonatomic, strong) UILabel *productCount;
/**商品价格*/
@property (nonatomic, strong) UILabel *productPrice;
/**商品配送方式*/
@property (nonatomic, strong) UILabel *productDeliveries;
/**商品总价*/
@property (nonatomic, strong) UILabel *productTotalPrice;
/**自定义类方法*/
+ (instancetype)productView;
@end
