//
//  BFMyCustomerModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/24.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFCustomerList;
@interface BFMyCustomerModel : NSObject
/**分页数*/
@property (nonatomic, assign) NSInteger page_count;
/**团队人数*/
@property (nonatomic, strong) NSString *team_num;
/**直推人数*/
@property (nonatomic, strong) NSString *sub_num;
/**未关注*/
@property (nonatomic, strong) NSString *n_follow;
/**已关注*/
@property (nonatomic, strong) NSString *y_follow;
/**数组*/
@property (nonatomic, strong) NSArray<BFCustomerList *> *sub_list;
@end

@interface BFCustomerList : NSObject
/**id*/
@property (nonatomic, strong) NSString *ID;
/**昵称*/
@property (nonatomic, strong) NSString *nickname;
/**加入时间*/
@property (nonatomic, strong) NSString *reg_time;
/**头像地址*/
@property (nonatomic, strong) NSString *user_icon;
/**团队人数*/
@property (nonatomic, strong) NSString *sub_team_num;


@end


