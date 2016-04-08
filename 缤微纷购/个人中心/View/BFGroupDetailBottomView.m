//
//  BFGroupDetailBottomView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailBottomView.h"

@implementation BFGroupDetailBottomView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    
    UIView *upLine = [UIView drawLineWithFrame:CGRectMake(ScreenWidth/2-0.5, BF_ScaleHeight(25), 1, BF_ScaleHeight(15))];
    upLine.backgroundColor = BFColor(0xA6A6A6);
    [self addSubview:upLine];

    //缤纷世家按钮
    UIButton *homeButton = [UIButton buttonWithType:0];
    homeButton.frame = CGRectMake(BF_ScaleWidth(90), BF_ScaleHeight(25), BF_ScaleWidth(60), BF_ScaleHeight(15));
    homeButton.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    [homeButton setTitle:@"缤纷世家" forState:UIControlStateNormal];
    [homeButton setTitleColor:BFColor(0xEB2E3D) forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(homeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:homeButton];
    
    //我的团按钮
    UIButton *myGroup = [UIButton buttonWithType:0];
    myGroup.frame = CGRectMake(BF_ScaleWidth(170), BF_ScaleHeight(25), BF_ScaleWidth(50), BF_ScaleHeight(15));
    myGroup.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    [myGroup setTitle:@"我的团" forState:UIControlStateNormal];
    [myGroup setTitleColor:BFColor(0x797979) forState:UIControlStateNormal];
    [myGroup addTarget:self action:@selector(myGroupClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:myGroup];
    
    
    
    UIView *bottomLine = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleHeight(50)-1, ScreenWidth, 1)];
    bottomLine.backgroundColor = BFColor(0xA6A6A6);
    [self addSubview:bottomLine];
}

//缤纷世家按钮点击事件
- (void)homeButtonClick {
    [BFNotificationCenter postNotificationName:@"homeButtonClick" object:nil];
}
//我的团按钮点击事件
- (void)myGroupClick {
    [BFNotificationCenter postNotificationName:@"myGroupClick" object:nil];
}

@end
