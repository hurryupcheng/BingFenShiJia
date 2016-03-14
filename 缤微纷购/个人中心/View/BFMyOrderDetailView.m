//
//  BFMyOrderDetailView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyOrderDetailView.h"

@implementation BFMyOrderDetailView

+ (instancetype)detailView {
    BFMyOrderDetailView *view = [[BFMyOrderDetailView alloc] init];
    return view;
}

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 66, ScreenWidth, ScreenHeight-66);
        self.backgroundColor = BFColor(0xF4F4F4);
    }
    return self;
}

@end
