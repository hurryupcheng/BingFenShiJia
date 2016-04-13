//
//  BFPanicBuyingDetailView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPanicBuyingDetailView.h"
#import "BFPanicCountView.h"

@interface BFPanicBuyingDetailView()
/**标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**现价格*/
@property (nonatomic, strong) UILabel *productNewPrice;
/**原价格*/
@property (nonatomic, strong) UILabel *productOriginPrice;
/**尺寸*/
@property (nonatomic, strong) UILabel *productSize;
/**加减按钮*/
@property (nonatomic, strong) BFPanicCountView *countView;


@end

@implementation BFPanicBuyingDetailView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setModel:(BFPanicBuyingModel *)model {
    _model = model;
    if (model) {
        self.productTitle = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(5), BF_ScaleWidth(200), BF_ScaleHeight(35))];
        self.productTitle.text = model.title;
        //self.productTitle.backgroundColor = [UIColor blueColor];
        self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        self.productTitle.textColor = BFColor(0x050505);
        self.productTitle.numberOfLines = 2;
        [self addSubview:self.productTitle];
        
        self.productNewPrice = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(42), BF_ScaleWidth(200), BF_ScaleHeight(20))];
        self.productNewPrice.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(16)];
        self.productNewPrice.numberOfLines = 0;
        self.productNewPrice.textColor = BFColor(0xFD872A);
        self.productNewPrice.text = [NSString stringWithFormat:@"¥ %@", model.price];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.productNewPrice.text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(25)] range:NSMakeRange(2,self.productNewPrice.text.length-5)];
        self.productNewPrice.attributedText = attributedString;
        [self addSubview:self.productNewPrice];
        [self.productNewPrice sizeToFit];
        
        self.productOriginPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productNewPrice.frame)+BF_ScaleWidth(20), BF_ScaleHeight(50), BF_ScaleWidth(200), BF_ScaleHeight(10))];
        self.productOriginPrice.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
        self.productOriginPrice.numberOfLines = 0;
        self.productOriginPrice.textColor = BFColor(0xB3B3B3);
        self.productOriginPrice.text = [NSString stringWithFormat:@"¥%@", model.yprice];
        [self addSubview:self.productOriginPrice];
        [self.productOriginPrice sizeToFit];
        
        UIView *seperateLine = [UIView drawLineWithFrame:CGRectMake(self.productOriginPrice.x, self.productOriginPrice.y + self.productOriginPrice.height/2, self.productOriginPrice.width, 1)];
        seperateLine.backgroundColor = BFColor(0xB3B3B3);
        [self addSubview:seperateLine];
        
        
        self.productSize = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(220), BF_ScaleHeight(10), BF_ScaleWidth(90), BF_ScaleHeight(11))];
        self.productSize.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        self.productSize.textColor = BFColor(0xB3B3B3);
        self.productSize.textAlignment = NSTextAlignmentRight;
        self.productSize.text = model.first_size;
        [self addSubview:self.productSize];
        
        
        
        self.countView = [[BFPanicCountView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(220), BF_ScaleHeight(40), BF_ScaleWidth(90), BF_ScaleHeight(30))];
        self.countView.model = model;
        [self addSubview:self.countView];
        
        
        
        UIView *line = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleHeight(77)-0.5, ScreenWidth, 0.5)];
        line.backgroundColor = BFColor(0xBABABA);
        [self addSubview:line];


    }
}

@end
