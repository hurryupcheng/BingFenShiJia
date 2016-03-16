//
//  BFProductDetailCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFProductDetailCell.h"

@interface BFProductDetailCell()
/**底部view*/
@property (nonatomic, strong) UIView *bottomView;
/**商品图片*/
@property (nonatomic, strong) UIImageView *productIcon;
/**商品标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**商品颜色*/
@property (nonatomic, strong) UILabel *productColor;
/**商品尺寸*/
@property (nonatomic, strong) UILabel *productSize;
/**商品数量*/
@property (nonatomic, strong) UILabel *productCount;
/**商品价格*/
@property (nonatomic, strong) UILabel *productPrice;

@end

@implementation BFProductDetailCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFProductDetailCell";
    BFProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFProductDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xF4F4F4);
        //[self setCell];
    }
    return self;
}

- (void)setModel:(BFOrderProductModel *)model {
    _model = model;
    [self.productIcon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"olaceholder"]];
    self.productTitle.text = model.title;
    [self.productTitle sizeToFit];
    NSMutableAttributedString *detailAttributedString = [[NSMutableAttributedString alloc] initWithString:self.productTitle.text];
    NSMutableParagraphStyle *detailParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [detailParagraphStyle setLineSpacing:4];//调整行间距
    [detailAttributedString addAttribute:NSParagraphStyleAttributeName value:detailParagraphStyle range:NSMakeRange(0, [self.productTitle.text length])];
    self.productTitle.attributedText = detailAttributedString;
    
    
    self.productColor.frame = CGRectMake(self.productTitle.x, CGRectGetMaxY(self.productIcon.frame)+BF_ScaleHeight(6), BF_ScaleWidth(50), BF_ScaleHeight(11));
    self.productColor.text = [NSString stringWithFormat:@"颜色:%@",model.color];
    [self label:self.productColor];
    
    self.productSize.frame = CGRectMake(CGRectGetMaxX(self.productColor.frame)+BF_ScaleWidth(8), self.productColor.y, BF_ScaleWidth(100), self.productColor.height);
    self.productSize.text = [NSString stringWithFormat:@"尺寸:%@",model.size];
    [self label:self.productSize];
    
    self.productCount.frame = CGRectMake(self.productColor.x, CGRectGetMaxY(self.productColor.frame)+BF_ScaleHeight(8), self.productColor.width, self.productColor.height);
    self.productCount.text = [NSString stringWithFormat:@"数量:%@",model.quantity];
    [self label:self.productCount];
    
    self.productPrice.frame = CGRectMake(CGRectGetMaxX(self.productCount.frame)+BF_ScaleWidth(8), self.productCount.y, self.productSize.width, self.productColor.height);
    self.productPrice.text = [NSString stringWithFormat:@"颜色:%@",model.price];
    [self label:self.productPrice];
    
    
    self.productDetailH = CGRectGetMaxY(self.productPrice.frame) + BF_ScaleHeight(10);
    self.bottomView.frame = CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(300), self.productDetailH);
    BFLog(@"%f,,%f",self.productDetailH,CGRectGetMaxY(self.productPrice.frame));
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.productIcon.frame = CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(10), BF_ScaleWidth(30), BF_ScaleHeight(30));
    
    self.productTitle.frame = CGRectMake(CGRectGetMaxX(self.productIcon.frame)+BF_ScaleWidth(8), self.productIcon.x, BF_ScaleWidth(224), BF_ScaleHeight(35));
    
    self.productColor.frame = CGRectMake(self.productTitle.x, CGRectGetMaxY(self.productIcon.frame)+BF_ScaleHeight(6), BF_ScaleWidth(50), BF_ScaleHeight(11));
    
    self.productSize.frame = CGRectMake(CGRectGetMaxX(self.productColor.frame)+BF_ScaleWidth(8), self.productColor.y, BF_ScaleWidth(100), self.productColor.height);
    
    self.productCount.frame = CGRectMake(self.productColor.x, CGRectGetMaxY(self.productColor.frame)+BF_ScaleHeight(8), self.productColor.width, self.productColor.height);
    
    self.productPrice.frame = CGRectMake(CGRectGetMaxX(self.productCount.frame)+BF_ScaleWidth(8), self.productCount.y, self.productSize.width, self.productColor.height);
}

- (void)setCell {
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:self.bottomView];
    
    self.productIcon = [[UIImageView alloc] init];
    self.productIcon.image = [UIImage imageNamed:@"goodsImage"];
    self.productIcon.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:self.productIcon];
    
    self.productTitle = [[UILabel alloc] init];
    self.productTitle.text = @"6252份包邮开口黑金刚南瓜子熟黑南瓜子竹炭色坚果炒货零食小吃250g";
    self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    //self.productTitle.backgroundColor = [UIColor redColor];
    self.productTitle.textColor = BFColor(0x5B5B5B);
    self.productTitle.numberOfLines = 0;
    [self.bottomView addSubview:self.productTitle];
    //[self.productTitle sizeToFit];
    
    
    self.productColor = [self setUpLabelWithText:@"颜色:红"];
    [self.bottomView addSubview:self.productColor];
    
    self.productSize = [self setUpLabelWithText:@"尺寸:10kg"];
    [self.bottomView addSubview:self.productSize];
    
    self.productCount = [self setUpLabelWithText:@"数量:3"];
    [self.bottomView addSubview:self.productCount];
    
    self.productPrice = [self setUpLabelWithText:@"价格:¥50.00"];
    [self.bottomView addSubview:self.productPrice];
    
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

- (void)label:(UILabel *)label {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xFB0049) range:NSMakeRange(3,label.text.length-3)];
    label.attributedText = attributedString;
}
@end
