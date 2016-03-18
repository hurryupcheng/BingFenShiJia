//
//  BFEditAddressView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAddressModel.h"


@protocol BFEditAddressViewDelegate <NSObject>

- (void)clickToGoBackToAddressController;

@end

@interface BFEditAddressView : UIView
/**自定义类方法*/
+ (instancetype)creatView;
/**BFAddressModel模型*/
@property (nonatomic, strong) BFAddressModel *model;
/**代理*/
@property (nonatomic, weak) id<BFEditAddressViewDelegate>delegate;
@end
