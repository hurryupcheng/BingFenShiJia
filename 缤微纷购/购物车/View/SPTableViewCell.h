//
//  SPTableViewCell.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "AddShopping.h"
#import <UIKit/UIKit.h>

@interface SPTableViewCell : UITableViewCell

@property (nonatomic,retain)UIButton *needV;
@property (nonatomic,retain)UIButton *close;
@property (nonatomic,retain)AddShopping *add;
@property (nonatomic,assign)BOOL isEdit;

@end
