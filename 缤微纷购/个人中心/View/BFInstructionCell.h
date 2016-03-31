//
//  BFInstructionCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFRecommendDividedModel.h"

@interface BFInstructionCell : UITableViewCell

/**创建自定义cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**推荐分成数组模型*/
@property (nonatomic, strong) RecommendDividedList *model;
@end
