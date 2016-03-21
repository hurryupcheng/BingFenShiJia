//
//  BFLogisticsCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFProductModel.h"

//typedef enum {
//    BFLogisticsCellButtonTypeApplyAfterSale,//申请售后
//    BFLogisticsCellButtonTypeCheckLogistics,//物流查询
//    BFLogisticsCellButtonTypeConfirmReceipt//确认收货
//}BFLogisticsCellButtonType;
//
//
//@protocol BFLogisticsCellDelegate <NSObject>
//
//- (void)clickToOperateWithType:(BFLogisticsCellButtonType)type;
//
//@end


@interface BFLogisticsCell : UITableViewCell
/**自定义类方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**代理*/
//@property (nonatomic, weak) id<BFLogisticsCellDelegate>delegate;
/**模型类*/
@property (nonatomic, strong) BFProductModel *model;
@end
