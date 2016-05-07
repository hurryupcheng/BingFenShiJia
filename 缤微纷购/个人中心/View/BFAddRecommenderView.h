//
//  BFAddRecommenderView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFAddRecommenderView;
@protocol AddRecommenderViewDelegate <NSObject>

- (void)sureToAddRecommenderWithView:(BFAddRecommenderView *)view;

- (void)hideView;
@end

@interface BFAddRecommenderView : UIView

@property (nonatomic,assign)BOOL isShow;
/**ID输入框*/
@property (nonatomic, strong) UITextField *IDTextField;
/**确认代理*/
@property (nonatomic, weak) id<AddRecommenderViewDelegate>delegate;
/**显示弹出框*/
- (void)showView;
/**取消弹出框*/
- (void)dismissView;

@end
