//
//  DKNotifactionViewController.m
//  Components
//
//  Created by Docker on 2020/5/15.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DKNotifactionViewController.h"

@interface DKNotifactionViewController ()

@end

@implementation DKNotifactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)sendNotifaction {
    // 通知中心
    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    // 通知内容
    UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc]init];
    content.title = @"通知标题";
    content.subtitle = @"通知子标题";
    content.body = @"通知主体内容";
    // 默认铃声
    content.sound = [UNNotificationSound defaultSound];
    // 自定义铃声
    content.sound = [UNNotificationSound soundNamed:@"Define_Sound"];
    // 角标
    content.badge = @1;
    
    // 设置多长时间之后发送
    NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:5] timeIntervalSinceNow];
    UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
    
    // id：便于以后移除、更新 指定通知
    NSString * noticeId = @"noticeId";
    // 通知请求
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:noticeId content:content trigger:trigger];
    // 添加通知请求
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"本地推送成功");
        }
    }];
}

- (IBAction)removeNotifaction {
    [self removeNoticeWithNoticeId:@"noticeId"];
}

- (void)removeNoticeWithNoticeId:(NSString *)noticeID {
    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    // 判断noticeID是否存在
    [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
    
        for (UNNotificationRequest * request in requests) {
            if([noticeID isEqualToString:request.identifier]){
                [center removePendingNotificationRequestsWithIdentifiers:@[noticeID]];
            }
        }
        
    }];
}

//1.应用场景
//可以在指定的时间点推送；
//可以自定义的通知样式；
//不需要依赖APNS（苹果推送服务器）；
//不需要创建证书；

//2.注册推送
//iOS10 以上需要导入头文件 <UserNotifications/UserNotifications.h>
//if (@available(iOS 10.0,*)) {
//    // iOS10 及以上
//    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
//    [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (granted) {
//            // 注册成功
//        }else{
//            // 注册失败
//        }
//    }];
//}else{
//    // iOS8 及以上
//    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
//
//    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
//}

//3.发送通知
//- (void)sendNotificationMessage{
//    if (@available(iOS 10.0,*)) {
//        // 通知中心
//        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
//        // 通知内容
//        UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc]init];
//        content.title = @"通知标题";
//        content.subtitle = @"通知子标题";
//        content.body = @"通知主体内容";
//        // 默认铃声
//        content.sound = [UNNotificationSound defaultSound];
//        // 自定义铃声
//        content.sound = [UNNotificationSound soundNamed:@"Define_Sound"];
//        // 角标
//        content.badge = @1;
//
//        // 设置多长时间之后发送
//        NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:1] timeIntervalSinceNow];
//        UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
//
//        // id：便于以后移除、更新 指定通知
//        NSString * noticeId = @"noticeId";
//        // 通知请求
//        UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:noticeId content:content trigger:trigger];
//        // 添加通知请求
//        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
//            if (error == nil) {
//                NSLog(@"本地推送成功");
//            }
//        }];
//
//    }else{
//        UILocalNotification * locationNotice = [[UILocalNotification alloc]init];
//        // 发送时间
//        locationNotice.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
//        // 通知内容
//        locationNotice.alertBody = @"通知内容";
//        locationNotice.userInfo = @{@"json":@"自定义内容",@"NoticeID":@"123"};
//        // 角标
//        locationNotice.applicationIconBadgeNumber = 1;
//        // 默认铃声
//        locationNotice.soundName = UILocalNotificationDefaultSoundName;
//        // 循环提醒
//        locationNotice.repeatInterval = NSCalendarUnitDay;
//        // 发送
//        [[UIApplication sharedApplication] scheduleLocalNotification:locationNotice];
//    }
//}

//4.移除通知
//#pragma mark -- 移除某个通知
//-(void)removeNoticeWithNoticeId:(NSString *)noticeID{
//    if (@available(iOS 10.0,*)) {
//
//        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
//        // 判断noticeID是否存在
//        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
//
//            for (UNNotificationRequest * request in requests) {
//                if([noticeID isEqualToString:request.identifier]){
//                    [center removePendingNotificationRequestsWithIdentifiers:@[noticeID]];
//                }
//            }
//
//        }];
//
//    }else{
//        // 获取scheduled中的通知
//        NSArray * scheduledArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
//
//        for (UILocalNotification * localNotice in scheduledArray) {
//            NSDictionary * userInfo = localNotice.userInfo;
//            NSString * userNoticeID = [userInfo objectForKey:@"NoticeID"];
//            if ([userNoticeID isEqualToString:noticeID]) {
//                [[UIApplication sharedApplication] cancelLocalNotification:localNotice];
//            }
//        }
//    }
//}
//#pragma mark -- 移除所有通知
//- (void)removeAllNotification{
//    if (@available(iOS 10.0,*)) {
//        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
//        [center removeAllPendingNotificationRequests];
//    }else{
//        [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    }
//}

//5.权限问题
//本地推送通知 也需要得到用户的 允许，否则也是看不到 通知的。
//#pragma mark -- 检测通知 开关状态
//- (void)checkNotificationSwitchState{
//    if (@available(iOS 10.0,*)) {
//        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
//        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//            if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
//                NSLog(@"通知权限开启");
//            }else{
//                NSLog(@"通知权限关闭");
//            }
//        }];
//    }else{
//        UIUserNotificationSettings * settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
//        
//        if (settings.types == UIUserNotificationTypeNone) {
//            NSLog(@"通知权限关闭");
//        }else{
//            NSLog(@"通知权限开启");
//        }
//        
//    }
//}

@end

