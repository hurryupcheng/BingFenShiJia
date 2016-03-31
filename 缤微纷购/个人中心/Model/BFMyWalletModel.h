//
//  BFMyWalletModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFMyWalletModel : NSObject
/**余额*/
@property (nonatomic, strong) NSString *user_account;
/**提现记录*/
@property (nonatomic, strong) NSString *withdraw_account;
/**冻结金额*/
@property (nonatomic, strong) NSString *freeze_amount;
/**银行id*/
@property (nonatomic, strong) NSString *bank_id;
/**支行*/
@property (nonatomic, strong) NSString *bank_branch;
/**银行名称*/
@property (nonatomic, strong) NSString *bank_name;
/**真实姓名*/
@property (nonatomic, strong) NSString *true_name;
/**银行卡号*/
@property (nonatomic, strong) NSString *card_id;
/**地址*/
@property (nonatomic, strong) NSString *card_address;
/**银行状态，当card_id，true_name，card_address为空才返回*/
@property (nonatomic, strong) NSString *bank_status;
/**当card_id，true_name，card_address为空才返回*/
@property (nonatomic, strong) NSString *bank_msg;
@end
