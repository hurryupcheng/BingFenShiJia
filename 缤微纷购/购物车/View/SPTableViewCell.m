//
//  SPTableViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Height.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "ViewController.h"
#import "SPTableViewCell.h"

@interface SPTableViewCell ()

@property (nonatomic,retain)UIButton *needV;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *hetLabel;
@property (nonatomic,retain)UILabel *moneyLabel;
@property (nonatomic,retain)NSString *stock;
@property (nonatomic,retain)UIImageView *closeImg;

@end

@implementation SPTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.needV = [[UIButton alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height/2-10, 40, CGFloatX(80))];
//        self.needV.layer.cornerRadius = CGFloatY(15);
//        self.needV.layer.masksToBounds = YES;
//        self.needV.selected = self.isSelected;
//        self.needV.backgroundColor = [UIColor greenColor];
        [self.needV setImage:[UIImage imageNamed:@"gx02.png"] forState:UIControlStateNormal];
        [self.needV setImage:[UIImage imageNamed:@"gx01.png"] forState:UIControlStateSelected];
        [self.needV addTarget:self action:@selector(selectButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.needV.frame), 15, CGFloatX(80), CGFloatX(80))];
//        self.imageV.backgroundColor = [UIColor greenColor];
        self.imageV.layer.borderWidth = 0.5;
        self.imageV.layer.borderColor = [UIColor grayColor].CGColor;
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame)+5, 10, kScreenWidth-self.needV.width-self.imageV.width-50, 0)];
        self.titleLabel.font = [UIFont systemFontOfSize:CGFloatY(15)];
        self.titleLabel.numberOfLines = 2;
        
        self.hetLabel = [[UILabel alloc]init];
        self.hetLabel.textColor = [UIColor grayColor];
        self.hetLabel.font = [UIFont systemFontOfSize:CGFloatX(14)];
//        self.hetLabel.backgroundColor = [UIColor greenColor];
        
        self.moneyLabel = [[UILabel alloc]init];
        self.moneyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(15)];
//        self.moneyLabel.backgroundColor = [UIColor orangeColor];
        self.moneyLabel.textColor = [UIColor orangeColor];
        //self.moneyLabel.font = [UIFont systemFontOfSize:CGFloatX(18)];
        
        self.close = [[UIButton alloc]init];
        self.closeImg = [[UIImageView alloc]init];
        self.closeImg.image = [UIImage imageNamed:@"guanbis.png"];
        [self.close addSubview:self.closeImg];
//        [self.close setBackgroundImage:[UIImage imageNamed:@"guanbis.png"] forState:UIControlStateNormal];
        
        self.add = [[AddShopping alloc]init];
//        self.add.textF.returnKeyType = UIReturnKeyDone;
//        self.add.textF.delegate = self;
//        self.add.textF.userInteractionEnabled = NO;
//        self.add.backgroundColor = [UIColor yellowColor];
        
        [self.add.maxBut addTarget:self action:@selector(maxButton) forControlEvents:UIControlEventTouchUpInside];
        [self.add.minBut addTarget:self action:@selector(minButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.needV];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.hetLabel];
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.close];
        [self.contentView addSubview:self.add];

    }
    return self;
}

// 选中点击事件
- (void)selectButClick:(UIButton *)button{
    button.selected = !button.selected;
    if (self.selBlock) {
        self.selBlock(button.selected);
    }
}
// 添加
- (void)maxButton{
    self.add.minBut.enabled = YES;
    
    if ([self.add.textF.text integerValue] >= [self.stock integerValue]) {
        [BFProgressHUD MBProgressOnlyWithLabelText:@"商品数量超出库存"];
        self.add.maxBut.enabled = NO;
    }else{
        if (self.numAddBlock) {
            self.numAddBlock();
        }
    }

}

// 减少
- (void)minButton{
    self.add.maxBut.enabled = YES;
    if (self.numCutBlock) {
        self.numCutBlock();
    }
    if ([self.add.textF.text integerValue] < 1) {
        [BFProgressHUD MBProgressOnlyWithLabelText:@"商品数量超出库存"];
        self.add.textF.text = @"1";
        self.add.minBut.enabled = NO;
        
    }
}

- (void)reloadDataWith:(BFStorage *)model{
    self.stock = model.stock;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
    self.titleLabel.text = model.title;
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame)+10, 10, kScreenWidth-self.needV.width-self.imageV.width-30, [Height heightString:model.title font:CGFloatY(17)]);
    [self.titleLabel sizeToFit];
    
    self.hetLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame)+5, CGRectGetMaxY(self.titleLabel.frame), kScreenWidth-self.needV.width-self.imageV.width-50, CGFloatY(25));
   
    self.moneyLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame)+5, CGRectGetMaxY(self.hetLabel.frame)+5, kScreenWidth-self.needV.width-self.imageV.width-100, CGFloatY(30));
    
    //self.moneyLabel.backgroundColor = BFColor(0x0000ff);

    self.close.frame = CGRectMake(CGRectGetMaxX(self.frame)-CGFloatX(45), 5, CGFloatX(50), CGFloatX(50));
    self.closeImg.frame = CGRectMake(CGFloatX(20), 5, CGFloatX(20), CGFloatX(20));
    //self.close.backgroundColor = [UIColor greenColor];
    
    self.add.frame = CGRectMake(CGRectGetMaxX(self.moneyLabel.frame), CGRectGetMaxY(self.hetLabel.frame), kScreenWidth, CGFloatY(35));
    //self.add.backgroundColor = [UIColor redColor];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.price doubleValue]];
    if (model.price) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.moneyLabel.text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(20)] range:NSMakeRange(2,self.moneyLabel.text.length-2)];
        self.moneyLabel.attributedText = attributedString;
    }

    self.hetLabel.text = [NSString stringWithFormat:@"%@  %@",model.color,model.choose];
    self.add.textF.text = [NSString stringWithFormat:@"%ld",(long)model.numbers];
    self.needV.selected = self.isSelected;
    
    
    
    self.cellHeight = CGRectGetMaxY(self.add.frame)+10;
    self.imageV.height = self.cellHeight - 30;
    BFLog(@"--------%ld,,,,,%f", self.cellHeight,self.add.y);
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.sumBlock) {
        self.sumBlock();
    }
    if ([self.add.textF.text integerValue] < 1) {
        [BFProgressHUD MBProgressOnlyWithLabelText:@"商品数量超出库存"];
        self.add.textF.text = @"1";
        self.add.minBut.enabled = NO;
        
    }else if ([self.add.textF.text integerValue] > [self.stock integerValue]){
        [BFProgressHUD MBProgressOnlyWithLabelText:@"商品数量超出库存"];
        self.add.textF.text = self.stock;
    }
    
    [textField resignFirstResponder];
    return YES;
}
// 判断输入的是否是数字
- (BOOL)validateNumberByRegExp:(NSString *)string {
    BOOL isValid = YES;
    NSUInteger len = string.length;
    
    if (len > 0) {
        NSString *numberRegex = @"^[0-9]*$";
        NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
        isValid = [numberPredicate evaluateWithObject:string];
    }
    return isValid;
}




#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return [self validateNumberByRegExp:string];
}



@end
