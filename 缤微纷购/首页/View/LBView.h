//
//  LBView.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBView;

@protocol LBViewDelegate <NSObject>

- (void)LBViewDelegate:(LBView *)lbView didSelected:(NSInteger)index;

@end

@interface LBView : UIView

@property (nonatomic,retain)UIPageControl *pageC;
@property (nonatomic,retain)NSArray *dataArray;
@property (nonatomic,assign) BOOL isServiceLoadingImage; //是否从网上加载图片
@property (nonatomic,assign)id<LBViewDelegate>delegateLB;

@end
