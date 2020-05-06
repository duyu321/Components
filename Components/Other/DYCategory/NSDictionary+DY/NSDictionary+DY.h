//
//  NSDictionary+DY.h
//  A_Big_Demo
//
//  Created by 杜宇 on 16/3/1.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DY)

/**
 *  字符串转字典
 *
 *  @param jsonString json格式的字符串
 *
 *  @return 通过字符串转换后的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 字典转字符串

 @param dic 字典
 @return 通过字典转换后的字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


@end
