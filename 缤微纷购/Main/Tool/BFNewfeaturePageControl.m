//
//  BFNewfeaturePageControl.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFNewfeaturePageControl.h"

@implementation BFNewfeaturePageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _activeImage = [UIImage imageNamed:@"current_page"];
    _inactiveImage = [UIImage imageNamed:@"page"];
    return self;
}



- (void)updateDots
{
    for (int i = 0; i< [self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage){
            dot.image = _activeImage;
        }
        else
            dot.image = _inactiveImage;
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    //修改图标大小
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        CGSize size;
        
        size.height = 10;
        
        size.width = 10;
        
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,size.width,size.height)];
        
    }
    [self updateDots];
}

@end
