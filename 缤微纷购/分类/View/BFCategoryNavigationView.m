//
//  BFCategoryNavigationView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFCategoryNavigationView.h"
#import "BFShoppingCartButton.h"

@interface BFCategoryNavigationView()

@end

@implementation BFCategoryNavigationView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xffffff);
        [self setView];
    }
    return self;
}

- (void)setView {
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, BF_ScaleWidth(320), 44)];
    [self addSubview:bottomView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(BF_ScaleWidth(60), 0, BF_ScaleWidth(200), 44);
    self.titleLabel.textColor = BFColor(0x0E61C0);
    self.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(18)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:self.titleLabel];
   
}

@end
