//
//  BFUserInfo.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFUserInfo : NSObject
/**id*/
@property (nonatomic, strong) NSString *ID;
/**手机号*/
@property (nonatomic, strong) NSString *tel;
/**用户名*/
@property (nonatomic, strong) NSString *username;
/**用户头像*/
@property (nonatomic, strong) NSString *user_icon;
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
@end
