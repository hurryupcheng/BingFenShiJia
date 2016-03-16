//
//  BFProductInfoView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFProductInfoView.h"

@interface BFProductInfoView()
/**配送方式底部view*/
@property (nonatomic, strong) UIView *bottomView;
/**配送方式*/
@property (nonatomic, strong) UILabel *deliverieLabel;
/**总价*/
@property (nonatomic, strong) UILabel *totalPriceLabel;

@end

@implementation BFProductInfoView

+ (instancetype)productView {
    BFProductInfoView *view = [[BFProductInfoView alloc] init];
    return view;
}

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(130), BF_ScaleWidth(300), BF_ScaleHeight(150));
        self.backgroundColor = BFColor(0xFFFFFF);
        self.layer.borderWidth = 1;
        self.layer.borderColor = BFColor(0xE6E6E6).CGColor;
        [self setView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.productIcon.frame = CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(10), BF_ScaleWidth(30), BF_ScaleHeight(30));
    
    self.productTitle.frame = CGRectMake(CGRectGetMaxX(self.productIcon.frame)+BF_ScaleWidth(8), self.productIcon.x, BF_ScaleWidth(224), BF_ScaleHeight(35));
    
    self.productColor.frame = CGRectMake(self.productTitle.x, CGRectGetMaxY(self.productIcon.frame)+BF_ScaleHeight(6), BF_ScaleWidth(50), BF_ScaleHeight(11));
    
    self.productSize.frame = CGRectMake(CGRectGetMaxX(self.productColor.frame)+BF_ScaleWidth(8), self.productColor.y, BF_ScaleWidth(100), self.productColor.height);
    
    self.productCount.frame = CGRectMake(self.productColor.x, CGRectGetMaxY(self.productColor.frame)+BF_ScaleHeight(8), self.productColor.width, self.productColor.height);
    
    self.productPrice.frame = CGRectMake(CGRectGetMaxX(self.productCount.frame)+BF_ScaleWidth(8), self.productCount.y, self.productSize.width, self.productColor.height);
    
    self.bottomView.frame = CGRectMake(BF_ScaleWidth(20), CGRectGetMaxY(self.productPrice.frame)+BF_ScaleHeight(10), BF_ScaleWidth(260), BF_ScaleHeight(50));

    self.productDeliveries.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(260), BF_ScaleHeight(12));
    
    self.productTotalPrice.frame = CGRectMake(self.productDeliveries.x, CGRectGetMaxY(self.productDeliveries.frame)+BF_ScaleHeight(8), BF_ScaleWidth(260), BF_ScaleHeight(10));

}

- (void)setView {
    self.productIcon = [[UIImageView alloc] init];
    self.productIcon.image = [UIImage imageNamed:@"goodsImage"];
    self.productIcon.backgroundColor = [UIColor redColor];
    [self addSubview:self.productIcon];
    
    self.productTitle = [[UILabel alloc] init];
    self.productTitle.text = @"6252份包邮开口黑金刚南瓜子熟黑南瓜子竹炭色坚果炒货零食小吃250g";
    self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    //self.productTitle.backgroundColor = [UIColor redColor];
    self.productTitle.textColor = BFColor(0x5B5B5B);
    self.productTitle.numberOfLines = 0;
    [self addSubview:self.productTitle];
    [self.productTitle sizeToFit];
    NSMutableAttributedString *detailAttributedString = [[NSMutableAttributedString alloc] initWithString:self.productTitle.text];
    NSMutableParagraphStyle *detailParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [detailParagraphStyle setLineSpacing:4];//调整行间距
    [detailAttributedString addAttribute:NSParagraphStyleAttributeName value:detailParagraphStyle range:NSMakeRange(0, [self.productTitle.text length])];
    self.productTitle.attributedText = detailAttributedString;
    
    self.productColor = [self setUpLabelWithText:@"颜色:红"];
    [self addSubview:self.productColor];
 
    self.productSize = [self setUpLabelWithText:@"尺寸:10kg"];
    [self addSubview:self.productSize];
    
    self.productCount = [self setUpLabelWithText:@"数量:3"];
    [self addSubview:self.productCount];
    
    self.productPrice = [self setUpLabelWithText:@"价格:¥50.00"];
    [self addSubview:self.productPrice];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.layer.borderWidth = 1;
    self.bottomView.layer.borderColor = BFColor(0xE6E6E6).CGColor;
    [self addSubview:self.bottomView];
    
    self.productDeliveries = [self setUpLabelWithText:@"配送方式：卖家包邮"];
    [self.bottomView addSubview:self.productDeliveries];
    
    self.productTotalPrice = [self setUpLabelWithText:@"总价:¥150.00"];
    [self.bottomView addSubview:self.productTotalPrice];
}


- (UILabel *)setUpLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    //label.backgroundColor = [UIColor redColor];
    label.textColor = BFColor(0x5B5B5B);
    [label sizeToFit];
    return label;
}

@end
