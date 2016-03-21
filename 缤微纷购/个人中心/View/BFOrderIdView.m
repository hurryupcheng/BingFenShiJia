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
/**订单状态*/
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation BFOrderIdView

+ (instancetype)createHeaderView {
    BFOrderIdView *view = [[BFOrderIdView alloc] init];
    return view;
}

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(35));
        self.backgroundColor = BFColor(0xffffff);
        [self setView];
    }
    return self;
}

- (void)setView {
    UIView *firstLine = [self setUpLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [self addSubview:firstLine];
    
    self.orderIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(200), self.height)];
    self.orderIDLabel.text = @"订单编号：160589998";
    self.orderIDLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    //self.orderID.backgroundColor = [UIColor redColor];
    [self addSubview:self.orderIDLabel];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(220), 0, BF_ScaleWidth(90), self.orderIDLabel.height)];
    self.statusLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
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
