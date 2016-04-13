//
//  BFPanicBuyingHeaderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPanicBuyingHeaderView.h"
#import "BFPanicTimeView.h"
@interface BFPanicBuyingHeaderView()
/**轮播图*/
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
/**倒计时view*/
@property (nonatomic, strong) BFPanicTimeView *panicTime;
@end

@implementation BFPanicBuyingHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setModel:(BFPanicBuyingModel *)model {
    _model = model;
    if (model) {
        self.cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleWidth(320))];
        self.cycleScrollView.currentPageDotColor = BFColor(0xFF0000);
        self.cycleScrollView.pageDotColor = BFColor(0xffffff);
        self.cycleScrollView.pageControlDotSize = CGSizeMake(BF_ScaleHeight(8), BF_ScaleHeight(8));
        self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        NSArray *array = [BFPanicBuyingCarouselList parse:model.imgs];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (BFPanicBuyingCarouselList *list in array) {
            [mutableArray addObject:list.url];
        }
        self.cycleScrollView.imageURLStringsGroup = [mutableArray copy];
        [self addSubview:self.cycleScrollView];
        
        self.panicTime = [[BFPanicTimeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(40))];
        self.panicTime.model = model;
        [self addSubview:self.panicTime];
        
    }
    
}

@end
