//
//  BFAddressCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAddressModel.h"
@interface BFAddressCell : UITableViewCell
/**自定义类方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**BFAddressModel模型*/
@property (nonatomic, strong) BFAddressModel *model;
@end
