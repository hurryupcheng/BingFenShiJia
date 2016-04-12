//
//  BFProductDetailHeaderView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFProductDetialModel.h"

@interface BFProductDetailHeaderView : UIView
/**BFProductDetialModel*/
@property (nonatomic, strong) BFProductDetialModel *model;
/**头部视图高度*/
@property (nonatomic, assign) CGFloat headerHeight;
@end
