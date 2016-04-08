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

+ (BFBankModel *)getBankInfo {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"bankInfo"];
    BFBankModel *bankInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return bankInfo;
}

//修改user信息
+ (void)modifyBankInfo:(BFBankModel *)bankInfo {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:bankInfo];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"bankInfo"];
}
@end
