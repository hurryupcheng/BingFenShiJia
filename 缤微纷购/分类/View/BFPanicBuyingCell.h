//
//  BFPanicBuyingCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFPanicBuyingCell : UITableViewCell
/**自定义方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**label*/
@property (nonatomic, strong) UILabel *titleLabel;
@end
