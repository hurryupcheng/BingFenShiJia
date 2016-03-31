//
//  BFWithdrawalRecordModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFWithdrawalRecordList;
@interface BFWithdrawalRecordModel : NSObject
/**总页数*/
@property (nonatomic, assign) NSInteger page_num;
/**总页数*/
@property (nonatomic, strong) NSArray <BFWithdrawalRecordList *> *withdraw_detail;
@end

@interface BFWithdrawalRecordList : NSObject
/**提现时间*/
@property (nonatomic, strong) NSString *addtime;
/**提现时间*/
@property (nonatomic, strong) NSString *jiner;
/**提现时间*/
@property (nonatomic, strong) NSString *actual_amount;
@end