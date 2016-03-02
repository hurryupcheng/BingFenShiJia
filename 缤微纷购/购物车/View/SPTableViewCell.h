//
//  SPTableViewCell.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTableViewCell : UITableViewCell

@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIButton *needV;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView;

@end
