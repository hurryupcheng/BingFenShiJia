//
//  BFProductDetailHeaderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFProductDetailHeaderView.h"


@interface BFProductDetailHeaderView()
/**轮播图*/
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
/**规格尺寸*/
@property (nonatomic, strong) UILabel *size;
/**特别说明*/
@property (nonatomic, strong) UILabel *specialInstruction;
@end

@implementation BFProductDetailHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setModel:(BFProductDetialModel *)model{
    _model = model;
    if (model) {
        self.cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleWidth(320))];
        self.cycleScrollView.currentPageDotColor = BFColor(0xFF0000);
        self.cycleScrollView.pageDotColor = BFColor(0xffffff);
        self.cycleScrollView.pageControlDotSize = CGSizeMake(BF_ScaleHeight(8), BF_ScaleHeight(8));
        self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        NSArray *array = [BFProductDetailCarouselList parse:model.imgs];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (BFProductDetailCarouselList *list in array) {
            [mutableArray addObject:list.url];
        }
        self.cycleScrollView.imageURLStringsGroup = [mutableArray copy];
        [self addSubview:self.cycleScrollView];


        
        self.stockView = [[BFProductStockView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame), ScreenWidth, BF_ScaleHeight(70))];
        self.stockView.model = model;
        [self addSubview:self.stockView];
        
        UIView *sizeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stockView.frame), ScreenWidth, BF_ScaleHeight(40))];
        [self addSubview:sizeView];
        
        UILabel *sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), 0, BF_ScaleWidth(100), BF_ScaleWidth(40))];
        sizeLabel.text = @"规格";
        sizeLabel.textColor = BFColor(0x000000);
        sizeLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        [sizeView addSubview:sizeLabel];
        
        self.size = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(110), 0, BF_ScaleWidth(200), BF_ScaleWidth(40))];
        self.size.textAlignment = NSTextAlignmentRight;
        self.size.textColor = BFColor(0x8E8E8E);
        self.size.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        self.size.text = [NSString stringWithFormat:@"%@/%@",model.first_size, model.first_color];
        [sizeView addSubview:self.size];
        
        UIView *firstLine = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleWidth(40)-0.5, ScreenWidth, 0.5)];
        firstLine.backgroundColor = BFColor(0xBABABA);
        [sizeView addSubview:firstLine];
        
        
        UILabel *instructionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), CGRectGetMaxY(sizeView.frame) + BF_ScaleHeight(10), BF_ScaleWidth(100), BF_ScaleHeight(12))];
        instructionsLabel.text = @"特别说明";
        instructionsLabel.textColor = BFColor(0x000000);
        instructionsLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        [self addSubview:instructionsLabel];
        
        self.specialInstruction = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), CGRectGetMaxY(instructionsLabel.frame) + BF_ScaleHeight(6), BF_ScaleWidth(260), 0)];
        self.specialInstruction.numberOfLines = 0;
        self.specialInstruction.text = model.intro;
        self.specialInstruction.textColor = BFColor(0x8E8E8E);
        self.specialInstruction.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.specialInstruction.text];
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineSpacing:5];//调整行间距
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.specialInstruction.text length])];
//        self.specialInstruction.attributedText = attributedString;

        [self addSubview:self.specialInstruction];
        [self.specialInstruction sizeToFit];
        
        
        UIView *secondLine = [UIView drawLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.specialInstruction.frame) + BF_ScaleHeight(10), ScreenWidth, 0.5)];
        secondLine.backgroundColor = BFColor(0xBABABA);
        [self addSubview:secondLine];
        
        self.headerHeight = CGRectGetMaxY(secondLine.frame);
    }
}

- (void)setView {
    
}
@end
