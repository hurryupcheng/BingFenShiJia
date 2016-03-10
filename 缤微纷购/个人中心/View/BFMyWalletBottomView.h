//
//  BFMyWalletBottomView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFMyWalletBottomViewDelegate <NSObject>

- (void)goToModifyBankCardInformation;

@end

@interface BFMyWalletBottomView : UIView
/**提现金额输入框*/
@property (nonatomic, strong) UITextField *getCashTX;
/**代理*/
@property (nonatomic, weak) id<BFMyWalletBottomViewDelegate>delegate;
@end
