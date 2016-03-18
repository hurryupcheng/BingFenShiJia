//
//  BFAddressController.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAddressModel.h"
@interface BFAddressController : UIViewController
@property (nonatomic, copy)void (^block)(BFAddressModel *model);
@end
