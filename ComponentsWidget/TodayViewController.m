//
//  TodayViewController.m
//  ComponentsWidget
//
//  Created by Docker on 2020/5/6.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#define THIRD_BUTTON_WIDTH 45
#define THIRD_BUTTON_DISTINCE 30
#define kWidgetWidth ([UIScreen mainScreen].bounds.size.width - 16)

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *redButton;
@property (nonatomic, strong) UIButton *greenButton;
@property (nonatomic, strong) UIButton *qqLoginButton;
@property (nonatomic, strong) UIButton *wechatLoginButton;
@property (nonatomic, strong) UIButton *weiboLoginButton;
@property (nonatomic, copy) NSString *contentStr;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置widget的size（iOS10之后，Widget支持展开及折叠两种展现方式）
    if (@available(iOS 10.0, *)) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    self.preferredContentSize = CGSizeMake(kWidgetWidth, 110);
        
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.widget.components"];
    self.contentStr = [userDefaults objectForKey:@"widget"];
        
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.redButton];
    [self.view addSubview:self.greenButton];
    [self.view addSubview:self.wechatLoginButton];
    [self.view addSubview:self.qqLoginButton];
    [self.view addSubview:self.weiboLoginButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

// 2.重写切换展开及折叠布局时的方法（iOS10 之后）
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize API_AVAILABLE(ios(10.0)) {
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake(maxSize.width, 110);
    } else {
        self.preferredContentSize = CGSizeMake(maxSize.width, 200);
    }
}

// iOS10之前，视图原点默认存在一个间距，可以实现以下方法来调整视图间距（iOS10 废弃）
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

#pragma mark - --- Customed Methods ---

- (void)redButtonPressed:(UIButton *)button {
    NSURL *url = [NSURL URLWithString:@"Components://red"];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        NSLog(@"isSuccessed %d",success);
    }];
}

- (void)greenButtonPressed:(UIButton *)button {
    NSURL *url = [NSURL URLWithString:@"Components://green"];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        NSLog(@"isSuccessed %d",success);
    }];
}

- (void)wechatLoginButtonPressed {
    NSURL *url = [NSURL URLWithString:@"wechat://"];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        NSLog(@"isSuccessed %d",success);
    }];
}

- (void)qqLoginButtonPressed {
    NSURL *url = [NSURL URLWithString:@"mqq://"];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        NSLog(@"isSuccessed %d",success);
    }];
}

- (void)weiboLoginButtonPressed {
    NSURL *url = [NSURL URLWithString:@"weibo://"];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        NSLog(@"isSuccessed %d",success);
    }];
}

#pragma mark - --- Lazy ---

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kWidgetWidth, 25)];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:14];
        
        if (self.contentStr.length > 0) {
            _messageLabel.text = self.contentStr;
        } else {
            _messageLabel.text = @"当前内容为空";
        }
    }
    return _messageLabel;
}

- (UIButton *)redButton {
    if (!_redButton) {
        _redButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _redButton.frame = CGRectMake(0, 0, 80, 30);
        _redButton.center = CGPointMake(kWidgetWidth * 0.25, 75);
        [_redButton setBackgroundColor:[UIColor redColor]];
        [_redButton setTitle:@"Red" forState:UIControlStateNormal];
        [_redButton addTarget:self action:@selector(redButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _redButton;
}

- (UIButton *)greenButton {
    if (!_greenButton) {
        _greenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _greenButton.frame = CGRectMake(0, 0, 80, 30);
        _greenButton.center = CGPointMake(kWidgetWidth * 0.75, 75);
        [_greenButton setBackgroundColor:[UIColor greenColor]];
        [_greenButton setTitle:@"Green" forState:UIControlStateNormal];
        [_greenButton addTarget:self action:@selector(greenButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _greenButton;
}

- (UIButton *)wechatLoginButton {
    if (!_wechatLoginButton) {
        float precent;
        
        if ([UIScreen mainScreen].bounds.size.height == 480) {
            precent = 0.9;
        } else {
            precent = 0.8;
        }
        
        UIImage *wechatImage = [UIImage imageNamed:@"login_wechat"];
        
        _wechatLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _wechatLoginButton.frame = CGRectMake(0, 0, THIRD_BUTTON_WIDTH, THIRD_BUTTON_WIDTH);
        _wechatLoginButton.center = CGPointMake(kWidgetWidth / 2, 150);
        [_wechatLoginButton setImage:wechatImage forState:UIControlStateNormal];
        [_wechatLoginButton setImage:wechatImage forState:UIControlStateHighlighted];
        [_wechatLoginButton addTarget:self action:@selector(wechatLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatLoginButton;
}

- (UIButton *)qqLoginButton {
    if (!_qqLoginButton) {
        UIImage *qqImage = [UIImage imageNamed:@"login_QQ"];
        
        _qqLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _qqLoginButton.frame = CGRectMake(0, 0, THIRD_BUTTON_WIDTH, THIRD_BUTTON_WIDTH);
        _qqLoginButton.center = CGPointMake(kWidgetWidth / 2 + THIRD_BUTTON_WIDTH + THIRD_BUTTON_DISTINCE, _wechatLoginButton.center.y);
        [_qqLoginButton setImage:qqImage forState:UIControlStateNormal];
        [_qqLoginButton setImage:qqImage forState:UIControlStateHighlighted];
        [_qqLoginButton addTarget:self action:@selector(qqLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqLoginButton;
}

- (UIButton *)weiboLoginButton {
    if (!_weiboLoginButton) {
        UIImage *weiboImage = [UIImage imageNamed:@"login_weibo"];
        
        _weiboLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _weiboLoginButton.frame = CGRectMake(0, 0, THIRD_BUTTON_WIDTH, THIRD_BUTTON_WIDTH);
        _weiboLoginButton.center = CGPointMake(kWidgetWidth / 2 - THIRD_BUTTON_WIDTH - THIRD_BUTTON_DISTINCE, _wechatLoginButton.center.y);
        [_weiboLoginButton setImage:weiboImage forState:UIControlStateNormal];
        [_weiboLoginButton setImage:weiboImage forState:UIControlStateHighlighted];
        [_weiboLoginButton addTarget:self action:@selector(weiboLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiboLoginButton;
}


// 上述通过NSUserDefault，也可通过NSFileManager共享数据
- (BOOL)saveDataByNSFileManager {
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.xxx"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/ widget"];
    NSString *value = @"asdfasdfasf";
    BOOL result = [value writeToURL:containerURL atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if (!result) {
        NSLog(@"%@",err);
    } else {
        NSLog(@"save value:%@ success.",value);
    }
    return result;
}

- (NSString *)readDataByNSFileManager {
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.xxx"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/ widget"];
    NSString *value = [NSString stringWithContentsOfURL:containerURL encoding: NSUTF8StringEncoding error:&err];
    return value;
}

@end
