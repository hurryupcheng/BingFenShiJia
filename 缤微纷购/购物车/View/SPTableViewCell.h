//
//  SPTableViewCell.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "FXQModel.h"
#import "AddShopping.h"
#import "BFStorage.h"
#import <UIKit/UIKit.h>
//  是否被选中回调
typedef void (^selectBlock)(BOOL select);
//  数量改变的回调
typedef void(^numChange)();




@interface SPTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,retain)UILabel *numberLabel;
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,copy)selectBlock selBlock;
@property (nonatomic,copy)numChange numAddBlock;
@property (nonatomic,copy)numChange numCutBlock;
@property (nonatomic,copy)numChange sumBlock;
@property (nonatomic,retain)AddShopping *add;
@property (nonatomic,retain)UIButton *close;

@property (nonatomic,assign)NSInteger cellHeight;

- (void)reloadDataWith:(BFStorage *)model;


@end
