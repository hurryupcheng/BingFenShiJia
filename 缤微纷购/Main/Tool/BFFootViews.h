//
//  BFFootViews.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFFootViews : UIView

@property (nonatomic,retain)UILabel *money;
@property (nonatomic,retain)UIButton *buyButton;

- (instancetype)initWithFrame:(CGRect)frame money:(NSString *)money name:(NSString *)name;

@end
