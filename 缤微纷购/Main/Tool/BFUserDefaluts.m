//
//  BFUserDefaluts.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFUserDefaluts.h"

@implementation BFUserDefaluts



+ (NSNumber *)getSwitchInfo {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"switch"];
}
+ (void)modifySwitchInfo:(NSNumber *)info {
    [[NSUserDefaults standardUserDefaults]setObject:info forKey:@"switch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BFUserInfo *)getUserInfo {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
    BFUserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userInfo;
}

//修改user信息
+ (void)modifyUserInfo:(BFUserInfo *)userInfo{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"UserInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeUserInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserInfo"];
}


/**获取城市信息*/
+ (BFCityInfo *)getCityInfo {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
    BFCityInfo *cityInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return cityInfo;

}
/**修改城市信息*/
+ (void)modifyCityInfo:(BFCityInfo *)CityInfo {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:CityInfo];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"currentCity"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
