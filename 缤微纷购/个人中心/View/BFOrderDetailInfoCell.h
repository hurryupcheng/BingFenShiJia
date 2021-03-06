//
//  BFOrderDetailInfoCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFProductInfoModel.h"

@interface BFOrderDetailInfoCell : UITableViewCell
/**自定义类方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**BFProductInfoModel*/
@property (nonatomic, strong) BFProductInfoModel *model;
@end
