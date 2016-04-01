//
//  BFGroupDetailCountdownView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/1.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailCountdownView.h"

@interface BFGroupDetailCountdownView()

/***/
@property (nonatomic, strong) UILabel *helpLabel;
/***/
@property (nonatomic, strong) UILabel *statusLabel;
/***/
@property (nonatomic, strong) UILabel *hourLabel;
/***/
@property (nonatomic, strong) UILabel *minuteLabel;
/***/
@property (nonatomic, strong) UILabel *secondLabel;
/***/
@property (nonatomic, strong) UILabel *endLabel;
/***/
@property (nonatomic, strong) UILabel *lackLabel;
@end

@implementation BFGroupDetailCountdownView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    
}

@end
