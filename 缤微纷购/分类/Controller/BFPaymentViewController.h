//
//  BFPaymentViewController.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFPaymentViewController : UIViewController
@property (nonatomic,copy)void (^payBlock)(NSString *str);
@end
