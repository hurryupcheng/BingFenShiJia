//
//  BFProductInfoView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFProductInfoView : UIView
/**商品图片*/
@property (nonatomic, strong) UIImageView *productIcon;
/**商品标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**商品尺寸*/
@property (nonatomic, strong) UILabel *productSize;
@end
