//
//  XCCollectionViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "Header.h"
#import "XCCollectionViewCell.h"

@implementation XCCollectionViewCell


- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, item_x, item_x)];
//        _imageView.backgroundColor = [UIColor orangeColor];
        _imageView.layer.borderWidth = 1;
        _imageView.layer.borderColor = [UIColor grayColor].CGColor;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

@end
