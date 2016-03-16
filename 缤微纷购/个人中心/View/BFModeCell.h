//
//  BFModeCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFProductInfoModel.h"

@interface BFModeCell : UITableViewCell
/**自定义类方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**返回cell的高度*/
@property (nonatomic, assign) CGFloat modeCellH;
/**BFProductInfoModel模型类*/
@property (nonatomic, strong) BFProductInfoModel *model;
@end
