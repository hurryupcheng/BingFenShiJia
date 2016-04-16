//
//  BFBindPhoneNumberView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/16.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BFBindPhoneNumberViewDelegate <NSObject>

- (void)gotoLoginController:(BFUserInfo *)userInfo;

@end

@interface BFBindPhoneNumberView : UIView<UITextFieldDelegate>
/**验证码框*/
@property (nonatomic, strong) UITextField *verificationCodeTX;
/**第一次密码*/
@property (nonatomic, strong) UITextField *firstPasswordTX;
/**第二次密码*/
@property (nonatomic, strong) UITextField *secondPasswordTX;
/**手机号输入框*/
@property (nonatomic, strong) UITextField *phoneTX;
/**代理*/
@property (nonatomic, weak) id<BFBindPhoneNumberViewDelegate>delegate;
@end
