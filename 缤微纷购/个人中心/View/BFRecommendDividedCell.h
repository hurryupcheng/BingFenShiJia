//
//  BFRecommendDividedCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/25.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFRecommendDividedModel.h"


@interface BFRecommendDividedCell : UITableViewCell
/**自定义cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**推荐分成订单模型*/
@property (nonatomic, strong) BFRecommendDividedModel *model;
@end
