//
//  BFModifyBankDetailInfoView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFModifyBankDetailInfoView : UIView
/**银行卡号textField*/
@property (nonatomic, strong) UITextField *cardNumberTX;
/**开户人textField*/
@property (nonatomic, strong) UITextField *nameTX;
/**昵称label*/
@property (nonatomic, strong) UILabel *nickName;
/**手机号码label*/
@property (nonatomic, strong) UILabel *telephone;
@end
