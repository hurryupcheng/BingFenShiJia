//
//  BFMyAdvertisingExpenseSectionView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMyAdvertisingExpenseModel.h"
@class BFMyAdvertisingExpenseSectionView;
@protocol SectionHeaderViewDelegate <NSObject>

- (void)myAdvertisingExpenseSectionView:(BFMyAdvertisingExpenseSectionView *)view didButton:(UIButton *)button;

@end

@interface BFMyAdvertisingExpenseSectionView : UITableViewHeaderFooterView
/**自定义分区视图*/
+(BFMyAdvertisingExpenseSectionView *)myHeadViewWithTableView:(UITableView *)tableView;
/**代理*/
@property (nonatomic, weak) id<SectionHeaderViewDelegate>delegate;

@property (nonatomic, strong) BFMyAdvertisingExpenseModel *group;

- (void)click;
@end
