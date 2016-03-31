//
//  BFPTStep.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/16.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFPTStepDelegate <NSObject>

- (void)goToCheckDetail;

@end


@interface BFPTStep : UIView


/**自定义方法*/
- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index;
/**代理*/
@property (nonatomic, weak) id<BFPTStepDelegate>delegate;
@end
