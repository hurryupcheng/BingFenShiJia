//
//  BFHomeModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFHomeFunctionButtonList, BFHomeBannerList, BFSettingList;
@interface BFHomeModel : NSObject
/**8个功能按钮*/
@property (nonatomic, strong) NSArray<BFHomeFunctionButtonList *> *abs_b;
/**ads_pic*/
@property (nonatomic, strong) NSString *ads_pic;
/**轮播图*/
@property (nonatomic, strong) NSArray<BFHomeBannerList *> *ads_banner;
/**设置页面，关于缤纷的点击跳转*/
@property (nonatomic, strong) NSArray<BFSettingList *> *about_link;
@end

@interface BFHomeFunctionButtonList : NSObject
/**typeid*/
@property (nonatomic, strong) NSString *typeId;
/**cid*/
@property (nonatomic, strong) NSString *cid;
/**标题*/
@property (nonatomic, strong) NSString *title;
/**图片*/
@property (nonatomic, strong) NSString *img;
/**url*/
@property (nonatomic, strong) NSString *url;
@end

@interface BFHomeBannerList : NSObject
/**url*/
@property (nonatomic, strong) NSString *url;
/**图片网址*/
@property (nonatomic, strong) NSString *content;
/**id_type*/
@property (nonatomic, strong) NSString *id_type;
@end

@interface BFSettingList : NSObject
/**url*/
@property (nonatomic, strong) NSString *ID;
/**网址链接*/
@property (nonatomic, strong) NSString *url;

@end

