//
//  BFCustomerOrderCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCommissionModel.h"

@interface BFCustomerOrderCell : UITableViewCell
/**创建自定义cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**ProxyOrderList模型*/
@property (nonatomic, strong) ProxyOrderList *model;
@end
