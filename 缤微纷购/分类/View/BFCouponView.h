//
//  BFCouponView.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFCouponView;

@protocol BFCouponViewDelegate <NSObject>

- (void)BFCouponViewDelegate:(BFCouponView *)view index:(NSInteger)index;

@end

@interface BFCouponView : UIView

@property (nonatomic,assign)NSInteger height;
@property (nonatomic,retain)UIButton *couponBt;
@property (nonatomic,assign)id<BFCouponViewDelegate>couponDelegate;

- (instancetype)initWithFrame:(CGRect)frame type:(NSMutableArray *)type name:(NSMutableArray *)name price:(NSMutableArray *)price end:(NSMutableArray *)end;

@end
