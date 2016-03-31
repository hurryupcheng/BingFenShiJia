//
//  BFGroupDetailProductCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/30.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFGroupDetailModel.h"

@interface BFGroupDetailProductCell : UITableViewCell
/**自定义方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**商品模型*/
@property (nonatomic, strong) ItemModel *model;
/**BFGroupDetailModel*/
@property (nonatomic, strong) BFGroupDetailModel *detailModel;
@end
