//
//  UILabel+autosize.h
//  Qsend
//
//  Created by l.h on 14-6-17.
//  Copyright (c) 2014年 WeiXingApp. All rights reserved.
//  https://github.com/cleexiang/UILabel-Additions

#import <UIKit/UIKit.h>

@interface UILabel (autosize)

- (void)autoWidth;
- (void)autoHeight;

- (void)changeAlignmentRightAndLeft;

- (void)alignTop;
- (void)alignBottom;
- (void)adjustFontWithMaxSize:(CGSize)maxSize;

- (void)topLabel;
@end



/*
 
 调用方法：
 UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,20,20)];
 [label adjustFontWithMaxSize:CGSizeMake(label.width, MAXFLOAT)];
 注意 需在设置label的text属性之后调用adjustFontWithMaxSize方法。
 
 */
