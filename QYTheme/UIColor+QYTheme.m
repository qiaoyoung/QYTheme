//
//  UIColor+QYTheme.m
//  QYTheme
//
//  Created by Joeyoung on 2020/3/21.
//  Copyright © 2020 Joeyoung. All rights reserved.
//

#import "UIColor+QYTheme.h"

@implementation UIColor (QYTheme)

+ (UIColor *)qy_setColorWithAny:(UIColor *)anyColor dark:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor ?: [UIColor clearColor];
            } else {
                return anyColor ?: [UIColor clearColor];
            }
        }];
    }
    return anyColor ?: [UIColor clearColor];
}

@end
