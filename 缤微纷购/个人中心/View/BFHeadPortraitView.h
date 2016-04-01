//
//  BFHeadPortraitView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/31.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFGroupDetailModel.h"

@interface BFHeadPortraitView : UIView


/** */
@property (nonatomic, strong) BFGroupDetailModel *model;
/**返回的头像视图的高度*/
@property (nonatomic, assign) CGFloat headPortraitViewH;
@end
