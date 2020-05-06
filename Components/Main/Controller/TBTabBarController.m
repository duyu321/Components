//
//  TBTabBarController.m
//  TabbarBeyondClick
//
//  Created by 卢家浩 on 2017/4/17.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBTabBarController.h"
#import "DYMainViewController.h"
#import "DYNavigationController.h"
#import "DYNavigationController.h"
#import "TBTabBar.h"

@interface TBTabBarController ()

@end

@implementation TBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [UITabBar appearance].translucent = NO;

    // 初始化所有控制器
    [self setUpChildVC];
    
    // 创建tabbar中间的tabbarItem
//    [self setUpMidelTabbarItem];
    
}

#pragma mark -创建tabbar中间的tabbarItem 

//- (void)setUpMidelTabbarItem {
//
//    TBTabBar *tabBar = [[TBTabBar alloc] init];
//    [self setValue:tabBar forKey:@"tabBar"];
//}

#pragma mark -初始化所有控制器 

- (void)setUpChildVC {
    DYMainViewController *main = [[DYMainViewController alloc] init];
    main.tabBarItem.badgeValue = @"99+";
    [self setChildVC:main title:@"首页" image:@"tabBar_dynamic_icon" selectedImage:@"tabBar_dynamic_icon_click"];
    
    [self setChildVC:[[DYMainViewController alloc] init] title:@"消息" image:@"tabBar_information_icon" selectedImage:@"tabBar_information_icon_click"];
        
    [self setChildVC:[[DYMainViewController alloc] init] title:@"工作" image:@"tabBar_wroking_icon" selectedImage:@"tabBar_wroking_icon_click"];
        
    [self setChildVC:[[DYMainViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_icon_click"];
}

- (void) setChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage {
    
    // 普通状态文字
    childVC.tabBarItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    // 高亮状态文字
    childVC.tabBarItem.title = title;
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict1[NSForegroundColorAttributeName] = KColor(19, 112, 227, 1);
    dict1[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:dict1 forState:UIControlStateSelected];
    
    childVC.title = title;
    
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    DYNavigationController *nav = [[DYNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"item name = %@", item.title);
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
}

- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.9];
    pulse.toValue= [NSNumber numberWithFloat:1.1];
    UIView *tabBarButton = tabbarbuttonArray[index];
    [[tabBarButton layer] addAnimation:pulse forKey:nil]; 
}

@end
