//
//  PTModel.h
//  缤微纷购
//
//  Created by 郑洋 on 16/2/25.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>





//@class PTListModel;
//@interface PTModel : NSObject
//
//@property (nonatomic, strong) NSArray<PTListModel *> *PTList;
//
//@end


@interface PTModel : NSObject

@property (nonatomic,retain)NSString *content;
@property (nonatomic,retain)NSString *ID;
@property (nonatomic,retain)NSString *isteam;
@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *img;
@property (nonatomic,retain)NSString *intro;
@property (nonatomic,retain)NSString *team_price;
@property (nonatomic,retain)NSString *team_num;
@property (nonatomic,retain)NSString *team_discount;

@property (nonatomic,retain)NSString *price;
@property (nonatomic,retain)NSString *url;
@property (nonatomic,retain)NSString *info;
@end

