//
//  BFMyAdvertisingExpenseTabbar.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMyAdvertisingExpenseModel.h"
@interface BFMyAdvertisingExpenseTabbar : UIView
/**自定义实例方法*/
+ (instancetype)myTabbar;

@property (nonatomic, strong) BFMyAdvertisingExpenseModel *model;
@end
