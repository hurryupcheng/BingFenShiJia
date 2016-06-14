//
//  BFPassWordView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFPassWordView;
@protocol RegisterDelegate <NSObject>

- (void)userRigisterWithBFPassWordView:(BFPassWordView *)BFPassWordView;

@end

@interface BFPassWordView : UIView<UITextFieldDelegate>
/**验证码框*/
@property (nonatomic, strong) UITextField *verificationCodeTX;
/**第一次密码*/
@property (nonatomic, strong) UITextField *firstPasswordTX;
/**第二次密码*/
@property (nonatomic, strong) UITextField *secondPasswordTX;
/**手机号输入框*/
@property (nonatomic, strong) UITextField *phoneTX;


/**代理*/
@property (nonatomic, weak) id<RegisterDelegate>delegate;
@end
