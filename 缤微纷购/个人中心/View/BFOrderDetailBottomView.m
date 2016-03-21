//
//  BFOrderDetailBottomView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFOrderDetailBottomView.h"

@implementation BFOrderDetailBottomView

+ (instancetype)createFooterView {
    BFOrderDetailBottomView *view = [[BFOrderDetailBottomView alloc] init];
    return view;
}

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, ScreenHeight-BF_ScaleHeight(50)-64, ScreenWidth, BF_ScaleHeight(50));
        self.backgroundColor = BFColor(0xffffff);
        [self setView];
    }
    return self;
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
