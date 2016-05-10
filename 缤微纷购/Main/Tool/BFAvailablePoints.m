//
//  BFAvailablePoints.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAvailablePoints.h"

@implementation BFAvailablePoints

+ (void)updateAvailablePoints {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=score_list"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        if (responseObject) {
            userInfo.score = responseObject[@"score"];
            [BFUserDefaluts modifyUserInfo:userInfo];
        }
    } failure:^(NSError *error) {
        BFLog(@"%@", error);
    }];
}

@end
