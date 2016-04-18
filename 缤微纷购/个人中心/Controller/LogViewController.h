//
//  LogViewController.h
//  缤微纷购
//
//  Created by 郑洋 on 16/2/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /**QQ登录*/
    BFThirdLoginTypeQQ,
    BFThirdLoginTypeAlipay,
    /**微博登录*/
    BFThirdLoginTypeSina,
    /**微信登录*/
    BFThirdLoginTypeWechat
} BFThirdLoginType;


@interface LogViewController : UIViewController

@end
