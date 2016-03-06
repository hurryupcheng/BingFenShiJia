//
//  BFPersonalCenterTopView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    BFPersonalCenterTopButtonTypeIntegral,//积分
    BFPersonalCenterTopButtonTypeAdvertisingExpense,//本月广告费
    BFPersonalCenterTopButtonTypeMyClient//我的客户
} BFPersonalCenterTopButtonType;


/**设置头像代理*/
@protocol BFPersonalCenterTopViewDelegate <NSObject>
/**设置按钮的方法*/
- (void)goToSettingInterface;
/**头像按钮点击方法*/
- (void)goToUserHeadInterface;
/**登录按钮点击方法*/
- (void)goToLoginInterface;
/**注册点击方法*/
- (void)goToRegisterInterface;
/**积分，广告费，我的客户按钮点击方法*/
- (void)goToPersonalCenterTopButtoInterfaceWithType:(BFPersonalCenterTopButtonType)type;

@end


@interface BFPersonalCenterTopView : UIView
/**个人中心头部视图的代理*/
@property (nonatomic, weak) id<BFPersonalCenterTopViewDelegate> delegate;

@end
