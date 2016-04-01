//
//  BFAddressModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFAddressModel : NSObject
/**用户名*/
@property (nonatomic, strong) NSString *consignee;
/**省份*/
@property (nonatomic, strong) NSString *sheng;
/**城市*/
@property (nonatomic, strong) NSString *shi;
/**地区*/
@property (nonatomic, strong) NSString *qu;
/**地址详情*/
@property (nonatomic, strong) NSString *address;
/**手机号码*/
@property (nonatomic, strong) NSString *mobile;
/**类型*/
@property (nonatomic, strong) NSString *ID;
/**默认*/
@property (nonatomic, strong) NSString *type;
/**id*/
@property (nonatomic, strong) NSString *def;

@end
