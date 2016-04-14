//
//  BFPanicBuyingDetailView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFPanicBuyingModel.h"
#import "BFPanicCountView.h"

@interface BFPanicBuyingDetailView : UIView
/**BFPanicBuyingModel*/
@property (nonatomic, strong) BFPanicBuyingModel *model;
/**加减按钮*/
@property (nonatomic, strong) BFPanicCountView *countView;
@end
