//
//  BFResultTableViewCell.h
//  缤微纷购
//
//  Created by 郑洋 on 16/5/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFSosoModel.h"
#import <UIKit/UIKit.h>
@class BFResultTableViewCell;

@protocol BFResultDelegate <NSObject>

- (void)resultDelegate:(NSInteger)index;

@end

@interface BFResultTableViewCell : UITableViewCell

@property (nonatomic,retain)UIButton *buy;
@property (nonatomic,assign)NSInteger cellHeigh;
@property (nonatomic,assign)id<BFResultDelegate>delegate;
- (void)setmodel:(BFSosoSubOtherModel *)model;
@end
