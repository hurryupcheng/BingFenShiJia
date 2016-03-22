//
//  BFOrderDetailBottomView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFOrderDetailBottomView.h"

@interface BFOrderDetailBottomView()
/**取消订单*/


@end


@implementation BFOrderDetailBottomView



- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xffffff);
        [self setView];
    }
    return self;
}

- (void)setModel:(BFProductInfoModel *)model {
    _model = model;
}

- (void)setView {
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(BF_ScaleWidth(85), BF_ScaleHeight(10), BF_ScaleHeight(150), BF_ScaleHeight(30));
    button.layer.cornerRadius = BF_ScaleFont(15);
    button.backgroundColor = BFColor(0xFD8627);
    button.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(16)];
    [button setTitle:@"查看物流" forState:UIControlStateNormal];
    [self addSubview:button];
    
}

- (UIView *)setUpLineWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = BFColor(0xBDBEC0);
    return line;
}


@end
