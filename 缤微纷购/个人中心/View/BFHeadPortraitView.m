//
//  BFHeadPortraitView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/31.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFHeadPortraitView.h"

@implementation BFHeadPortraitView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFit;

    }
    return self;
}


- (void)setUser:(TeamList *)user {
    _user = user;
    [self sd_setImageWithURL:[NSURL URLWithString:user.user_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
}




@end
