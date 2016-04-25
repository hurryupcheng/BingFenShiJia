//
//  BFCurrentLocationCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/3.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>




/**设置定位代理*/
@protocol SettingLocationDelegate <NSObject>

- (void)goToSettingInterface;

- (void)goBackToHomeWithCity:(NSString *)city;

@end


@interface BFCurrentLocationCell : UITableViewCell
/**创建自定义cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**设置定位的代理*/
@property (nonatomic, assign) id<SettingLocationDelegate>delegate;


@property (nonatomic, assign) CLAuthorizationStatus status;
@end
