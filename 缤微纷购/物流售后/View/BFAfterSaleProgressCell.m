//
//  BFAfterSaleProgressCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define Height  BF_ScaleHeight(25)

#import "BFAfterSaleProgressCell.h"
#import "BFAfterSaleProductView.h"
@interface BFAfterSaleProgressCell()
/**订单编号*/
@property (nonatomic, strong) UILabel *orderID;
/**下单时间*/
@property (nonatomic, strong) UILabel *addOrderTime;
/**订单状态*/
@property (nonatomic, strong) UILabel *productTotalPrice;
/**产品信息*/
@property (nonatomic, strong) BFAfterSaleProductView *productView;
/**申请售后时间*/
@property (nonatomic, strong) UILabel *applySaleTime;
/**状态*/
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation BFAfterSaleProgressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFAfterSaleProgressCell";
    BFAfterSaleProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFAfterSaleProgressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xF2F4F5);
        [self setCell];
    }
    return self;
}

- (void)setCell {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(145))];
    bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:bottomView];
    
    UIView *firstLine = [self setUpLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [bottomView addSubview:firstLine];
    
    self.orderID = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(200), Height)];
    self.orderID.text = @"订单编号：160589998";
    self.orderID.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    //self.orderID.backgroundColor = [UIColor redColor];
    [bottomView addSubview:self.orderID];
    
    
    self.addOrderTime = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(150), 0, BF_ScaleWidth(160), self.orderID.height)];
    self.addOrderTime.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    self.addOrderTime.textAlignment = NSTextAlignmentRight;
    //self.applySaleTime.textColor = BFColor(0x4992D3);
    //self.applySaleTime.backgroundColor = [UIColor greenColor];
    self.addOrderTime.text = @"2016-05-19 9:00:02";
    [bottomView addSubview:self.addOrderTime];
    
    
    UIView *secondLine = [self setUpLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.orderID.frame)-0.5, ScreenWidth, 0.5)];
    [bottomView addSubview:secondLine];
    
    self.productView = [[BFAfterSaleProductView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.orderID.frame), ScreenWidth, BF_ScaleHeight(95))];
    [bottomView addSubview:self.productView];
    
    
    self.applySaleTime = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.productView.frame), BF_ScaleWidth(200), Height)];
    self.applySaleTime.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    self.applySaleTime.textAlignment = NSTextAlignmentLeft;
    self.applySaleTime.textColor = BFColor(0x97999A);
    //self.applySaleTime.backgroundColor = [UIColor greenColor];
    self.applySaleTime.text = @"申请时间:2016-05-19 12:00:02";
    [bottomView addSubview:self.applySaleTime];
    
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(220), CGRectGetMaxY(self.productView.frame), BF_ScaleWidth(90), self.applySaleTime.height)];
    self.statusLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    self.statusLabel.textAlignment = NSTextAlignmentRight;
    self.statusLabel.textColor = BFColor(0x97999A);
    //self.statusLabel.backgroundColor = [UIColor greenColor];
    self.statusLabel.text = @"状态:未处理";
    [bottomView addSubview:self.statusLabel];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.statusLabel.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xCF0002) range:NSMakeRange(3, self.statusLabel.text.length - 3)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(13)] range:NSMakeRange(3, self.statusLabel.text.length - 3)];
    self.statusLabel.attributedText = attributedString;

    
    
    
    UIView *thirdLine = [self setUpLineWithFrame:CGRectMake(0, CGRectGetMaxY(bottomView.frame)-0.5, ScreenWidth, 0.5)];
    [bottomView addSubview:thirdLine];
}

- (UIView *)setUpLineWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = BFColor(0xBDBEC0);
    return line;
}

@end
