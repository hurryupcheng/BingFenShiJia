//
//  BFGroupDetailHeaderView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/1.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFGroupDetailModel.h"

@interface BFGroupDetailHeaderView : UIView
/**BFGroupDetailModel*/
@property (nonatomic, strong) BFGroupDetailModel *model;
/**返回的高度*/
@property (nonatomic, assign) CGFloat headerViewH;
@end
