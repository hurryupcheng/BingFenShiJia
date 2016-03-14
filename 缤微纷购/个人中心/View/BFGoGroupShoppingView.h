//
//  BFGoGroupShoppingView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFGoGroupShoppingView : UIView

+ (instancetype)createView;
/**去开团*/
@property (nonatomic, strong) UILabel *goGroupLabel;
/**人数和价格*/
@property (nonatomic, strong) UILabel *infoLabel;
/**固定icon*/
@property (nonatomic, strong) UIImageView *iconImageView;
@end
