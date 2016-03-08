//
//  SPTableViewCell.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "AddShopping.h"
#import "BFShoppModel.h"
#import <UIKit/UIKit.h>
//  是否被选中回调
typedef void (^selectBlock)(BOOL select);
//  数量改变的回调
typedef void(^numChange)();

@interface SPTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *numberLabel;
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,copy)selectBlock selBlock;
@property (nonatomic,copy)numChange numAddBlock;
@property (nonatomic,copy)numChange numCutBlock;
@property (nonatomic,retain)AddShopping *add;
@property (nonatomic,retain)UIButton *close;

- (void)reloadDataWith:(BFShoppModel *)model;
@end
