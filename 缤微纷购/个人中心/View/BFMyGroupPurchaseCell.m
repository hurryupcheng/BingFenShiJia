//
//  BFMyGroupPurchaseCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyGroupPurchaseCell.h"
#import "BFGoGroupShoppingView.h"

@interface BFMyGroupPurchaseCell()
//**背景图*/
@property (nonatomic, strong) UIView *backgroudView;
/**商品图片*/
@property (nonatomic, strong) UIImageView *productImageView;
/**商品标题*/
@property (nonatomic, strong) UILabel *titleLabel;
/**分割线数组*/
@property (nonatomic, strong) UIView *line;
/**团购成功*/
@property (nonatomic, strong) UILabel *sucessLabel;
/**自定义去拼团view*/
@property (nonatomic, strong) BFGoGroupShoppingView *goView;
/**查看团详情*/
@property (nonatomic, strong) UIButton *checkGroupDetail;
/**查看订单详情*/
@property (nonatomic, strong) UIButton *checkOrderDetail;
@end


@implementation BFMyGroupPurchaseCell



+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"MyGroupPurchaseCell";
    BFMyGroupPurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFMyGroupPurchaseCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xF4F4F4);
        //分割线
 
        
        self.backgroudView = [UIView new];
        self.backgroudView.backgroundColor = BFColor(0xffffff);
        [self addSubview:self.backgroudView];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = BFColor(0x939393);
        [self.backgroudView addSubview:self.line];
        
        self.productImageView = [[UIImageView alloc] init];
        self.productImageView.image = [UIImage imageNamed:@"goodsImage"];
        self.productImageView.layer.borderWidth = 1;
        self.productImageView.layer.backgroundColor = BFColor(0x858585).CGColor;
        [self.backgroudView addSubview:self.productImageView];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
        self.titleLabel.textColor = BFColor(0x999999);
        self.titleLabel.text = @"【拼团守法 限量抢购】四川安岳柠檬12个装15.9元哈哈哈哈哈哈";
        [self.backgroudView addSubview:self.titleLabel];
        
        self.goView = [[BFGoGroupShoppingView alloc] init];
        [self.backgroudView addSubview:self.goView];
        
        
        self.sucessLabel = [UILabel new];
        self.sucessLabel.text = @"团购成功";
        self.sucessLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        self.sucessLabel.textColor = BFColor(0xe02a2f);
        [self.backgroudView addSubview:self.sucessLabel];
        
        self.checkGroupDetail = [self setUpButtonWithTitle:@"查看团详情" type:MyGroupPurchaseCellCheckButtonTypeGroup];
        
        self.checkOrderDetail = [self setUpButtonWithTitle:@"查看订单详情" type:MyGroupPurchaseCellCheckButtonTypeOrder];
        

    }
    return self;
}




- (void)layoutSubviews {
    [super layoutSubviews];
    self.line.frame = CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(80), BF_ScaleWidth(304), 1);
    
    self.backgroudView.frame = CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(125));
    
    self.productImageView.frame = CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(14), BF_ScaleWidth(55), BF_ScaleHeight(55));
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.productImageView.frame)+BF_ScaleWidth(13), self.productImageView.y, BF_ScaleWidth(244), BF_ScaleHeight(20));
    
    self.goView.frame = CGRectMake(self.titleLabel.x, CGRectGetMaxY(self.productImageView.frame)-BF_ScaleHeight(23), BF_ScaleWidth(130), BF_ScaleHeight(23));
    
    self.sucessLabel.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.line.frame)+BF_ScaleHeight(15), BF_ScaleWidth(100), BF_ScaleHeight(12));
    
    self.checkGroupDetail.frame = CGRectMake(BF_ScaleWidth(154), CGRectGetMaxY(self.line.frame)+BF_ScaleHeight(7), BF_ScaleWidth(70), BF_ScaleHeight(24));
    
    self.checkOrderDetail.frame = CGRectMake(CGRectGetMaxX(self.checkGroupDetail.frame)+BF_ScaleWidth(8), self.checkGroupDetail.y, BF_ScaleWidth(80), self.checkGroupDetail.height);
}




- (UIButton *)setUpButtonWithTitle:(NSString *)title type:(MyGroupPurchaseCellCheckButtonType)type {
    UIButton *button = [UIButton buttonWithType:0];
    button.tag = type;
    button.layer.borderWidth = 1;
    button.layer.borderColor = BFColor(0x808080).CGColor;
    [button setTitleColor:BFColor(0x808080) forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    [button addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroudView addSubview:button];
    
    return button;
}

- (void)checkButtonClick {
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
