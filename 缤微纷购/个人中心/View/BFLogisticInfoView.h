//
//  BFLogisticInfoView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFLogisticInfoView : UIView
/**自定义类方法*/
+ (instancetype)logisticView;
/**收货地址*/
@property (nonatomic, strong) UILabel *address;
/**配送方式*/
@property (nonatomic, strong) UILabel *deliverie;
/**收货地址*/
@property (nonatomic, strong) UILabel *expressCompany;
/**收货地址*/
@property (nonatomic, strong) UILabel *expressNumber;
@end
