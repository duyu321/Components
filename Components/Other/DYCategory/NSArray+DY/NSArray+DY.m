//
//  NSArray+Extension.m
//  testtools
//
//  Created by 杜宇 on 16/3/29.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "NSArray+DY.h"
#import <objc/runtime.h>

@implementation NSArray (DY)

// 返回当前类的所有属性
+ (instancetype)getPropertyList:(Class)cls{
    // 获取当前类的所有属性
    unsigned int count;
    // 记录属性个数
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    return mArray.copy;
}

+ (instancetype)getIvarList:(Class)cls
{
    // 获取当前类的所有属性
    unsigned int count;
    // 记录属性个数
    Ivar *ivars = class_copyIvarList(cls, &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        Ivar ivar = ivars[i];
        // 获取属性的名称 C语言字符串
        const char *cName = ivar_getName(ivar);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    return mArray.copy;
}

+ (instancetype)getMethodList:(Class)cls
{
    // 获取当前类的所有属性
    unsigned int count;
    // 记录属性个数
    Method *methods = class_copyMethodList(cls, &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        Method method = methods[i];
        SEL selector = method_getName(method);
        // 获取属性的名称 C语言字符串
        const char *cName = sel_getName(selector);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    return mArray.copy;
}

@end
