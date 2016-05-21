//
//  BFAccountBindingController.h
//  缤微纷购
//
//  Created by 程召华 on 16/5/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFAccountBindingController : UIViewController
/**字典参数*/
@property (nonatomic, strong) NSMutableDictionary *parameter;

@property (nonatomic, strong) void (^block)(BFUserInfo *userInfo);
@end
