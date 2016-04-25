//
//  BFUserDefaluts.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFUserInfo.h"
#import "BFBankModel.h"
#import "BFCityInfo.h"

@interface BFUserDefaluts : NSObject
/**获取user信息*/
+ (BFUserInfo *)getUserInfo;
/**修改user信息*/
+ (void)modifyUserInfo:(BFUserInfo *)userInfo;
/**移除user信息*/
+ (void)removeUserInfo;
/**获取支行信息*/
+ (BFBankModel *)getBankInfo;
/**修改支行信息*/
+ (void)modifyBankInfo:(BFBankModel *)bankInfo;
/**获取城市信息*/
+ (BFCityInfo *)getCityInfo;
/**修改城市信息*/
+ (void)modifyCityInfo:(BFCityInfo *)CityInfo;

/**获取第三方登录信息*/
//+ (BFThirdPartyLoginUserInfo *)getThirdPartyLoginUserInfo;
///**修改第三方登录信息*/
//+ (void)modifyThirdPartyLoginUserInfo:(BFThirdPartyLoginUserInfo *)thirdPartyLoginUserInfo;
///**移除第三方登录信息*/
//+ (void)removeThirdPartyLoginUserInfo;
@end
