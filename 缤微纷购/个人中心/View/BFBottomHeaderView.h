//
//  BFBottomHeaderView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFBottomHeaderViewDelegate <NSObject>

- (void)clickToChangeStatus:(UIButton *)button;

@end

@interface BFBottomHeaderView : UIView
/**时间日期label*/
@property (nonatomic, strong) UILabel *timeLabel;
/**代理*/
@property (nonatomic, weak) id<BFBottomHeaderViewDelegate>delegate;
/**点击按钮*/
- (void)click;
@end
