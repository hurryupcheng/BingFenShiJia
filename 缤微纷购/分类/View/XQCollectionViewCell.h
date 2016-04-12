//
//  XQCollectionViewCell.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "XQModel.h"
#import <UIKit/UIKit.h>
@class XQCollectionViewCell;

@protocol XQViewCellDelegate <NSObject>

- (void)xqViewDelegate:(UICollectionViewCell *)cell index:(NSInteger )index;

@end

@interface XQCollectionViewCell : UICollectionViewCell

@property (nonatomic,retain)UIButton *shopp;
@property (nonatomic,assign)id<XQViewCellDelegate>butDelegate;

- (void)setXQModel:(XQSubOtherModel *)xqModel;


@end
