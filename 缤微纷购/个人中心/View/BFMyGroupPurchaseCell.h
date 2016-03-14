//
//  BFMyGroupPurchaseCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MyGroupPurchaseCellCheckButtonTypeGroup,//查看团详情
    MyGroupPurchaseCellCheckButtonTypeOrder//查看订单详情
}MyGroupPurchaseCellCheckButtonType;

@protocol BFMyGroupPurchaseCellDelegate <NSObject>

- (void)clickToGotoCheckDetailWithButtonType:(MyGroupPurchaseCellCheckButtonType)type;

@end

@interface BFMyGroupPurchaseCell : UITableViewCell
/**自定义cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**代理*/
@property (nonatomic, weak) id<BFMyGroupPurchaseCellDelegate>delegate;

@end
