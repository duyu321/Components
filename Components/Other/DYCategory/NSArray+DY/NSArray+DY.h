//
//  NSArray+Extension.h
//  testtools
//
//  Created by 杜宇 on 16/3/29.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

/**
 *  返回当前类的所有Propert属性
 *
 *  @param cls 类
 *
 *  @return 类的所有Propert属性
 */
+ (instancetype)getPropertyList:(Class)cls;

/**
 *  返回当前类的所有属性
 *
 *  @param cls 类
 *
 *  @return 类的所有属性
 */
+ (instancetype)getIvarList:(Class)cls;


/**
 *  返回当前类的所有方法
 *
 *  @param cls 类
 *
 *  @return 类的所有方法
 */
+ (instancetype)getMethodList:(Class)cls;

@end
