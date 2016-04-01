//
//  BFGroupDetailHeaderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/1.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailHeaderView.h"
#import "BFGroupDetailStatusView.h"
#import "BFGroupDetailProductView.h"
#import "BFHeadPortraitView.h"
#import "BFGroupDetailCountdownView.h"

@interface BFGroupDetailHeaderView()
/**自定义状态view*/
@property (nonatomic, strong) BFGroupDetailStatusView *statusView;
/**自定义产品视图*/
@property (nonatomic, strong) BFGroupDetailProductView *productView;
/**头像视图*/
@property (nonatomic, strong) BFHeadPortraitView *headPortrait;
/**倒计时视图*/
@property (nonatomic, strong) BFGroupDetailCountdownView *countdownView;
@end


@implementation BFGroupDetailHeaderView

- (BFGroupDetailStatusView *)statusView {
    if (!_statusView) {
        _statusView = [[BFGroupDetailStatusView alloc] initWithFrame:CGRectMake(0, 0, ScreenHeight, BF_ScaleHeight(70))];
        [self addSubview:_statusView];
    }
    return _statusView;
}

- (BFGroupDetailProductView *)productView {
    if (!_productView) {
        _productView = [[BFGroupDetailProductView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.statusView.frame), ScreenWidth, BF_ScaleHeight(110))];
        [self addSubview:_productView];
    }
    return _productView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xCACACA);
        [self setView];
    }
    return self;
}

- (void)setModel:(BFGroupDetailModel *)model {
    _model = model;
    if (model) {
        self.statusView.model = model;
        
        self.productView.model = model;
        
        self.headPortrait = [[BFHeadPortraitView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.productView.frame)+BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(60) * ((model.havenum+4)/5))];
        self.headPortrait.model = model;
        [self addSubview:self.headPortrait];
        
        self.countdownView = [[BFGroupDetailCountdownView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headPortrait.frame)+BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(75))];
        self.countdownView.model = model;
        [self addSubview:self.countdownView];
        
        self.headerViewH = CGRectGetMaxY(self.countdownView.frame);
        
       
    }
}

- (void)setView {

    
}

@end
