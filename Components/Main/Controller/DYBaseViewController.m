//
//  DYBaseViewController.m
//  A_Big_Demo
//
//  Created by 杜宇 on 16/2/26.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYBaseViewController.h"

@interface DYBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIViewController *currentShowVC;

@end

@implementation DYBaseViewController

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)vcBackBlock:(VCBackBlockAction)block {
    self.backBlock = block;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColor(235, 235, 241, 1);
    // 状态栏(statusbar)
    CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
    // 标题栏
    CGRect NavRect = self.navigationController.navigationBar.frame;
    // tabbar
    CGRect TabbarRect = self.tabBarController.tabBar.frame;
    
    self.tabbarHeight = TabbarRect.size.height;
    self.navAndStaHeight = StatusRect.size.height + NavRect.size.height;
    // 添加侧滑切换控制器方法
//    [self setGra];
}

#pragma mark - 添加侧滑切换控制器方法
-(void)viewWillAppear:(BOOL)animated {
    
    // 设置代理
    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
    
    // 启用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器，这里我的项目是有tabbar，所以在页面切换之间设置是否显示tababr。
    if (self.navigationController.viewControllers.count == 1){
        // 将当前导航控制器置空
        self.currentShowVC = Nil;
    } else {
        // 如果不是根控制器，就设置当前导航控制器为其本身。
        self.currentShowVC = self;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        // 当前导航控制器是根视图控制器
        // the most important
        return (self.currentShowVC == self.navigationController.topViewController);
    }
    return YES;
}

- (void)hiddenAllView
{
    for (UIView *view in self.view.subviews) {
        view.hidden = YES;
    }
}

- (void)showAllView
{
    for (UIView *view in self.view.subviews) {
        view.hidden = NO;
    }
}

// 切换控制器时销毁所有http请求
- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}

@end
