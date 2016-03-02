//
//  PTTableViewCell.h
//  缤微纷购
//
//  Created by 郑洋 on 16/2/25.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "PTModel.h"
#import <UIKit/UIKit.h>

@interface PTTableViewCell : UITableViewCell
/**返回的cell的高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/**模型类*/
@property (nonatomic, strong) PTModel *model;
@end
