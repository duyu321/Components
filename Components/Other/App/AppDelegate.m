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
#import "DK3DTouchWidgetViewController.h"
#import "DKShortcut.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置根控制器
    [self setRoot];
    // 通过Shortcut.plist设置APP快捷方式
    [self setShortcut];
    // 设置友盟通用组件
    [self setUMCommon];
    // 设置友盟推送
    [self setPush:launchOptions];
    
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

- (void)setUMCommon {
    // 初始化友盟所有组件
    [UMConfigure initWithAppkey:@"5eb3a719978eea082619cd1e" channel:@"App Store"];
    // 设置打开日志
    [UMConfigure setLogEnabled:YES];
    //打开加密传输
    [UMConfigure setEncryptEnabled:YES];
    NSString* deviceID =  [UMConfigure deviceIDForIntegration];
    if ([deviceID isKindOfClass:[NSString class]]) {
        NSLog(@"服务器端成功返回deviceID");
    } else {
        NSLog(@"服务器端还没有返回deviceID");
    }
}

- (void)setPush:(NSDictionary *)launchOptions {
    // 设置自动清理推送
    [UMessage setBadgeClear:YES];
    // Push功能配置
    UMessageRegisterEntity *entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
    UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
    //UNNotificationCategoryOptionNone
    //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
    //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
    UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]  intentIdentifiers:@[]options:UNNotificationCategoryOptionCustomDismissAction];
    NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
    entity.categories=categories;

    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            
        } else {
            
        }
    }];
}

//iOS10新增：处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    } else {
        //应用处于后台时的本地推送接受
    }
}

// 获取deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    if (![deviceToken isKindOfClass:[NSData class]]) return;
    const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"deviceToken:%@",hexToken);
}

// Widget 进入
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 判断是否以Components开头
    if ([[url absoluteString] hasPrefix:@"Components"]) {
        DYNavigationController *nav = (DYNavigationController *)((TBTabBarController *)self.window.rootViewController).selectedViewController;
        // 判断host为green 并且 当前不在要跳转的控制器 再跳转
        if ([[url host] isEqualToString:@"green"] && [[nav.childViewControllers lastObject] class] != [DK3DTouchWidgetViewController class]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [nav pushViewController:[[DK3DTouchWidgetViewController alloc] init] animated:YES];
            });
        }
        
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
    DYNavigationController *nav = (DYNavigationController *)((TBTabBarController *)self.window.rootViewController).selectedViewController;
    // 判断type为add 并且 当前不在要跳转的控制器 再跳转
    if ([shortcutItem.type isEqualToString:@"shortcut.add"] && [[nav.childViewControllers lastObject] class] != [DK3DTouchAppIconViewController class]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [nav pushViewController:[[DK3DTouchAppIconViewController alloc] init] animated:YES];
        });
    }
    // 不管APP在后台还是进程被杀死，只要通过主屏快捷操作进来的，都会调用这个方法
    NSLog(@"name:%@\ntype:%@", shortcutItem.localizedTitle, shortcutItem.type);
}

@end
