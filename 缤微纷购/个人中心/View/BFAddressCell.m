//
//  BFAddressCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAddressCell.h"

@interface BFAddressCell()

/**名字*/
@property (nonatomic, strong) UILabel *nameLabel;
/**地址类型*/
@property (nonatomic, strong) UILabel *categoryLabel;
/**省市区*/
@property (nonatomic, strong) UILabel *areaLabel;
/**详细地址*/
@property (nonatomic, strong) UILabel *detailAddressLabel;
/**电话号码*/
@property (nonatomic, strong) UILabel *phoneLabel;
/**编辑*/
@property (nonatomic, strong) UILabel *editLabel;
/**默认地址图片*/
@property (nonatomic, strong) UIImageView *defaultImageView;
/**分割线*/
@property (nonatomic, strong) UIView *line;

@end


@implementation BFAddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFAddressCell";
    BFAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFAddressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCell];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.line.frame = CGRectMake(0, BF_ScaleHeight(104.5), ScreenWidth, 0.5);
    
    self.selectButton.frame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(42.5), BF_ScaleWidth(20), BF_ScaleHeight(20));
    
    
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.selectButton.frame)+BF_ScaleWidth(8), BF_ScaleHeight(15), BF_ScaleWidth(80), BF_ScaleHeight(20)) ;
    
    self.categoryLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+BF_ScaleWidth(5), self.nameLabel.y, BF_ScaleWidth(50), self.nameLabel.height) ;
    
    self.areaLabel.frame = CGRectMake(self.nameLabel.x, CGRectGetMaxY(self.nameLabel.frame)+BF_ScaleHeight(15), BF_ScaleWidth(250), BF_ScaleHeight(12)) ;

    self.detailAddressLabel.frame = CGRectMake(self.nameLabel.x, CGRectGetMaxY(self.areaLabel.frame)+BF_ScaleHeight(4), BF_ScaleWidth(250), BF_ScaleHeight(12)) ;
    
    self.phoneLabel.frame = CGRectMake(self.nameLabel.x, CGRectGetMaxY(self.detailAddressLabel.frame)+BF_ScaleHeight(6), BF_ScaleWidth(200), BF_ScaleHeight(12)) ;
    
    self.editLabel.frame = CGRectMake(BF_ScaleWidth(265), 0, BF_ScaleWidth(30), BF_ScaleHeight(105)) ;
    
    self.defaultImageView.frame = CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(105));
}

- (void)setModel:(BFAddressModel *)model {
    _model = model;
    self.nameLabel.text = model.consignee;
    self.areaLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.sheng, model.shi, model.qu];
    self.detailAddressLabel.text = model.address;
    self.phoneLabel.text = model.mobile;
    if ([model.def isEqualToString:@"1"]) {
        self.defaultImageView.hidden = NO;
        self.selectButton.selected = YES;
    }else {
        self.defaultImageView.hidden = YES;
        self.selectButton.selected = NO;
    }
    if ([model.type isEqualToString:@"0"]) {
        self.categoryLabel.text = @"家";
    }else if ([model.type isEqualToString:@"1"]) {
        self.categoryLabel.text = @"公司";
    }else {
        self.categoryLabel.text = @"其他";
    }
}


- (void)setCell {
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = BFColor(0xDDDFDF);
    [self addSubview:self.line];
    
    self.selectButton = [UIButton buttonWithType:0];
    [self.selectButton setImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateSelected];
    [self.selectButton addTarget:self action:@selector(clickToChooseAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectButton];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = BFColor(0x000000);
    //self.nameLabel.backgroundColor = [UIColor redColor];
    self.nameLabel.text = @"叶文敏哈哈";
    self.nameLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    [self addSubview:self.nameLabel];
    
    self.categoryLabel = [[UILabel alloc] init];
    self.categoryLabel.textColor = BFColor(0x344BA3);
    self.categoryLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    self.categoryLabel.layer.borderColor = BFColor(0x344BA3).CGColor;
    self.categoryLabel.layer.borderWidth = 1;
    self.categoryLabel.layer.cornerRadius = BF_ScaleHeight(10);
    self.categoryLabel.text = @"公司";
    self.categoryLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.categoryLabel];
    
    self.areaLabel = [[UILabel alloc] init];
    self.areaLabel.textColor = BFColor(0x343537);
    //self.areaLabel.backgroundColor = [UIColor redColor];
    self.areaLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.areaLabel.text = @"广东省 广州市 天河区";
    [self addSubview:self.areaLabel];
    
    self.detailAddressLabel = [[UILabel alloc] init];
    self.detailAddressLabel.textColor = BFColor(0x343537);
    //self.detailAddressLabel.backgroundColor = [UIColor redColor];
    self.detailAddressLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.detailAddressLabel.text = @"华夏路30号富力盈通大厦3008";
    [self addSubview:self.detailAddressLabel];
    
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.textColor = BFColor(0x343537);
    //self.phoneLabel.backgroundColor = [UIColor redColor];
    self.phoneLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.phoneLabel.text = @"13986600772";
    [self addSubview:self.phoneLabel];
    
    self.editLabel = [[UILabel alloc] init];
    self.editLabel.textColor = BFColor(0xA8A9AB);
    //self.editLabel.backgroundColor = [UIColor redColor];
    self.editLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(10)];
    self.editLabel.text = @"编辑";
    self.editLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.editLabel];
    
    
    self.defaultImageView = [[UIImageView alloc] init];
    self.defaultImageView.image = [UIImage imageNamed:@"default"];
    self.defaultImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.defaultImageView.hidden = YES;
    [self addSubview:self.defaultImageView];
}

UIButton *_button = nil;
- (void)clickToChooseAddress:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender != _button) {
        _button.selected = NO;
    }
    
    _button = sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseToUseTheAddress:button:)]) {
        [self.delegate chooseToUseTheAddress:self button:sender];
    }
}


@end
