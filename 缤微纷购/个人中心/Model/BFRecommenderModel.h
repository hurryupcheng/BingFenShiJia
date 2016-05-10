//
//  BFRecommenderModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFRecommenderModel : NSObject
/**id*/
@property (nonatomic, strong) NSString *ID;
/**推荐人昵称*/
@property (nonatomic, strong) NSString *nickname;
/**状态*/
@property (nonatomic, strong) NSString *status;
@end
