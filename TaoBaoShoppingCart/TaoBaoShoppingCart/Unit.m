//
//  Unit.m
//  MeiJin
//
//  Created by liqingchun on 15/12/21.
//  Copyright © 2015年 easaa. All rights reserved.
//

#import "Unit.h"

@implementation Unit

+ (CGFloat)heightForLabelWithContent:(NSString *)content withWidth:(CGFloat)width withFontSize:(CGFloat)fontSize {
    return  [content boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil].size.height;
}

+ (CGFloat)widthForLabelWithContent:(NSString *)content withHeight:(CGFloat)height withFontSize:(CGFloat)fontSize {
    return  [content boundingRectWithSize:CGSizeMake(10000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil].size.width;
}

#pragma mark --计算Lable高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    if (string && [string length] > 0) {
        CGSize rtSize;
        if(iOS7)
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
            
            rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            return ceil(rtSize.height) + 0.5;
        }
        else
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            //FIXME: kkkk
            rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
            
            return rtSize.height;
        }

    } else {
        return 0;
    }
}


#pragma mark -获取当前页面控制器
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (NSMutableAttributedString *)changeString:(NSString *)string From:(NSInteger)from changeLength:(NSInteger)length WithFontNumber:(NSInteger)fontNum WithTextColor:(UIColor *)color {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    //设置颜色
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, length)]; // 0为起始位置 length是从起始位置开始 设置指定颜色的长度
    
    //设置尺寸
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontNum] range:NSMakeRange(from, length)]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度
    
    //这段代码必须要写 否则没效果
    
    return attributedString;

}

+(NSString *)changePrice:(CGFloat)price {
    NSInteger var = price * 100;
    
    if (var%100 > 0) {
        if (var%10 > 0) {
            return [NSString stringWithFormat:@"%.2f",price];
        } else {
            return [NSString stringWithFormat:@"%.1f",price];
        }
    } else {
        return [NSString stringWithFormat:@"%.f",price];
    }
    
    return [NSString stringWithFormat:@"%.2f",price];
}


@end
