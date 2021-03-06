//
//  BFWithdrawalRecordCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFWithdrawalRecordModel.h"

@interface BFWithdrawalRecordCell : UITableViewCell
/**自定义方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**提现记录的模型*/
@property (nonatomic, strong) BFWithdrawalRecordList *model;
@end
