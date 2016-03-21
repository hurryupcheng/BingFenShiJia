//
//  BFBottomCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFLogisticsModel.h"


typedef enum {
    BFLogisticsCellButtonTypeApplyAfterSale,//申请售后
    BFLogisticsCellButtonTypeCheckLogistics,//物流查询
    BFLogisticsCellButtonTypeConfirmReceipt//确认收货
}BFLogisticsCellButtonType;


@protocol BFBottomCellDelegate <NSObject>

- (void)clickToOperateWithType:(BFLogisticsCellButtonType)type;

@end



@interface BFBottomCell : UITableViewCell
/**自定义类方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**代理*/
@property (nonatomic, weak) id<BFBottomCellDelegate>delegate;
@end
