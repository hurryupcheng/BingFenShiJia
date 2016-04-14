//
//  BFDailySpecialHeaderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFDailySpecialHeaderView.h"
#import "SDCycleScrollView.h"

@interface BFDailySpecialHeaderView()
/**轮播图*/
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation BFDailySpecialHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setModel:(BFDailySpecialModel *)model {
    _model = model;
    
    if (model) {
        self.cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(200))];;
        self.cycleScrollView.currentPageDotColor = BFColor(0xFF0000);
        self.cycleScrollView.pageDotColor = BFColor(0xffffff);
        self.cycleScrollView.pageControlDotSize = CGSizeMake(BF_ScaleHeight(8), BF_ScaleHeight(8));
        self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        NSArray *array = [BFDailySpecialBannerList parse:model.ads];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (BFDailySpecialBannerList *list in array) {
            [mutableArray addObject:list.content];
        }
        self.cycleScrollView.imageURLStringsGroup = [mutableArray copy];
        [self addSubview:self.cycleScrollView];
 
    }
}

@end
