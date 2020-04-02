//
//  UIImageView+QYTheme.m
//  QYTheme
//
//   Created by Joeyoung on 2020/3/21.
//  Copyright © 2020 Joeyoung. All rights reserved.
//

#import "UIImageView+QYTheme.h"
#import <objc/runtime.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UIImageView ()

/// anyImage
@property (nonatomic, strong) UIImage *anyImage;
/// anyUrl
@property (nonatomic, strong) NSURL *anyUrl;
/// placeholder
@property (nonatomic, strong) UIImage *placeholder;
/// darkImage
@property (nonatomic, strong) UIImage *darkImage;
/// darkUrl
@property (nonatomic, strong) NSURL *darkUrl;
/// darkPlaceholder
@property (nonatomic, strong) UIImage *darkPlaceholder;

@end

@implementation UIImageView (QYTheme)

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
        [self qy_changeStatus];
    }
}
/// 改变状态
- (void)qy_changeStatus {
    if (@available(iOS 13.0, *)) {
        NSInteger style = [UIApplication sharedApplication].keyWindow.traitCollection.userInterfaceStyle;
        if (style == UIUserInterfaceStyleDark) {
            if (self.darkUrl) {
                [self sd_setImageWithURL:self.darkUrl placeholderImage:self.darkPlaceholder];
                return;
            }
            if (self.darkImage) self.image = self.darkImage;
            return;
        }
        
        if (self.anyUrl) {
            [self sd_setImageWithURL:self.anyUrl placeholderImage:self.placeholder];
            return;
        }
        if (self.anyImage) self.image = self.anyImage;
    }
}
#endif

- (void)qy_setImageWithAny:(UIImage *)anyImage darkIamge:(UIImage *)darkImage {
    if (@available(iOS 13.0, *)) {
        self.anyImage = anyImage;
        self.darkImage = darkImage;
        if (!self.darkImage) self.darkImage = anyImage;
        // 根据默认状态设置图片Ï
        [self qy_changeStatus];
    } else {
        self.image = anyImage;
    }
}
- (void)qy_setImageWithURL:(NSURL *)anyUrl darkImageWithURL:(NSURL *)darkUrl placeholderImage:(UIImage *)placeholder {
    [self qy_setImageWithURL:anyUrl placeholderImage:placeholder darkImageWithURL:darkUrl darkPlaceholderImage:placeholder];
}
- (void)qy_setImageWithURL:(NSURL *)anyUrl placeholderImage:(UIImage *)placeholder darkImageWithURL:(NSURL *)darkUrl darkPlaceholderImage:(UIImage *)darkPlaceholder {
    if (@available(iOS 13.0, *)) {
        self.anyUrl = anyUrl;
        self.placeholder = placeholder;
        self.darkUrl = darkUrl;
        self.darkPlaceholder = darkPlaceholder;
        // 根据默认状态设置图片
        [self qy_changeStatus];
    } else {
        [self sd_setImageWithURL:anyUrl placeholderImage:placeholder];
    }
}

#pragma mark - Associated object
- (void)setAnyImage:(UIImage *)anyImage {
    objc_setAssociatedObject(self, @selector(anyImage), anyImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)anyImage {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAnyUrl:(NSURL *)anyUrl {
    objc_setAssociatedObject(self, @selector(anyUrl), anyUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSURL *)anyUrl {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setPlaceholder:(UIImage *)placeholder {
    objc_setAssociatedObject(self, @selector(placeholder), placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)placeholder {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setDarkImage:(UIImage *)darkImage {
    objc_setAssociatedObject(self, @selector(darkImage), darkImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)darkImage {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setDarkUrl:(NSURL *)darkUrl {
    objc_setAssociatedObject(self, @selector(darkUrl), darkUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSURL *)darkUrl {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setDarkPlaceholder:(UIImage *)darkPlaceholder {
    objc_setAssociatedObject(self, @selector(darkPlaceholder), darkPlaceholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)darkPlaceholder {
    return objc_getAssociatedObject(self, _cmd);
}
 
@end
