//
//  Header.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define URL @"http://bingo.luexue.com/index.php"

#define fen_x (kScreenWidth/4)
#define but_x kScreenWidth/4-6
#define image_x (kScreenWidth/4-6)-20
#define item_x (kScreenWidth-5-5-5)/2
//#define x4 ((kScreenWidth-80)-5-5-5-5)/3

#define button_x kScreenWidth-49/2
#define button_x1 kScreenWidth/3
#define button_y (kScreenHeight-49)/2

#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#endif /* Header_h */
