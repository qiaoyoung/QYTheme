//
//  UIImageView+QYTheme.h
//  QYTheme
//
//   Created by Joeyoung on 2020/3/21.
//  Copyright © 2020 Joeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface UIImageView (QYTheme)

/// 设置图片 [处理本地图片]
/// @param anyImage 默认图片
/// @param darkImage 暗黑图片
- (void)qy_setImageWithAny:(UIImage *)anyImage darkIamge:(UIImage *)darkImage;

/// 设置图片 [处理网络图片]
/// @param anyUrl 默认url
/// @param darkUrl 暗黑图片url
/// @param placeholder 通用占位图
- (void)qy_setImageWithURL:(NSURL *)anyUrl darkImageWithURL:(NSURL *)darkUrl placeholderImage:(UIImage *)placeholder;

/// 设置图片 [处理网络图片]
/// @param anyUrl 默认url
/// @param placeholder 默认占位图
/// @param darkUrl 暗黑图片url
/// @param darkPlaceholder 暗黑占位图
- (void)qy_setImageWithURL:(NSURL *)anyUrl placeholderImage:(UIImage *)placeholder darkImageWithURL:(NSURL *)darkUrl darkPlaceholderImage:(UIImage *)darkPlaceholder;

@end
 
