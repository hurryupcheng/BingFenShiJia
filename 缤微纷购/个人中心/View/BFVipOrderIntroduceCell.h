//
//  BFVipOrderIntroduceCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/5/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFVIPOrderModel.h"

@interface BFVipOrderIntroduceCell : UITableViewCell
/**实例方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**vip订单模型*/
@property (nonatomic, strong) BFVIPOrderModel *model;
@end
