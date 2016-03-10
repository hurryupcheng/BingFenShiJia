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

//修改user信息
+ (void)modifyUserInfo:(BFUserInfo *)userInfo{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"UserInfo"];
}
@end
