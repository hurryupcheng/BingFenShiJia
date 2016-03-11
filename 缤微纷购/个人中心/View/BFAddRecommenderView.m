//
//  BFAddRecommenderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAddRecommenderView.h"
#import "BFRecommenderModel.h"
@interface BFAddRecommenderView()
//背景图
@property (nonatomic, strong) UIView *blackV;
//点击后的背景
@property (nonatomic, strong) UIView *clickedView;
//点击后的背景
@property (nonatomic, strong) UILabel *memberID;
//点击后的背景
@property (nonatomic, strong) UILabel *nickNameLabel;
@end

@implementation BFAddRecommenderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}




- (void)setView {
    self.blackV = [[UIView alloc]initWithFrame:self.bounds];
    self.blackV.alpha = YES;
    self.blackV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.blackV addGestureRecognizer:tap];
    [self addSubview:self.blackV];
    
    
    UILabel *label = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(150), BF_ScaleWidth(300), BF_ScaleHeight(15)) font:BF_ScaleFont(15) textColor:BFColor(0xffffff) text:@"请输入推荐人ID号："];
    [self.blackV addSubview:label];
    
    self.IDTextField = [UITextField textFieldWithFrame:CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(label.frame)+BF_ScaleHeight(5), BF_ScaleWidth(300), BF_ScaleHeight(30)) image:nil placeholder:nil];
    self.IDTextField .backgroundColor = BFColor(0xffffff);
    self.IDTextField .layer.borderColor = BFColor(0xffffff).CGColor;
    self.IDTextField .layer.borderWidth = 1;
    self.IDTextField .layer.cornerRadius = 3;
    [self.blackV addSubview:self.IDTextField ];
    
    UIButton *sureButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.IDTextField .frame)+BF_ScaleHeight(20), BF_ScaleWidth(80), BF_ScaleHeight(30)) title:@"确定" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
    sureButton.layer.cornerRadius = 3;
    sureButton.backgroundColor = BFColor(0xD70011);
    [sureButton addTarget:self action:@selector(makeSureToAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.blackV addSubview:sureButton];
    
    UIButton *cancleButton = [UIButton buttonWithFrame:CGRectMake(ScreenWidth/2+BF_ScaleWidth(20), CGRectGetMaxY(self.IDTextField .frame)+BF_ScaleHeight(20), BF_ScaleWidth(80), BF_ScaleHeight(30)) title:@"取消" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
    cancleButton.layer.cornerRadius = 3;
    cancleButton.backgroundColor = BFColor(0x0BBC0E);
    [cancleButton addTarget:self action:@selector(cancleToAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.blackV addSubview:cancleButton];
    
    
    self.clickedView = [[UIView alloc]initWithFrame:self.bounds];
    self.clickedView.alpha = YES;
    self.clickedView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self addSubview:self.clickedView];
    
    UILabel *warningLabel = [UILabel labelWithFrame:CGRectMake(0, BF_ScaleHeight(130), ScreenWidth, BF_ScaleHeight(15)) font:BF_ScaleFont(15) textColor:BFColor(0xffffff) text:@"您只有一次调整机会，请确认输入无误"];
    warningLabel.textAlignment = NSTextAlignmentCenter;
    [self.clickedView addSubview:warningLabel];

    UIView *line = [UIView drawLineWithFrame:CGRectMake(0, CGRectGetMaxY(warningLabel.frame)+BF_ScaleHeight(20), ScreenWidth, 2)];
    line.backgroundColor = BFColor(0xffffff);
    [self.clickedView addSubview:line];
    
    self.memberID = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(55), CGRectGetMaxY(line.frame) + BF_ScaleHeight(25), BF_ScaleWidth(150), BF_ScaleHeight(14)) font:BF_ScaleFont(13) textColor:BFColor(0xffffff) text:@"会员号："];
    [self.clickedView addSubview:self.memberID];
    
    self.nickNameLabel = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(55), CGRectGetMaxY(self.memberID.frame) + BF_ScaleHeight(10), BF_ScaleWidth(150), BF_ScaleHeight(14)) font:BF_ScaleFont(13) textColor:BFColor(0xffffff) text:@"昵称："];
    [self.clickedView addSubview:self.nickNameLabel];
    
    
    UIButton *newSure = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(60), CGRectGetMaxY(self.nickNameLabel.frame)+BF_ScaleHeight(20), BF_ScaleWidth(80), BF_ScaleHeight(30)) title:@"确定" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
    newSure.layer.cornerRadius = 3;
    newSure.backgroundColor = BFColor(0xD70011);
    [newSure addTarget:self action:@selector(newSureButtonclick) forControlEvents:UIControlEventTouchUpInside];
    [self.clickedView addSubview:newSure];
    
    UIButton *newCancle = [UIButton buttonWithFrame:CGRectMake(ScreenWidth/2+BF_ScaleWidth(20), CGRectGetMaxY(self.nickNameLabel.frame)+BF_ScaleHeight(20), BF_ScaleWidth(80), BF_ScaleHeight(30)) title:@"取消" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
    newCancle.layer.cornerRadius = 3;
    newCancle.backgroundColor = BFColor(0x0BBC0E);
    [newCancle addTarget:self action:@selector(newCancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.clickedView addSubview:newCancle];
    
    
}

- (void)makeSureToAdd {
    [self endEditing:YES];
    if ([self.IDTextField.text isEqualToString:@""]) {
        [BFProgressHUD MBProgressFromView:self andLabelText:@"请填写推荐人id"];
    }else {
        
        BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
        if ([self.IDTextField.text isEqualToString:userInfo.ID]) {
            [BFProgressHUD MBProgressFromView:self andLabelText:@"不能添加自己"];
        }else {
            NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=p_username"];
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            parameter[@"uid"] = userInfo.ID;
            parameter[@"pid"] = self.IDTextField.text;
            parameter[@"token"] = userInfo.token;
            [BFHttpTool GET:url params:parameter success:^(id responseObject) {
                if ([responseObject[@"msg"] isEqualToString:@"推荐人不存在"]) {
                    [BFProgressHUD MBProgressFromView:self andLabelText:@"推荐人不存在"];
                }else if ([responseObject[@"msg"] isEqualToString:@"ok"]) {
                    self.blackV.hidden = YES;
                    self.clickedView.hidden = NO;
                    BFLog(@"responseObject%@,,%@",responseObject,userInfo.token);
                    BFRecommenderModel *recommenderModel = [BFRecommenderModel parse:responseObject];
                    self.nickNameLabel.text = [NSString stringWithFormat:@"昵称：%@",recommenderModel.username];
                    self.memberID.text = [NSString stringWithFormat:@"会员号：%@",recommenderModel.ID];

                }else {
                    [BFProgressHUD MBProgressFromView:self andLabelText:@"异常，请稍后再试"];
                }
                
                
            } failure:^(NSError *error) {
                BFLog(@"%@",error);
            }];

        }
        
        
        //        if (self.delegate && [self.delegate respondsToSelector:@selector(sureToAddRecommenderWithView:)]) {
//            [self.delegate sureToAddRecommenderWithView:self];
//        }

    }
    BFLog(@"确定添加");
}

- (void)cancleToAdd {
    BFLog(@"取消添加");
    [self dismissView];
}


- (void)newSureButtonclick {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=add_p_username"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"pid"] = self.IDTextField.text;
    parameter[@"token"] = userInfo.token;
    [BFHttpTool POST:url params:parameter success:^(id responseObject) {
        
        BFLog(@"responseObject%@,,%@",responseObject,userInfo.token);
        if ([responseObject[@"msg"] isEqualToString:@"添加成功"]) {
            [BFProgressHUD MBProgressFromView:self andLabelText:@"添加成功"];
            userInfo.p_username = [NSString stringWithFormat:@"%@",[self.nickNameLabel.text stringByReplacingOccurrencesOfString:@"昵称：" withString:@""]];
            [BFUserDefaluts modifyUserInfo:userInfo];
            if (self.delegate && [self.delegate respondsToSelector:@selector(hideView)]) {
                [self.delegate hideView];
            }
            [self dismissView];
        }else {
            [BFProgressHUD MBProgressFromView:self andLabelText:@"添加失败，请稍后再试"];
            [self dismissView];
        }
        
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
    
    BFLog(@"responseObject%@,,%@",self.memberID.text,self.nickNameLabel.text);
}

- (void)newCancleButtonClick {
    [self dismissView];
}


- (void)showView {
    self.blackV.hidden = NO;
    self.clickedView.hidden = YES;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    window.frame = self.frame;
}

- (void)showRecommenderView {
    self.blackV.hidden = NO;
    self.clickedView.hidden = YES;
}


- (void)dismissView {
    
    [self removeFromSuperview];
}

- (void)closeKeyboard {
    [self endEditing:YES];
}

@end
