//
//  BFBottomHeaderCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFBottomHeaderCellDelegate <NSObject>

- (void)clickToChangeStatus:(UIButton *)button;

@end


@interface BFBottomHeaderCell : UITableViewCell
/**自定义方法*/
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
/**时间日期label*/
@property (nonatomic, strong) UILabel *timeLabel;
/**代理*/
@property (nonatomic, weak) id<BFBottomHeaderCellDelegate>delegate;
/**点击按钮*/
- (void)click;
@end
