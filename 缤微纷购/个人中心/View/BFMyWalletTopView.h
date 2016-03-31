//
//  BFMyWalletTopView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMyWalletModel.h"

typedef enum {
    BFMyWalletTopButtonTypeBalance,//余额
    BFMyWalletTopButtonTypeRecord,//提现记录
    BFMyWalletTopButtonTypeFrozen//冻结金额
} BFMyWalletTopButtonType;


@protocol BFMyWalletTopViewDelegate <NSObject>

- (void)goToCheckWithdrawalRecordWithType:(BFMyWalletTopButtonType)type;

@end


@interface BFMyWalletTopView : UIView

/**我的钱包模型*/
@property (nonatomic, strong) BFMyWalletModel *model;
/**代理*/
@property (nonatomic, weak) id<BFMyWalletTopViewDelegate>delegate;
@end
