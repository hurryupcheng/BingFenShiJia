//
//  BFDailySpecialCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFDailySpecialModel.h"
#import "BFDailySpecialProductView.h"

@interface BFDailySpecialCell : UITableViewCell
/**自定义方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**产品*/
@property (nonatomic, strong) BFDailySpecialProductView *productView;
/**抢购商品模型*/
@property (nonatomic, strong) BFDailySpecialProductList *model;

@end
