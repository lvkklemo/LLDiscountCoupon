//
//  CardCouponCell.m
//  LLDiscountCoupon
//
//  Created by 宇航 on 17/5/3.
//  Copyright © 2017年 青岛市北区. All rights reserved.
//

#import "CardCouponCell.h"
#import "UIViewExt.h"
#import "KHLButton.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface CardCouponCell ()

@end
@implementation CardCouponCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupMainView];
        //self.backgroundColor = [UIColor lightGrayColor];
        //self.contentView.backgroundColor = [UIColor redColor];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setupMainView{
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 10)];
    topView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:topView];
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(16, topView.bottom, 100, 80)];
    leftView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:leftView];
    
    UILabel * useLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftView.width, 20)];
    useLabel.text = @"已使用";
    [leftView addSubview:useLabel];
    useLabel.font = [UIFont systemFontOfSize:13];
    useLabel.textColor = [UIColor whiteColor];
    
    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, useLabel.bottom, leftView.width, leftView.height-useLabel.height)];
    priceLabel.text = @"￥100";
    [leftView addSubview:priceLabel];
    priceLabel.font = [UIFont boldSystemFontOfSize:27];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    
    //时代卷
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftView.right, 20, 200, 30)];
    nameLabel.text = @"试戴券";
    [leftView addSubview:nameLabel];
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.textColor = [UIColor blackColor];
    
    //时间
    UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftView.right, nameLabel.bottom, 200, 30)];
    timeLabel.text = @"2017.04.22-2017.05.03";
    [leftView addSubview:timeLabel];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = [UIColor blackColor];
    
    KHLButton * zankai = [[KHLButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 60, 70, 30)];
//    zankai.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:zankai];
    [zankai setImage:[UIImage imageNamed:@"btn_back_01_n"] forState:UIControlStateNormal];
    [zankai setTitle:@"详情" forState:UIControlStateNormal];
    //zankai.imageView.contentMode = UIViewContentModeRight;
    zankai.titleLabel.font = [UIFont systemFontOfSize:14];
    [zankai setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [zankai setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [zankai addTarget:self action:@selector(zankaiAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(16, 100, 300, 20)];
    label.text = @"苹果78919293专用优惠券";
    [self.contentView addSubview:label];
    
}

- (void)zankaiAction:(UIButton*)button{
    
    self.model.open = !self.model.open;
    
    if (self.refresh) {
        
        self.refresh(self);
    }
}

#pragma mark - 类方法

+ (CGFloat)cellDefaultHeight:(CardCouponModel *)model {
    
    return 100;
}

+ (CGFloat)cellMoreHeight:(CardCouponModel *)model{
    
    return 120;
}

@end
