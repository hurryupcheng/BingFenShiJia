//
//  BFOrderDetailAddressCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFOrderDetailAddressCell.h"

@interface BFOrderDetailAddressCell()
/**背景图*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**地址*/
@property (nonatomic, strong) UILabel *addressLabel;
/**电话，姓名*/
@property (nonatomic, strong) UILabel *nameAndPhoneNumberLabel;


@end


@implementation BFOrderDetailAddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFOrderDetailAddressCell";
    BFOrderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFOrderDetailAddressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCell];
    }
    return self;
}

- (void)setCell {
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(110))];
    self.bgImageView.image = [UIImage imageNamed:@"adds"];
    [self addSubview:self.bgImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(15), BF_ScaleHeight(10), BF_ScaleWidth(100), 0)];
    titleLabel.text = @"收货地址";
    titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    [self.bgImageView addSubview:titleLabel];
    [titleLabel sizeToFit];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), CGRectGetMaxY(titleLabel.frame)+BF_ScaleHeight(10), BF_ScaleWidth(285), 0)];
    self.addressLabel.text = @"广东省广州市天河区华夏路30号富力盈通大厦3008";
    self.addressLabel.textAlignment = NSTextAlignmentRight;
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    [self.bgImageView addSubview:self.addressLabel];
    [self.addressLabel sizeToFit];
    
    
    self.nameAndPhoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), BF_ScaleHeight(80), BF_ScaleWidth(285), BF_ScaleHeight(14))];
    self.nameAndPhoneNumberLabel.text = @"程召华，13986600772";
    self.nameAndPhoneNumberLabel.textAlignment = NSTextAlignmentRight;
    self.nameAndPhoneNumberLabel.numberOfLines = 1;
    self.nameAndPhoneNumberLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    [self.bgImageView addSubview:self.nameAndPhoneNumberLabel];
   
    
}

@end
