//
//  BFProductDetailCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFOrderProductModel.h"
@interface BFProductDetailCell : UITableViewCell
/**自定义类方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**BFOrderProductModel模型类*/
@property (nonatomic, strong) BFOrderProductModel *model;

@end
