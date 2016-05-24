//
//  BFGroupDetailSofaCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/5/24.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFGroupDetailModel.h"

@interface BFGroupDetailSofaCell : UITableViewCell
/**自定义的方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**数组模型*/
@property (nonatomic, strong) TeamList *model;
@end
