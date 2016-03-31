//
//  BFModifyPasswordView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFModifyPasswordView;
@protocol BFModifyPasswordViewDelegate <NSObject>

- (void)clickToModifyPasswordWithView:(BFModifyPasswordView *)modifyPasswordView;

@end


@interface BFModifyPasswordView : UIView
/**原密码*/
@property (nonatomic, strong) UITextField *original;
/**新密码*/
@property (nonatomic, strong) UITextField *setting;
/**确认新密码*/
@property (nonatomic, strong) UITextField *confirm;
/**修改密码按钮*/
@property (nonatomic, strong) UIButton *modifyPasswordButton;
/**代理*/
@property (nonatomic, weak) id<BFModifyPasswordViewDelegate>delegate;
@end
