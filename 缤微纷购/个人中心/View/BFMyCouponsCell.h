//
//  BFMyCouponsCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMyCouponsModel.h"

@interface BFMyCouponsCell : UITableViewCell
/**创建自定义cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**BFMyCouponsModel模型*/
@property (nonatomic, strong) BFMyCouponsModel *model;
@end
