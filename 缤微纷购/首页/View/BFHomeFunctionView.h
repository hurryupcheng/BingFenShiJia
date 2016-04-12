//
//  BFHomeFunctionView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    /**果食*/
    BFHomeFunctionViewButtonTypeFruitEating,
    /**地方特产*/
    BFHomeFunctionViewButtonTypeLocalSpeciality,
    /**休闲零食*/
    BFHomeFunctionViewButtonTypeCasualSnacks,
    /**酒水*/
    BFHomeFunctionViewButtonTypeWineDrinking,
    /**今日特价*/
    BFHomeFunctionViewButtonTypeDailySpecial,
    /**新品首发*/
    BFHomeFunctionViewButtonTypeFirstPublish,
    /**热销排行*/
    BFHomeFunctionViewButtonTypeBestSelling,
    /**试吃体验*/
    BFHomeFunctionViewButtonTypeTastingExperience
}BFHomeFunctionViewButtonType;


@protocol BFHomeFunctionViewDelegate <NSObject>

- (void)clickToGotoDifferentViewWithType:(BFHomeFunctionViewButtonType)type;

@end


@interface BFHomeFunctionView : UIView
/**代理*/
@property (nonatomic, weak) id<BFHomeFunctionViewDelegate>delegate;
@end
