//
//  Unit.h
//  MeiJin
//
//  Created by liqingchun on 15/12/21.
//  Copyright © 2015年 easaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicDefine.h"

@interface Unit : NSObject

+ (CGFloat)heightForLabelWithContent:(NSString *)content withWidth:(CGFloat)width withFontSize:(CGFloat)fontSize;

+ (CGFloat)widthForLabelWithContent:(NSString *)content withHeight:(CGFloat)height withFontSize:(CGFloat)fontSize;


+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  获取当前页面的viewcontroller
 *
 *  @return UIViewController
 */
+ (UIViewController *)getCurrentVC;

+ (NSMutableAttributedString *)changeString:(NSString *)string From:(NSInteger)from changeLength:(NSInteger)length WithFontNumber:(NSInteger)fontNum WithTextColor:(UIColor *)color;

+(NSString *)changePrice:(CGFloat)price;


@end
