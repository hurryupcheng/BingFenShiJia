//
//  BFProductDetailCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFProductDetailCell.h"

@interface BFProductDetailCell()

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
        self.backgroundColor = BFColor(0xffffff);
        [self setCell];
    }
    return self;
}

- (void)setModel:(BFOrderProductModel *)model {
    _model = model;
    
    [self.productIcon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
    
    
    self.productTitle.frame = CGRectMake(CGRectGetMaxX(self.productIcon.frame)+BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(180), 0);
    self.productTitle.text = model.title;
    [self.productTitle sizeToFit];
    
    self.productSize.frame = CGRectMake(self.productTitle.x, CGRectGetMaxY(self.productTitle.frame)+BF_ScaleHeight(10), BF_ScaleWidth(100), 0);
    self.productSize.text = model.size;
    [self.productSize sizeToFit];
    
    self.productPrice.text = [NSString stringWithFormat:@"¥ %@", model.price];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.productPrice.text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(20)] range:NSMakeRange(2,model.price.length-3)];
    self.productPrice.attributedText = attributedString;
    
    self.productCount.text = [NSString stringWithFormat:@"x %@", model.quantity];
    
}


- (void)setCell {
    
    self.productIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(15), BF_ScaleHeight(5), BF_ScaleHeight(90), BF_ScaleWidth(90))];
    self.productIcon.image = [UIImage imageNamed:@"100.jpg"];
    self.productIcon.layer.cornerRadius = 5;
    self.productIcon.layer.masksToBounds = YES;
    //self.productIcon.backgroundColor = [UIColor redColor];
    [self addSubview:self.productIcon];
    
    self.productTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame)+BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(180), 0)];
    self.productTitle.text = @"6252份包邮开口黑金刚南瓜子熟黑南瓜子竹炭色坚果炒货零食小吃250g";
    self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(10)];
    //self.productTitle.backgroundColor = [UIColor redColor];
    self.productTitle.textColor = BFColor(0x5B5B5B);
    self.productTitle.numberOfLines = 0;
    [self addSubview:self.productTitle];
    
    
    self.productSize = [[UILabel alloc] initWithFrame:CGRectMake(self.productTitle.x, CGRectGetMaxY(self.productTitle.frame)+BF_ScaleHeight(10), BF_ScaleWidth(100), BF_ScaleHeight(15))];
    self.productSize.text = @"1斤/盒";
    self.productSize.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    self.productSize.textColor = BFColor(0x9B9B9B);
    [self addSubview:self.productSize];

    
    self.productCount = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(240), 0, BF_ScaleWidth(60), BF_ScaleHeight(100))];
    self.productCount.text = @"x 1";
    self.productCount.textAlignment = NSTextAlignmentRight;
    self.productCount.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    self.productCount.textColor = BFColor(0x9B9B9B);
    [self addSubview:self.productCount];
    
    self.productPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.productTitle.x, BF_ScaleHeight(75), BF_ScaleWidth(100), BF_ScaleHeight(16))];
    self.productPrice.text = @"¥ 69.00";
    self.productPrice.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    self.productPrice.textColor = BFColor(0xFD8627);
    [self addSubview:self.productPrice];
    
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(300), 0, BF_ScaleWidth(10), BF_ScaleHeight(100))];
    arrowImageView.image = [UIImage imageNamed:@"select_right"];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:arrowImageView];
    
}

- (UILabel *)setUpLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    //label.backgroundColor = [UIColor redColor];
    label.textColor = BFColor(0x5B5B5B);

    return label;
}

- (void)label:(UILabel *)label {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xFB0049) range:NSMakeRange(3,label.text.length-3)];
    label.attributedText = attributedString;
}
@end
