//
//  DWTableViewController.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWTableViewController : UIViewController
//回调选择的城市
@property (nonatomic, copy)void (^cityBlock)(NSString *city);


@end
