//
//  BFCustomerIntroduceCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/5/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCustmorOrderModel.h"

@interface BFCustomerIntroduceCell : UITableViewCell
/**实例方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**客户订单模型*/
@property (nonatomic, strong) BFCustmorOrderModel *model;
@end
