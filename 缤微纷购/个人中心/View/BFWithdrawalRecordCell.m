//
//  BFWithdrawalRecordCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFWithdrawalRecordCell.h"

@interface BFWithdrawalRecordCell()
/**底部view*/
@property (nonatomic, strong) UIView *bottomView;
/**提现金额*/
@property (nonatomic, strong) UILabel *withdrawalsTime;
/**提现金额*/
@property (nonatomic, strong) UILabel *withdrawalsAmount;
/**实收金额*/
@property (nonatomic, strong) UILabel *receivedAmount;
@end


@implementation BFWithdrawalRecordCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFWithdrawalRecordCell";
    BFWithdrawalRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFWithdrawalRecordCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xECECEC);
        [self setCell];
    }
    return self;
}

- (void)setCell {
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(5), BF_ScaleHeight(10), BF_ScaleWidth(310), BF_ScaleHeight(50))];
    self.bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:self.bottomView];
    
    self.withdrawalsTime = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(15), BF_ScaleHeight(5), BF_ScaleWidth(250), BF_ScaleHeight(20)) text:@"提现时间：2016-03-12 10:13:08"];
    
    self.withdrawalsAmount = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(15), CGRectGetMaxY(self.withdrawalsTime.frame)+BF_ScaleHeight(5), BF_ScaleWidth(250), 0)];
    self.withdrawalsAmount.numberOfLines = 0;
    self.withdrawalsAmount.text = @"提现金额：¥130.00";
    self.withdrawalsAmount.textColor = BFColor(0x272727);
    //self.withdrawalsAmount.backgroundColor = [UIColor redColor];
    self.withdrawalsAmount.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    [self.bottomView addSubview:self.withdrawalsAmount];
    [self.withdrawalsAmount sizeToFit];
    
    
    self.receivedAmount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.withdrawalsAmount.frame)+BF_ScaleWidth(5), self.withdrawalsAmount.y, BF_ScaleWidth(250), 0)];
    self.receivedAmount.numberOfLines = 0;
    self.receivedAmount.text = @"实收金额：¥130.00";
    self.receivedAmount.textColor = BFColor(0x272727);
    //self.receivedAmount.backgroundColor = [UIColor redColor];
    self.receivedAmount.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    [self.bottomView addSubview:self.receivedAmount];
    [self.receivedAmount sizeToFit];
}

- (UILabel *)setUpLabelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = BFColor(0x272727);
    //label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    [self.bottomView addSubview:label];
    return label;
}

@end
