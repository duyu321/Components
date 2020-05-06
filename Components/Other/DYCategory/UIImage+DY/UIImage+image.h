//
//  UIImage+image.h
//  MedicalAlarmSystem
//
//  Created by 吴欧 on 2017/8/31.
//  Copyright © 2017年 吴欧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

/**
 *  根据颜色生成一张图片
 *  @param color 提供的颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 * 根据尺寸和颜色生成图片 可设置透明度
 *  @param frame 提供的尺寸
 *  @param alphe 设置的透明度
 *  @param color 提供的颜色
 */
+ (UIImage *) imageWithFrame:(CGRect)frame alphe:(CGFloat)alphe Color:(UIColor *)color;

//
/**
 NSBundle设置图片

 @param fileName 图片名
 @param type 图片类型
 @return UIImage
 */
+ (UIImage *)contentFileWithName:(NSString *)fileName Type:(NSString *)type;

+ (UIImage *)getTheLaunchImage;

@end
