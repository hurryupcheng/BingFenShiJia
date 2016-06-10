//
//  BFPTHomeHeaderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPTHomeHeaderView.h"

@interface BFPTHomeHeaderView()
/**轮播图*/
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation BFPTHomeHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(150)) delegate:nil placeholderImage:nil];
    self.cycleScrollView.currentPageDotColor = BFColor(0xFF0000);
    self.cycleScrollView.pageDotColor = BFColor(0xffffff);
    self.cycleScrollView.pageControlDotSize = CGSizeMake(BF_ScaleHeight(8), BF_ScaleHeight(8));
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    [self addSubview:self.cycleScrollView];
}

- (void)setModel:(BFPTHomeModel *)model {
    _model = model;
    if (model) {
        if ([model.ads isKindOfClass:[NSArray class]]) {

            NSArray *array = [BFPTBannerList parse:model.ads];
            if (array.count == 0) {
                self.cycleScrollView.hidden = YES;
                self.headViewH = BF_ScaleHeight(10);
            }else {
                NSMutableArray *mutableArray = [NSMutableArray array];
                for (BFPTBannerList *bannerList in array) {
                    [mutableArray addObject:bannerList.content];
                }
                self.cycleScrollView.imageURLStringsGroup = [mutableArray copy];
                self.cycleScrollView.hidden = NO;
                self.headViewH = BF_ScaleHeight(150)+BF_ScaleHeight(10);
            }
            
        }else {
            self.cycleScrollView.hidden = YES;
            self.headViewH = BF_ScaleHeight(10);
        }
        
    }
}

@end
