//
//  UIColor+QYTheme.h
//  QYTheme
//
//  Created by Joeyoung on 2020/3/21.
//  Copyright © 2020 Joeyoung. All rights reserved.
//
 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (QYTheme)

/// 获取动态颜色
/// @param anyColor 默认颜色
/// @param darkColor 暗黑颜色
+ (UIColor *)qy_setColorWithAny:(UIColor *)anyColor dark:(UIColor *)darkColor;
 
@end

NS_ASSUME_NONNULL_END
