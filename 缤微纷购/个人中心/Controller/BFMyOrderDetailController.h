//
//  BFMyOrderDetailController.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMyOrderDetailController : UIViewController
/**订单编号*/
@property (nonatomic, strong) NSString *orderId;
/**回调*/
@property (nonatomic, copy) void (^block)(BOOL isOperated);
@end
