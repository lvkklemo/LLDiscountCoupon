//
//  ViewController.h
//  LLDiscountCoupon
//
//  Created by 宇航 on 17/5/3.
//  Copyright © 2017年 青岛市北区. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    //全部
    UserCouponTypeAll = 0,
    //可使用
    UserCouponTypeAvailable,
    //已使用
    UserCouponTypeUnavailable,
    //已过期
    UserCouponTypeOutOfDate,
} UserOrderType;

@interface ViewController : UIViewController


@end

