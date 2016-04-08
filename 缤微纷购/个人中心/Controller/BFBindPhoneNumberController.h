//
//  BFBindPhoneNumberController.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFBindPhoneNumberController : UIViewController
@property (nonatomic, strong) void (^block)(BFUserInfo *userInfo);
@end
