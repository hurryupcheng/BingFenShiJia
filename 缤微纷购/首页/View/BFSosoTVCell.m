
//
//  BFSosoTVCell.m
//  缤微纷购
//
//  Created by Wind on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFSosoTVCell.h"
#import "Header.h"
#import "ViewController.h"


@implementation BFSosoTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)BFSosoTVCell:(UITableView *)tableView{
    static NSString *reuseId = @"BFSosoTVCellId";
    BFSosoTVCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BFSosoTVCell" owner:nil options:nil]lastObject];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.HFSosoTitleLabel.size = CGSizeMake(kScreenWidth/2, CGFloatY(20));
    }
    return cell;
}

@end
