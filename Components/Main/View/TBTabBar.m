//
//  TBTabBar.m
//  TabbarBeyondClick
//
//  Created by 卢家浩 on 2017/4/17.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBTabBar.h"

@interface TBTabBar ()

/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn ;

@end

@implementation TBTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 其他位置按钮
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0 , j = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.dk_width = self.dk_width / 5.0;
            view.dk_x = self.dk_width * j / 5.0;
            
            j++;
        }
    }
    
}

@end
