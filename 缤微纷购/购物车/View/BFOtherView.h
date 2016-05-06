//
//  BFOtherView.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFOtherView;

@protocol BFOtherViewDelegate <NSObject>

- (void)BFOtherViewDelegate:(BFOtherView *)otherView ID:(NSString *)itemID;

@end

@interface BFOtherView : UIView

@property (nonatomic,retain)UIButton *imgButton;
@property (nonatomic,assign)id<BFOtherViewDelegate>otherDelegate;
@end
