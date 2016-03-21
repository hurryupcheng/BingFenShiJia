//
//  BFLogisticsHeaderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFLogisticsHeaderView.h"
#import "UnderLineLabel.h"
@implementation BFLogisticsHeaderView

+ (instancetype)createHeaderView {
    BFLogisticsHeaderView *view = [[BFLogisticsHeaderView alloc] init];
    return view;
}

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(30));
        self.backgroundColor = BFColor(0xF2F4F5);
        UnderLineLabel *commonProblem = [[UnderLineLabel alloc] initWithFrame:self.frame];
        commonProblem.textColor = BFColor(0x9192A0);
        commonProblem.shouldUnderline = YES;
        commonProblem.highlightedColor = [UIColor redColor];
        commonProblem.font = [UIFont systemFontOfSize:BF_ScaleHeight(11)];
        [commonProblem setText:@"收货后48小时内可以申请售后服务，点击查看常见问题" andCenter:CGPointMake(ScreenWidth/2, BF_ScaleHeight(15))];
        [commonProblem addTarget:self action:@selector(labelClicked)];
        [self addSubview:commonProblem];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(30)-0.5, ScreenWidth, 0.5)];
        line.backgroundColor = BFColor(0xBDBEC0);
        [self addSubview:line];
    }
    return self;
}


- (void)labelClicked {
    BFLog(@"点击");
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToSeeConmmonProblem)]) {
        [self.delegate clickToSeeConmmonProblem];
    }
}
@end
