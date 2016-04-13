//
//  BFProductStockView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFProductDetialModel.h"
#import "BFCountView.h"

@interface BFProductStockView : UIView
/**加减按钮*/
@property (nonatomic, strong) BFCountView *countView;
/**BFProductDetialModel*/
@property (nonatomic, strong) BFProductDetialModel *model;
@end
