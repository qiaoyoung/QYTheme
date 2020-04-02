//
//  UIWindow+QYTheme.m
//  QYTheme
//
//  Created by Joeyoung on 2020/3/21.
//  Copyright © 2020 Joeyoung. All rights reserved.
//

#import "UIWindow+QYTheme.h"
#import <objc/runtime.h>

NSNotificationName const QYUserInterfaceStyleWillChangeNotification = @"QYUserInterfaceStyleWillChangeNotification";

@implementation UIWindow (QYTheme)
 
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class aClass = self.class;
        SEL originalSel = @selector(traitCollectionDidChange:);
        SEL swizzleSel = @selector(qy_traitCollectionDidChange:);
        Method originalMethod = class_getInstanceMethod(aClass, originalSel);
        Method swizzleMethod = class_getInstanceMethod(aClass, swizzleSel);
        BOOL didAddMethod = class_addMethod(aClass,
                                            originalSel,
                                            method_getImplementation(swizzleMethod),
                                            method_getTypeEncoding(swizzleMethod));
        if (didAddMethod) {
            class_replaceMethod(aClass,
                                swizzleSel,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzleMethod);
        }
    });
}
/// hook
- (void)qy_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self qy_traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        // 防止程序进入后台时多次触发通知（实测程序进入后台仍会多次改变style，但是系统并没有调用界面相关刷新方法）
        if (UIApplication.sharedApplication.applicationState == UIApplicationStateBackground) return;
        // 防止在同一状态下多次触发通知
        static UIUserInterfaceStyle window_normalStyle;
        if (window_normalStyle != previousTraitCollection.userInterfaceStyle) {
            window_normalStyle = previousTraitCollection.userInterfaceStyle;
            [[NSNotificationCenter defaultCenter] postNotificationName:QYUserInterfaceStyleWillChangeNotification object:[UITraitCollection currentTraitCollection]];
        }
    }
}

@end
#endif
