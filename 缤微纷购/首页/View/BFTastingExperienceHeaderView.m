//
//  BFTastingExperienceHeaderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFTastingExperienceHeaderView.h"

@interface BFTastingExperienceHeaderView()
/**轮播图*/
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
/**标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**现价*/
@property (nonatomic, strong) UILabel *productNewPrice;
/**原价*/
@property (nonatomic, strong) UILabel *productOriginPrice;
@end

@implementation BFTastingExperienceHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setModel:(BFTastingExperienceModel *)model {
    _model = model;
    if (model) {

        self.cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleWidth(320))];
        self.cycleScrollView.currentPageDotColor = BFColor(0xFF0000);
        self.cycleScrollView.pageDotColor = BFColor(0xffffff);
        self.cycleScrollView.pageControlDotSize = CGSizeMake(BF_ScaleHeight(8), BF_ScaleHeight(8));
        self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        NSArray *array = [BFTastingExperienceCarouselList parse:model.imgs];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (BFTastingExperienceCarouselList *list in array) {
            [mutableArray addObject:list.url];
        }
        self.cycleScrollView.imageURLStringsGroup = [mutableArray copy];
        [self addSubview:self.cycleScrollView];

        self.productTitle = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), CGRectGetMaxY(self.cycleScrollView.frame), BF_ScaleWidth(280), 0)];
        self.productTitle.numberOfLines = 0;
        self.productTitle.textColor = BFColor(0x020202);
        //self.productTitle.backgroundColor = BFColor(0x4da800);
        self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        self.productTitle.text = model.title;
        [self addSubview:self.productTitle];
        [self.productTitle sizeToFit];
        
        
        self.productNewPrice = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), BF_ScaleHeight(365), BF_ScaleWidth(200), BF_ScaleHeight(20))];
        self.productNewPrice.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(16)];
        self.productNewPrice.numberOfLines = 0;
        self.productNewPrice.textColor = BFColor(0xFD872A);
        self.productNewPrice.text = [NSString stringWithFormat:@"¥ %@", model.price];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.productNewPrice.text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(25)] range:NSMakeRange(2,self.productNewPrice.text.length-5)];
        self.productNewPrice.attributedText = attributedString;
        [self addSubview:self.productNewPrice];
        [self.productNewPrice sizeToFit];
        
        self.productOriginPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productNewPrice.frame)+BF_ScaleWidth(20), BF_ScaleHeight(373), BF_ScaleWidth(200), BF_ScaleHeight(10))];
        self.productOriginPrice.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
        self.productOriginPrice.numberOfLines = 0;
        self.productOriginPrice.textColor = BFColor(0xB3B3B3);
        self.productOriginPrice.text = [NSString stringWithFormat:@"¥%@", model.yprice];
        [self addSubview:self.productOriginPrice];
        [self.productOriginPrice sizeToFit];
        
        UIView *seperateLine = [UIView drawLineWithFrame:CGRectMake(self.productOriginPrice.x, self.productOriginPrice.y + self.productOriginPrice.height/2, self.productOriginPrice.width, 1)];
        seperateLine.backgroundColor = BFColor(0xB3B3B3);
        [self addSubview:seperateLine];

        
        
        UIView *line = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleHeight(395)-0.5, ScreenWidth, 0.5)];
        [self addSubview:line];
    }
}

@end
