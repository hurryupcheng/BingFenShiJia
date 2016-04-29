//
//  BFOrderIDCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFOrderIDCell.h"

@interface BFOrderIDCell()
/**订单编号*/
@property (nonatomic, strong) UILabel *orderID;
/**订单状态*/
@property (nonatomic, strong) UILabel *statusLabel;
@end


@implementation BFOrderIDCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFOrderIDCell";
    BFOrderIDCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFOrderIDCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)setModel:(BFLogisticsModel *)model {
    _model = model;
    self.orderID.text = [NSString stringWithFormat:@"订单编号:%@",model.orderId];
    if ([model.status isEqualToString:@"3"]) {
        self.statusLabel.text = @"已发货";
    }else if ([model.status isEqualToString:@"4"]){
        self.statusLabel.text = @"已完成";
    }
}

- (void)setCell {
    UIView *firstLine = [self setUpLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [self addSubview:firstLine];
    
    self.orderID = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(200), BF_ScaleHeight(25))];
    self.orderID.text = @"订单编号：160589998";
    self.orderID.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    //self.orderID.backgroundColor = [UIColor redColor];
    [self addSubview:self.orderID];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(220), 0, BF_ScaleWidth(90), self.orderID.height)];
    self.statusLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    self.statusLabel.textAlignment = NSTextAlignmentRight;
    self.statusLabel.textColor = BFColor(0x4992D3);
    //self.statusLabel.backgroundColor = [UIColor greenColor];
    self.statusLabel.text = @"已发货";
    [self addSubview:self.statusLabel];
    
//    UIView *secondLine = [self setUpLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.orderID.frame)-0.5, ScreenWidth, 0.5)];
//    [self addSubview:secondLine];
}

- (UIView *)setUpLineWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = BFColor(0xBDBEC0);
    return line;
}

@end
