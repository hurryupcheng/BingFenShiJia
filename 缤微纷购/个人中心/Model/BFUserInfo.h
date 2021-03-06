//
//  BFUserInfo.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFUserInfo : NSObject
/**登录类型 1.qq 2.新浪 3.手机 wx.微信*/
@property (nonatomic, strong) NSString *loginType;
/**id*/
@property (nonatomic, strong) NSString *ID;
/**手机号*/
@property (nonatomic, strong) NSString *tel;
/**账户余额*/
@property (nonatomic, strong) NSString *user_account;
/**用户名*/
@property (nonatomic, strong) NSString *username;
/**用户头像*/
@property (nonatomic, strong) NSString *user_icon;
/**用户头像（不为空优先使用）*/
@property (nonatomic, strong) NSString *app_icon;
/**密码*/
@property (nonatomic, strong) NSString *password;
/**token*/
@property (nonatomic, strong) NSString *token;
/**请求状态*/
@property (nonatomic, strong) NSString *status;
/**请求返回信息*/
@property (nonatomic, strong) NSString *msg;
/**parent_proxy*/
@property (nonatomic, strong) NSString *parent_proxy;
/**注册时间*/
@property (nonatomic, strong) NSString *reg_time;
/**积分*/
@property (nonatomic, strong) NSString *score;
/**当月广告费*/
@property (nonatomic, strong) NSString *proxy_order_money;
/**我的客户*/
@property (nonatomic, strong) NSString *proxy_num;
/**我的推荐人*/
@property (nonatomic, strong) NSString *p_username;
/**银行*/
@property (nonatomic, strong) NSString *bank_name;
/**支行id，为0为手动填写*/
@property (nonatomic, strong) NSString *bank_branch;
/**银行卡号*/
@property (nonatomic, strong) NSString *card_id;
/**银行支行*/
@property (nonatomic, strong) NSString *card_address;
/**真实姓名*/
@property (nonatomic, strong) NSString *true_name;
/**昵称*/
@property (nonatomic, strong) NSString *nickname;
/**微信id*/
@property (nonatomic, strong) NSString *wechatid;
/**省份*/
@property (nonatomic, strong) NSString *sheng;
/**城市*/
@property (nonatomic, strong) NSString *shi;
/**是否是广告主 1.是广告主*/
@property (nonatomic, strong) NSString *is_vip;
/**广告主等级*/
@property (nonatomic, strong) NSString *vip_name;
/**银行所在城市*/
@property (nonatomic, strong) NSString *bank_city;
/**银行id*/
@property (nonatomic, strong) NSString *bank_id;
@end
