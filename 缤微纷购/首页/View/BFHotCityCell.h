//
//  BFHotCityCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/3.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseHotCityDelegate <NSObject>

- (void)chooseHotCity:(NSString *)city;

@end


@interface BFHotCityCell : UITableViewCell
/**创建自定义cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**自定义cell的高度*/
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) UIButton *cityButton;
/**代理*/
@property (nonatomic, weak) id<ChooseHotCityDelegate>delegate;
@end
