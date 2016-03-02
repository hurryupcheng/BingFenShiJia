//
//  SPTableViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "SPTableViewCell.h"

@interface SPTableViewCell ()

@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UILabel *titleLael;
@property (nonatomic,retain)UILabel *weightLabel;
@property (nonatomic,retain)UILabel *moneyLabel;

@end

@implementation SPTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView{
    if ([super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        _tableView = tableView;
    }
    [self initWithView];
    return self;
}

- (void)initWithView{
        
        self.needV = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 90, 90)];
        self.needV.backgroundColor = [UIColor redColor];
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.needV.frame), 5, self.frame.size.height-10, self.frame.size.height-10)];
        self.imageV.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.needV];

}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
        _moneyLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.moneyLabel];
    }
    return _moneyLabel;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
