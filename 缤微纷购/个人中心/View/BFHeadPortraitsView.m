//
//  BFHeadPortraitsView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/31.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define HeadPortraitWH         BF_ScaleWidth(45)
#define HeadPortraitMargin 10
#define HeadPortraitMaxCol(count) ((count==4)?2:3)

#import "BFHeadPortraitsView.h"
#import "BFHeadPortraitView.h"

@implementation BFHeadPortraitsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSUInteger photosCount = photos.count;
    
    // 创建足够数量的图片控件
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        BFHeadPortraitView *headPortrait = self.subviews[i];
        headPortrait.user.user_icon = photos[i];
        headPortrait.hidden = NO;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = 5;
    for (int i = 0; i<photosCount; i++) {
        BFHeadPortraitView *headPortrait = self.subviews[i];
        int col = i % maxCol;
        headPortrait.x = col * (HeadPortraitWH + HeadPortraitMargin);
        
        int row = i / maxCol;
        headPortrait.y = row * (HeadPortraitWH + HeadPortraitMargin);
        headPortrait.width = HeadPortraitWH;
        headPortrait.height = HeadPortraitWH;
    }
}

+ (CGSize)sizeWithCount:(NSUInteger)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = 5;
    
    ///Users/apple/Desktop/课堂共享/05-iPhone项目/1018/代码/黑马微博2期35-相册/黑马微博2期/Classes/Home(首页)/View/HWStatusPhotosView.m 列数
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * HeadPortraitWH + (cols - 1) * HeadPortraitMargin;
    
    // 行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * HeadPortraitWH + (rows - 1) * HeadPortraitMargin;
    
    return CGSizeMake(photosW, photosH);
}


@end
