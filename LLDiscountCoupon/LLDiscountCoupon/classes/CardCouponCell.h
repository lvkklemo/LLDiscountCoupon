//
//  CardCouponCell.h
//  LLDiscountCoupon
//
//  Created by 宇航 on 17/5/3.
//  Copyright © 2017年 青岛市北区. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardCouponModel.h"

// 这里多传一个model，如果有id可以判断indexPath，因为小心分页加载的问题
typedef void(^Refresh)(UITableViewCell *cell);

@interface CardCouponCell : UITableViewCell

@property (nonatomic, strong) CardCouponModel *model;



@property (nonatomic, copy) Refresh refresh;


///未展开时的高度
+ (CGFloat)cellDefaultHeight:(CardCouponModel *)model;
///展开后的高度
+ (CGFloat)cellMoreHeight:(CardCouponModel *)model;

@end

