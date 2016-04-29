//
//  BFOrderIdView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFOrderIdView.h"

@interface BFOrderIdView()
/**订单编号*/
@property (nonatomic, strong) UILabel *orderIDLabel;

@end

@implementation BFOrderIdView



- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xffffff);
        [self setView];
    }
    return self;
}

- (void)setModel:(BFProductInfoModel *)model {
    _model = model;
    self.orderIDLabel.text = [NSString stringWithFormat:@"订单编号:%@", model.orderId];
    
    if ([model.status isEqualToString:@"1"]) {
        self.statusLabel.text = @"未付款";
    } else if ([model.status isEqualToString:@"2"]){
        self.statusLabel.text = @"待发货";
    } else if ([model.status isEqualToString:@"3"]){
        self.statusLabel.text = @"已发货";
    } else if ([model.status isEqualToString:@"4"]){
        self.statusLabel.text = @"已完成";
    } else {
        self.statusLabel.text = @"关闭";
    }
}

- (void)setView {
    UIView *firstLine = [self setUpLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [self addSubview:firstLine];
    
    self.orderIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(15), 0, BF_ScaleWidth(230), self.height)];
    self.orderIDLabel.text = @"订单编号:160589998";
    self.orderIDLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    //self.orderID.backgroundColor = [UIColor redColor];
    [self addSubview:self.orderIDLabel];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(215), 0, BF_ScaleWidth(90), self.orderIDLabel.height)];
    self.statusLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    self.statusLabel.textAlignment = NSTextAlignmentRight;
    self.statusLabel.textColor = BFColor(0x4992D3);
    //self.statusLabel.backgroundColor = [UIColor greenColor];
    self.statusLabel.text = @"已发货";
    [self addSubview:self.statusLabel];
    
    UIView *secondLine = [self setUpLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.orderIDLabel.frame)-0.5, ScreenWidth, 0.5)];
    [self addSubview:secondLine];
}

- (UIView *)setUpLineWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = BFColor(0xBDBEC0);
    return line;
}


@end
