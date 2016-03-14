//
//  BFMyOrderCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMyOrderModel.h"
@interface BFMyOrderCell : UITableViewCell
/**创建自定义cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**我的订单模型类*/
@property (nonatomic, strong) BFMyOrderModel *model;
@end
