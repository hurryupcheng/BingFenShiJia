//
//  BFGroupDetailFooterView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailFooterView.h"
#import "BFGroupDetailBottomStatusView.h"
#import "BFGroupDetailIntroduceView.h"

@interface BFGroupDetailFooterView()
/**状态栏*/
@property (nonatomic, strong) BFGroupDetailBottomStatusView *statusView;
/**拼团玩法*/
@property (nonatomic, strong) BFGroupDetailIntroduceView *introduceView;
@end

@implementation BFGroupDetailFooterView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
        
        
    }
    return self;
}

- (void)setModel:(BFGroupDetailModel *)model {
    _model = model;
    if (model) {
        self.statusView = [[BFGroupDetailBottomStatusView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(75))];
        self.statusView.model = model;
        [self addSubview:self.statusView];
        
        self.introduceView = [[BFGroupDetailIntroduceView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.statusView.frame), ScreenWidth, BF_ScaleHeight(80))];
        self.introduceView.model = model;
        [self addSubview:self.introduceView];
    }
}

- (void)setView {
    
}

@end
