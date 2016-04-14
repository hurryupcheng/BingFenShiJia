//
//  BFDailySpecialProductView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFDailySpecialProductView.h"

@interface BFDailySpecialProductView()
/**商品图片*/
@property (nonatomic, strong) UIImageView *productIcon;
/**商品标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**商品尺寸*/
@property (nonatomic, strong) UILabel *productSize;
/**商品新价格*/
@property (nonatomic, strong) UILabel *productNewPrice;
/**商品原价格*/
@property (nonatomic, strong) UILabel *productOriginPrice;
@end

@implementation BFDailySpecialProductView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xffffff);
    }
    return self;
}

- (void)setModel:(BFDailySpecialProductList *)model {
    _model = model;
    if (model) {
        self.productIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(8), BF_ScaleWidth(104), BF_ScaleHeight(104))];
        self.productIcon.layer.borderWidth = 0.5;
        self.productIcon.layer.borderColor = BFColor(0xF2F4F5).CGColor;
        self.productIcon.layer.cornerRadius = 3;
        [self.productIcon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self addSubview:self.productIcon];
        
        self.productTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame) + BF_ScaleWidth(8), BF_ScaleHeight(10), BF_ScaleWidth(192), 0)];
        //self.productTitle.backgroundColor = [UIColor redColor];
        self.productTitle.numberOfLines = 0;
        self.productTitle.textColor = BFColor(0x202021);
        self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
        self.productTitle.text = model.title;
        [self addSubview:self.productTitle];
        [self.productTitle sizeToFit];
        
        self.productSize = [[UILabel alloc] initWithFrame:CGRectMake(self.productTitle.x, CGRectGetMaxY(self.productTitle.frame) + BF_ScaleHeight(4), BF_ScaleWidth(192), BF_ScaleHeight(13))];
        //self.productSize.backgroundColor = [UIColor greenColor];
        self.productSize.textColor = BFColor(0x868788);
        self.productSize.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        self.productSize.text = model.size;
        [self addSubview:self.productSize];
        
        
        self.productNewPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame) + BF_ScaleWidth(10), BF_ScaleHeight(90), BF_ScaleWidth(200), BF_ScaleHeight(20))];
        self.productNewPrice.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(14)];
        self.productNewPrice.numberOfLines = 0;
        self.productNewPrice.textColor = BFColor(0xFD872A);
        self.productNewPrice.text = [NSString stringWithFormat:@"¥ %@", model.price];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.productNewPrice.text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(20)] range:NSMakeRange(2,self.productNewPrice.text.length-5)];
        self.productNewPrice.attributedText = attributedString;
        [self addSubview:self.productNewPrice];
        [self.productNewPrice sizeToFit];
        
        self.productOriginPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productNewPrice.frame)+BF_ScaleWidth(20), BF_ScaleHeight(95), BF_ScaleWidth(200), BF_ScaleHeight(10))];
        self.productOriginPrice.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
        self.productOriginPrice.numberOfLines = 0;
        self.productOriginPrice.textColor = BFColor(0xB3B3B3);
        self.productOriginPrice.text = [NSString stringWithFormat:@"¥%@", model.yprice];
        [self addSubview:self.productOriginPrice];
        [self.productOriginPrice sizeToFit];
        
        UIView *seperateLine = [UIView drawLineWithFrame:CGRectMake(self.productOriginPrice.x, self.productOriginPrice.y + self.productOriginPrice.height/2, self.productOriginPrice.width, 1)];
        seperateLine.backgroundColor = BFColor(0xB3B3B3);
        [self addSubview:seperateLine];
        
        self.shoppingCart = [[UIButton alloc] initWithFrame:CGRectMake(BF_ScaleWidth(287), BF_ScaleHeight(90), BF_ScaleWidth(25), BF_ScaleHeight(20))];
        //shoppingCart.backgroundColor = [UIColor blueColor];
        [self.shoppingCart setImage:[UIImage imageNamed:@"gouwuche_tejia"] forState:UIControlStateNormal];
        [self.shoppingCart addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.shoppingCart];
        
        
    }
}

- (void)add:(UIButton *)sender {
    
    [BFNotificationCenter postNotificationName:@"BFDailySpecialProductView" object:self userInfo:@{@"tag" : @(sender.tag)} ];
}

@end
