//
//  BFShareView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BFShareButtonTypeMoments,//微信朋友圈
    BFShareButtonTypeQQZone,//QQ空间
    BFShareButtonTypeQQFriends,//QQ好友
    BFShareButtonTypeSinaBlog,//新浪微博
    BFShareButtonTypeWechatFriends//微信好友
}BFShareButtonType;

@class BFShareView;
@protocol BFShareViewDelegate <NSObject>

- (void)shareView:(BFShareView *)shareView type:(BFShareButtonType)type;

@end



@interface BFShareView : UIView

/**代理*/
@property (nonatomic, weak) id<BFShareViewDelegate>delegate;

+ (instancetype)shareView;

//+ (instancetype)shareView:(NSString *)title image:(NSString *)image content:(NSString *)content url:(NSString *)url;

@end
