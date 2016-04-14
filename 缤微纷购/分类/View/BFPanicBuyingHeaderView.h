//
//  BFPanicBuyingHeaderView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFPanicBuyingModel.h"
#import "BFPanicBuyingDetailView.h"

@interface BFPanicBuyingHeaderView : UIView
/**BFPanicBuyingModel*/
@property (nonatomic, strong) BFPanicBuyingModel *model;
/**倒计时view*/
@property (nonatomic, strong) BFPanicBuyingDetailView *detailView;
/**头部视图高度*/
@property (nonatomic, assign) CGFloat headerHeight;
@end
