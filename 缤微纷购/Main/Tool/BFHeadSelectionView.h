//
//  BFHeadSelectionView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BFHeadSelectionViewButtonTypeCamera,//相机
    BFHeadSelectionViewButtonTypeAlbum//相册
}BFHeadSelectionViewButtonType;


@protocol BFHeadSelectionViewDelegate <NSObject>

- (void)clickToChooseModeWithType:(BFHeadSelectionViewButtonType)type;

@end


@interface BFHeadSelectionView : UIView

/**创建view*/
+ (instancetype)headSelectionView;
/**代理*/
@property (nonatomic, weak) id<BFHeadSelectionViewDelegate>delegate;

@end
