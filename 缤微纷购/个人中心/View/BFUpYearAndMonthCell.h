//
//  BFUpYearAndMonthCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFDateModel.h"

@interface BFUpYearAndMonthCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**年月*/
@property (nonatomic, strong) UILabel *yearAndMonth;
/**BFDateModel*/
@property (nonatomic, strong) BFDateModel *model;
@end
