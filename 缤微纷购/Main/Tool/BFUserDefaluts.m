//
//  BFUserDefaluts.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFUserDefaluts.h"

@implementation BFUserDefaluts
+ (BFUserInfo *)getUserInfo {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
    BFUserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userInfo;
}
@end
