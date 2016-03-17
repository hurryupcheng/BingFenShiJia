//
//  BFAddAddressView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  BFAddAddressViewDelegate <NSObject>

- (void)goBackToAddressView;

@end


@interface BFAddAddressView : UIView
/**自定义类方法*/
+ (instancetype)creatView;
/**代理*/
@property (nonatomic, weak) id<BFAddAddressViewDelegate>delegate;
@end
