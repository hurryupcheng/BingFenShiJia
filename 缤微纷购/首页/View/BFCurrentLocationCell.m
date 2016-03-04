//
//  BFCurrentLocationCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/3.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
/**button宽度*/
#define buttonWidth    ((ScreenWidth-50)/4)
/**button高度*/
#define buttonHeight   BF_ScaleHeight(25)
#import "BFCurrentLocationCell.h"


@interface BFCurrentLocationCell ()<CLLocationManagerDelegate>
/**定位管理*/
@property (nonatomic, strong) CLLocationManager * manager;
/**城市定位*/
@property (nonatomic, strong) UIButton *currentCityButtuon;
/**城市定位*/
@property (nonatomic, strong) UIButton *openPositionButton;
@end

@implementation BFCurrentLocationCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"currentCity";
    BFCurrentLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFCurrentLocationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        //cell.userInteractionEnabled = NO;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *currentCityButtuon = [UIButton buttonWithType:0];
        self.currentCityButtuon = currentCityButtuon;
        currentCityButtuon.frame = CGRectMake(10, (44-buttonHeight)/2, buttonWidth, buttonHeight);
        
        currentCityButtuon.layer.borderWidth = 1;
        currentCityButtuon.layer.borderColor = BFColor(0x202F6F).CGColor;
        currentCityButtuon.layer.cornerRadius = 2;
        currentCityButtuon.layer.masksToBounds = YES;
        [currentCityButtuon setTitleColor:BFColor(0x202F6F) forState:UIControlStateNormal];
        currentCityButtuon.titleLabel.font =[UIFont systemFontOfSize:BF_ScaleFont(10)];
        [currentCityButtuon addTarget:self action:@selector(changeCity:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:currentCityButtuon];
        
        UIButton *openPositionButton = [UIButton buttonWithType:0];
        self.openPositionButton = openPositionButton;
        openPositionButton.frame = CGRectMake(0, 0, BF_ScaleWidth(188), 44);
        [openPositionButton setTitleColor:BFColor(0x000000) forState:UIControlStateNormal];
        openPositionButton.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        [openPositionButton setTitle:@"位置服务未经您允许，点击开启" forState:UIControlStateNormal];
        [openPositionButton addTarget:self action:@selector(goToSetting:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:openPositionButton];
        //CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
//        if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
//            self.currentCityButtuon.hidden = YES;
//            //BFLog(@"位置服务未经您允许，点击开启");
//        }else {
//            self.openPositionButton.hidden = YES;
//            //BFLog(@"已经定位");
//        }
        
    }
    return self;
}

- (void)setStatus:(CLAuthorizationStatus)status {
    _status = status;
    //BFLog(@"cell中%d",status);
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        
        self.currentCityButtuon.hidden = YES;
        self.openPositionButton.hidden = NO;
        //BFLog(@"位置服务未经您允许，点击开启");
    }else {
        NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
        BFLog(@"%@,,,%@",city,[[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"]);
        [self.currentCityButtuon setTitle:city forState:UIControlStateNormal];
        self.openPositionButton.hidden = YES;
        self.currentCityButtuon.hidden = NO;
        
        //BFLog(@"已经定位");
    }

}

/**当前城市按钮选择*/
- (void)changeCity:(UIButton *)sender {
    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(goBackToHome)]) {
        [self.cityDelegate goBackToHome];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"returncurrentCity" object:self userInfo:@{@"city":sender.titleLabel.text}];
}


/**设置定位按钮点击方法*/
- (void)goToSetting:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToSettingInterface)]) {
        [self.delegate goToSettingInterface];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
