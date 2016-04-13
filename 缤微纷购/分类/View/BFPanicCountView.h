//
//  BFPanicCountView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFPanicBuyingModel.h"

@interface BFPanicCountView : UIView<UITextFieldDelegate>
/**数量*/
@property (nonatomic, strong) UITextField *countTX;
/**BFPanicBuyingModel*/
@property (nonatomic, strong) BFPanicBuyingModel *model;
@end
