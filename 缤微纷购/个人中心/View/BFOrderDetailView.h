//
//  BFOrderDetailView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFOrderDetailView : UIView

/**状态*/
@property (nonatomic, strong) UILabel *status;
/**订单号*/
@property (nonatomic, strong) UILabel *orderID;
/**下单时间*/
@property (nonatomic, strong) UILabel *orderTime;

/**自定义类方法*/
+ (instancetype)detailView;
@end
