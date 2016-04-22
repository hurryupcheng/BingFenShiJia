//
//  BFTastingExperienceFooterView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/22.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFTastingExperienceModel.h"

@protocol BFTastingExperienceFooterViewDelegate <NSObject>

- (void)gotoApply;

@end


@interface BFTastingExperienceFooterView : UIView

/**试吃数据模型*/
@property (nonatomic, strong) BFTastingExperienceModel *model;
/**代理*/
@property (nonatomic, weak) id<BFTastingExperienceFooterViewDelegate>delegate;
@end
