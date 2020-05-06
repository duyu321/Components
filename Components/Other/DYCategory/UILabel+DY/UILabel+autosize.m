//
//  UILabel+autosize.m
//  Qsend
//
//  Created by l.h on 14-6-17.
//  Copyright (c) 2014年 WeiXingApp. All rights reserved.
//

#import "UILabel+autosize.h"
#import <CoreText/CoreText.h>

@implementation UILabel (autosize)


#pragma mark - UILabel + autosize
- (void)autoWidth
{
    CGRect frame = self.frame;//这个frame是初设的，没关系，后面还会重新设置其size。
//    CGSize maxSize = CGSizeMake(320, 9999);
    CGSize  expectedSize;
   #if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
       
        NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                      NSParagraphStyleAttributeName : paragraphStyle};
    
        expectedSize = [self.text sizeWithAttributes:attributes];
        
   #else
        expectedSize = [self.text sizeWithFont:self.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    #endif
    frame.size.width = expectedSize.width;
    [self setFrame:frame];
}


- (void)autoHeight {
    CGRect frame = self.frame;
    CGSize maxSize = CGSizeMake(frame.size.width, 9999);
    
    #if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
        //计算大小
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        UIFont *font = self.font;
        NSDictionary * attributes = @{NSFontAttributeName : font,
                                      NSParagraphStyleAttributeName : paragraphStyle};
        
        CGSize  expectedSize = [self.text boundingRectWithSize:maxSize
                                              options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil].size;
        frame.size.height = expectedSize.height;
        
    #else
        CGSize expectedSize = [self.text sizeWithFont:self.font constrainedToSize:maxSize lineBreakMode:self.lineBreakMode];
   
        frame.size.height = expectedSize.height;
 #endif
    [self setFrame:frame];
    
}

- (void)adjustFontWithMaxSize:(CGSize)maxSize {
    CGSize stringRect;
    if (CGSizeEqualToSize(maxSize, CGSizeZero)) {
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
        stringRect = [self.text boundingRectWithSize:self.frame.size options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.font} context:NULL].size;
#else
        stringRect = [self.text sizeWithFont:self.font
                           constrainedToSize:self.frame.size
                               lineBreakMode:NSLineBreakByWordWrapping];
#endif
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
        stringRect = [self.text boundingRectWithSize:maxSize options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.font} context:NULL].size;
#else
        stringRect = [self.text sizeWithFont:self.font
                           constrainedToSize:maxSize
                               lineBreakMode:NSLineBreakByWordWrapping];
#endif
    }
    CGRect frame = self.frame;
    frame.size.width = stringRect.width;
    if (stringRect.height > frame.size.height) {
        frame.size.height = stringRect.height;
    }
    self.frame = frame;
    
    NSInteger lines = (int)stringRect.height / self.font.xHeight;
    self.numberOfLines = lines;
}

- (void)alignTop
{
    // 对应字号的字体一行显示所占宽高
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    // 多行所占 height*line
    double height = fontSize.height*self.numberOfLines;
    // 显示范围实际宽度
    double width = self.frame.size.width;
    // 对应字号的内容实际所占范围
    CGSize stringSize = [self.text boundingRectWithSize:CGSizeMake(width, height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.font} context:nil].size;
    // 剩余空行
    NSInteger line = (height - stringSize.height) / fontSize.height;
    // 用回车补齐
    for (int i = 0; i < line; i++) {
        
        self.text = [self.text stringByAppendingString:@"\n "];
    }
}
- (void)alignBottom
{
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    double height = fontSize.height*self.numberOfLines;
    double width = self.frame.size.width;
    CGSize stringSize = [self.text boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    NSInteger line = (height - stringSize.height) / fontSize.height;
    // 前面补齐换行符
    for (int i = 0; i < line; i++) {
        self.text = [NSString stringWithFormat:@" \n%@", self.text];
    }
}

- (void)topLabel {
    
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    //计算大小
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font};
    CGSize  size = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attributes
                                                   context:nil].size;
#else
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    
#endif

    CGAffineTransform transform = self.transform;
    self.transform = CGAffineTransformIdentity;
    CGRect frame = self.frame;
    frame.size.height = size.height;
    self.frame = frame;
    self.transform = transform;
}

- (void)changeAlignmentRightAndLeft {
    
//    NSLog(@"size  %@",self);
    
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                              options:
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading |
                       NSStringDrawingTruncatesLastVisibleLine
                                           attributes:@{NSFontAttributeName:self.font}
                                              context:nil].size;
    CGFloat margin = (self.frame.size.width - textSize.width) / (self.text.length - 1);
    NSNumber * number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *arrtributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [arrtributedString addAttribute:(id)kCTKernAttributeName
                              value:number
                              range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = arrtributedString;
}

@end
