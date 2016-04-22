//
//  BFTastingExperienceCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/22.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFTastingExperienceCell : UITableViewCell
/**label*/
@property (nonatomic, strong) UILabel *titleLabel;
/**自定义方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
