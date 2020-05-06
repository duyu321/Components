//
//  UIView+DY.h
//  DYMainViewController
//
//  Created by 杜宇 on 15/8/6.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

#import "UIView+DY.h"

@implementation UIView (DY)

- (void)setDk_size:(CGSize)dk_size {
    CGRect frame = self.frame;
    frame.size = dk_size;
    self.frame = frame;
}

- (CGSize)dk_size {
    return self.frame.size;
}

- (void)setDk_width:(CGFloat)dk_width {
    CGRect frame = self.frame;
    frame.size.width = dk_width;
    self.frame = frame;
}

- (CGFloat)dk_width {
    return self.frame.size.width;
}

- (void)setDk_height:(CGFloat)dk_height {
    CGRect frame = self.frame;
    frame.size.height = dk_height;
    self.frame = frame;
}

- (CGFloat)dk_height {
    return self.frame.size.height;
}

- (void)setDk_x:(CGFloat)dk_x {
    CGRect frame = self.frame;
    frame.origin.x = dk_x;
    self.frame = frame;
}

- (CGFloat)dk_x {
    return self.frame.origin.x;
}

- (void)setDk_y:(CGFloat)dk_y {
    CGRect frame = self.frame;
    frame.origin.y = dk_y;
    self.frame = frame;
}

- (CGFloat)dk_y {
    return self.frame.origin.y;
}

- (CGFloat)getMinY {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)getMidY {
    return CGRectGetMidY(self.frame);
}

- (CGFloat)getMaxY {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)getMinX {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)getMidX {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)getMaxX {
    return CGRectGetMaxX(self.frame);
}

@end
