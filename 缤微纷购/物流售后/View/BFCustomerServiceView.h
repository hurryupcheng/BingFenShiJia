//
//  BFCustomerServiceView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BFCustomerServiceViewButtonTypeTelephone,//
    BFCustomerServiceViewButtonTypeWechat//
}BFCustomerServiceViewButtonType;


@protocol BFCustomerServiceViewDelegate <NSObject>

- (void)clickToChooseCustomerServiceWithType:(BFCustomerServiceViewButtonType)type;

@end

@interface BFCustomerServiceView : UIView

/**自定义方法*/
+ (instancetype)createCustomerServiceView;
/**代理*/
@property (nonatomic, weak) id<BFCustomerServiceViewDelegate>delegate;
@end
