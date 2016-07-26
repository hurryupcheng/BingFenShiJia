//
//  BFLogisticsHeaderView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFLogisticsHeaderViewDelegate <NSObject>

@optional
- (void)clickToSeeConmmonProblem;

@end

@interface BFLogisticsHeaderView : UIView
/**自定义方法*/
+ (instancetype)createHeaderView;
/**代理*/
@property (nonatomic, weak) id<BFLogisticsHeaderViewDelegate>delegate;
@end
