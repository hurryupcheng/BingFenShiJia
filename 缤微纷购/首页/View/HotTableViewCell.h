//
//  HotTableViewCell.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotTableViewCell : UITableViewCell

@property (nonatomic,retain)UIButton *button;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)arr count:(NSInteger)count;

@end
