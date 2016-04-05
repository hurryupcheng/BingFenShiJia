//
//  BFStepView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFStepView : UIView
/**图标*/
@property (nonatomic, strong) UIImageView *numberImageView;
/**上Label*/
@property (nonatomic, strong) UILabel *upLabel;
/**下Label*/
@property (nonatomic, strong) UILabel *bottomLabel;

+ (id)setUpViewWithX:(CGFloat)x image:(NSString *)image title:(NSString *)title;

@end
