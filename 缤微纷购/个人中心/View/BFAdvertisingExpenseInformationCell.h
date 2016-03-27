//
//  BFAdvertisingExpenseInformationCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCommissionModel.h"

@interface BFAdvertisingExpenseInformationCell : UITableViewCell
/**自定义cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**BFCommissionModel模型*/
@property (nonatomic, strong) BFCommissionModel *model;

@end
