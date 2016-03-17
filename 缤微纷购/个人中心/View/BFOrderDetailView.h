//
//  BFOrderDetailView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFProductInfoModel.h"


@interface BFOrderDetailView : UIView
/**BFProductInfoModel模型类*/
@property (nonatomic, strong) BFProductInfoModel *model;
/**自定义类方法*/
+ (instancetype)detailView;
@end
