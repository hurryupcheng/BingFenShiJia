//
//  BForder.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BForder : UIView

@property (nonatomic,retain)UIImageView *img;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *money;
@property (nonatomic,retain)UILabel *guige;
@property (nonatomic,retain)UILabel *number;

- (instancetype)initWithFrame:(CGRect)frame img:(NSString *)img title:(NSString *)title money:(NSString *)money guige:(NSString *)guige number:(NSString *)number;

@end
