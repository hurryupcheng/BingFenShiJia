//
//  BFMyWalletBottomView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMyWalletModel.h"
@class BFMyWalletBottomView;
@protocol BFMyWalletBottomViewDelegate <NSObject>

- (void)goToModifyBankCardInformation;
/**点击确认提现的代理*/
- (void)gotoGetCashWithView:(BFMyWalletBottomView *)view;

@end

@interface BFMyWalletBottomView : UIView
/**收款人*/
@property (nonatomic, strong) UILabel *recieverLabel;
/**提现金额输入框*/
@property (nonatomic, strong) UITextField *getCashTX;
/**代理*/
@property (nonatomic, weak) id<BFMyWalletBottomViewDelegate>delegate;
/**我的钱包模型*/
@property (nonatomic, strong) BFMyWalletModel *model;
@end
