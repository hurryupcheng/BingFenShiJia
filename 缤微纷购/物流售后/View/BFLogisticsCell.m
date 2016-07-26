//
//  BFLogisticsCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFLogisticsCell.h"
#import "BFProductInfoView.h"

@interface BFLogisticsCell()
/**商品图片*/
@property (nonatomic, strong) UIImageView *productIcon;
/**商品标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**商品尺寸*/
@property (nonatomic, strong) UILabel *productSize;
/**商品颜色*/
@property (nonatomic, strong) UILabel *productColor;
/***/
//@property (nonatomic, strong) BFProductInfoView *productView;


@end

@implementation BFLogisticsCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFLogisticsCell";
    BFLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFLogisticsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)setModel:(BFProductModel *)model {
    _model = model;
    //BFLog(@"++++%@",model.OrderID);
    [self.productIcon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
    self.productTitle.frame = CGRectMake(CGRectGetMaxX(self.productIcon.frame)+BF_ScaleWidth(12.5), self.productIcon.y+BF_ScaleHeight(8), BF_ScaleWidth(170), 0);
    self.productTitle.text = model.title;
    [self.productTitle sizeToFit];
   // BFLog(@"self.productTitle%f",self.productTitle.height);
    self.productSize.frame = CGRectMake(self.productTitle.x, CGRectGetMaxY(self.productTitle.frame)+BF_ScaleHeight(8), BF_ScaleWidth(200), BF_ScaleHeight(12));
    
    if (model.size.length != 0 && model.color.length != 0) {
        self.productSize.text = [NSString stringWithFormat:@"%@/%@", model.size, model.color];
    }else if (model.size.length == 0 && model.color.length != 0){
        self.productSize.text = [NSString stringWithFormat:@"%@", model.color];
    }else if (model.size.length != 0 && model.color.length == 0){
        self.productSize.text = [NSString stringWithFormat:@"%@", model.size];
    }else {
        self.productSize.text = @"";
    }
    
    
//    self.productColor.frame = CGRectMake(CGRectGetMaxX(self.productSize.frame), self.productSize.y, BF_ScaleWidth(160), self.productSize.height);
//    self.productColor.text = model.color;
    
}


- (void)setCell {
    
    UIView *line = [self setUpLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [self addSubview:line];
    
    self.productIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(12.5), BF_ScaleHeight(12.5), BF_ScaleWidth(70), BF_ScaleHeight(70))];
    self.productIcon.image = [UIImage imageNamed:@"100.jpg"];
    self.productIcon.layer.borderWidth = 1;
    self.productIcon.layer.borderColor = BFColor(0xBDBEC0).CGColor;
    self.productIcon.layer.cornerRadius = 10;
    self.productIcon.layer.masksToBounds = YES;
    [self addSubview:self.productIcon];
    
    self.productTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame)+BF_ScaleWidth(12.5), self.productIcon.y+BF_ScaleHeight(8), BF_ScaleWidth(170), 0)];
    self.productTitle.text = @"云南冰糖橙-明星为你甜蜜助跑响起扑鼻 细嫩多汁";
    self.productTitle.numberOfLines = 2;
    //self.productTitle.backgroundColor = [UIColor redColor];
    self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    [self addSubview:self.productTitle];
    
    
    
    self.productSize = [[UILabel alloc] init];
    self.productSize.textColor = BFColor(0x9A9B9C);
    self.productSize.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    self.productSize.text = @"5斤装";
    [self addSubview:self.productSize];
    
//    self.productColor = [[UILabel alloc] init];
//    self.productColor.textColor = BFColor(0x9A9B9C);
//    self.productColor.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
//    self.productColor.text = @"红色";
//    [self addSubview:self.productColor];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(300), 0, BF_ScaleWidth(10), BF_ScaleHeight(95))];
    arrowImageView.image = [UIImage imageNamed:@"select_right"];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:arrowImageView];
    
    
    
}

- (UIView *)setUpLineWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = BFColor(0xBDBEC0);
    return line;
}


@end
