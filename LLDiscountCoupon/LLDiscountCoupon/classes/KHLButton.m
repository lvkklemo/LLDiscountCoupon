//
//  KHLButton.m
//  Kauri
//
//  Created by 宇航 on 16/12/15.
//  Copyright © 2016年 Nathan. All rights reserved.
//

#import "KHLButton.h"
#import "UIViewExt.h"
#import "UIView+Extension.h"

@implementation KHLButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    //先调整titleLabel的x为0
    
    self.titleLabel.x = 0;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+4 , self.height/2-10, 20, 20);
    // self.width = self.titleLabel.width + self.imageView.width + MARGIN;
    // self.centerX = kScreenWidth * 0.5;
}


- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    //[self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    //[self sizeToFit];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
