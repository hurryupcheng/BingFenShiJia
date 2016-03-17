//
//  BFPTStep.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/16.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFPTStep : UIView

@property (nonatomic,retain)UIButton *stepBut;
- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index;

@end
