//
//  BasicDefine.h
//  TaoBaoShoppingCart
//
//  Created by qhzc-iMac-02 on 2017/8/29.
//  Copyright © 2017年 Yxl. All rights reserved.
//

#ifndef BasicDefine_h
#define BasicDefine_h

#import <UIKit/UIKit.h>
#import "Unit.h"
#import "SVProgressHUD.h"

#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define iOS7            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

// 屏幕
#define SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH (SCREEN_BOUNDS.size.width)
#define SCREEN_HEIGHT (SCREEN_BOUNDS.size.height)
#define SCREEN_SCALE ([[UIScreen mainScreen] scale])
#define SINGLE_LINE_ONE ([[UIScreen mainScreen] scale]/[[UIScreen mainScreen] scale])

#define LEFT_X(a)               CGRectGetMinX(a.frame)         //控件左边面的X坐标
#define RIGHT_X(a)              CGRectGetMaxX(a.frame)         //控件右面的X坐标
#define TOP_Y(a)                CGRectGetMinY(a.frame)         //控件上面的Y坐标
#define BOTTOM_Y(a)             CGRectGetMaxY(a.frame)         //控件下面的Y坐标
#define HEIGH(a)                CGRectGetHeight(a.frame)       //控件的高度
#define WIDTH(a)                CGRectGetWidth(a.frame)        //控件的宽度

// 字体大小
#define kTextFont_20   ([UIFont systemFontOfSize:20.0f])
#define kTextFont_18   ([UIFont systemFontOfSize:18.0f])
#define kTextFont_17   ([UIFont systemFontOfSize:17.0f])
#define kTextFont_16   ([UIFont systemFontOfSize:16.0f])
#define kTextFont_15   ([UIFont systemFontOfSize:15.0f])
#define kTextFont_14   ([UIFont systemFontOfSize:14.0f])
#define kTextFont_13   ([UIFont systemFontOfSize:13.0f])
#define kTextFont_12   ([UIFont systemFontOfSize:12.0f])
#define kTextFont_11   ([UIFont systemFontOfSize:11.0f])
#define kTextFont_10   ([UIFont systemFontOfSize:10.0f])

#endif /* BasicDefine_h */
