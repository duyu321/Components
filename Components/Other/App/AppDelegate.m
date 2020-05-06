//
//  AppDelegate.m
//  Function2020
//
//  Created by Docker on 2020/4/22.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "AppDelegate.h"
#import "TBTabBarController.h"
#import "DYNavigationController.h"
#import "DK3DTouchAppIconViewController.h"
#import "DKShortcut.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置根控制器
    [self setRoot];
    // 通过shortcut.plist设置APP快捷方式
    [self setShortcut];
    
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (void)setRoot {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[TBTabBarController alloc] init];
}

- (void)setShortcut {
    //获取文件的完整路径
    NSString *edPatch = [kDocuments stringByAppendingPathComponent:@"Shortcut.plist"]; //没有会自动创建
    
    NSArray<DKShortcut *> *shortcutArray = [DKShortcut mj_objectArrayWithKeyValuesArray:[NSMutableArray arrayWithContentsOfFile:edPatch]];
    NSMutableArray *arrShortcutItem = [NSMutableArray array];
    for (DKShortcut *cut in shortcutArray) {
        UIApplicationShortcutItem *shoreItem = [[UIApplicationShortcutItem alloc] initWithType:cut.methods localizedTitle:cut.title localizedSubtitle:cut.subtitle icon:[UIApplicationShortcutIcon iconWithTemplateImageName:cut.icon] userInfo:nil];
        [arrShortcutItem addObject:shoreItem];
    }
    UIApplicationShortcutItem *shoreItem = [[UIApplicationShortcutItem alloc] initWithType:@"shortcut.add" localizedTitle:@"添加更多快捷方式" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"photo_delete"] userInfo:nil];
    [arrShortcutItem addObject:shoreItem];
    [UIApplication sharedApplication].shortcutItems = arrShortcutItem;
}

// Widget 进入
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([[url absoluteString] hasPrefix:@"Components"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"你点击了%@按钮",[url host]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // Do something
        }];
        [alert addAction:action];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
    return  YES;
}

// Shortcut 进入
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DYNavigationController *nav = (DYNavigationController *)((TBTabBarController *)self.window.rootViewController).selectedViewController;
        [nav pushViewController:[[DK3DTouchAppIconViewController alloc] init] animated:YES];
    });
    
    // 不管APP在后台还是进程被杀死，只要通过主屏快捷操作进来的，都会调用这个方法
    NSLog(@"name:%@\ntype:%@", shortcutItem.localizedTitle, shortcutItem.type);
}

@end
