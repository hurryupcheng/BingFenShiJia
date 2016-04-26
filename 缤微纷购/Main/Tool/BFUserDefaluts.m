//
//  BFUserDefaluts.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFUserDefaluts.h"

@implementation BFUserDefaluts

///**获取第三方登录信息*/
//+ (BFThirdPartyLoginUserInfo *)getThirdPartyLoginUserInfo {
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"ThirdPartyLoginUserInfo"];
//    BFThirdPartyLoginUserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    return userInfo;
//}
///**修改第三方登录信息*/
//+ (void)modifyThirdPartyLoginUserInfo:(BFThirdPartyLoginUserInfo *)thirdPartyLoginUserInfo {
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:thirdPartyLoginUserInfo];
//    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"ThirdPartyLoginUserInfo"];
//}

+ (void)removeThirdPartyLoginUserInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ThirdPartyLoginUserInfo"];
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
