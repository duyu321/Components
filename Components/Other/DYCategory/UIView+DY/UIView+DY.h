//
//  UIView+DY.h
//  DYMainViewController
//
//  Created by 杜宇 on 15/8/6.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DY)

@property (nonatomic, assign) CGSize dk_size;
@property (nonatomic, assign) CGFloat dk_width;
@property (nonatomic, assign) CGFloat dk_height;
@property (nonatomic, assign) CGFloat dk_x;
@property (nonatomic, assign) CGFloat dk_y;

@property (nonatomic, assign, readonly, getter=getMinY) CGFloat dk_minY;

@property (nonatomic, assign, readonly, getter=getMidY) CGFloat dk_midY;

@property (nonatomic, assign, readonly, getter=getMaxY) CGFloat dk_maxY;

@property (nonatomic, assign, readonly, getter=getMinX) CGFloat dk_minX;

@property (nonatomic, assign, readonly, getter=getMidX) CGFloat dk_midX;

@property (nonatomic, assign, readonly, getter=getMaxX) CGFloat dk_maxX;

@end
