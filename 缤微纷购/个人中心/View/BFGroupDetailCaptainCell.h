//
//  BFGroupDetailCaptainCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFGroupDetailModel.h"

@interface BFGroupDetailCaptainCell : UITableViewCell
/**自定义的方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**模型*/
@property (nonatomic, strong) TeamList *model;
/**模型*/
@property (nonatomic, strong) BFGroupDetailModel *detailModel;
@end
