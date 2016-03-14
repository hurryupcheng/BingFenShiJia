//
//  BFSegmentView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFSegmentView;
@protocol BFSegmentViewDelegate <NSObject>

- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl;

@end


@interface BFSegmentView : UIView
/**第一次进入页面自动调用点击第一个*/
- (void)click;
/**创建分段的类方法*/
+ (instancetype)segmentView;
/**标题数组*/
@property (nonatomic, strong) NSArray *titleArray;
/**代理*/
@property (nonatomic, weak) id<BFSegmentViewDelegate>delegate;
@end
