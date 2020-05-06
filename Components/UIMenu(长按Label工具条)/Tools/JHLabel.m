//
//  JHLabel.m
//  Function2020
//
//  Created by Docker on 2020/4/28.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "JHLabel.h"

@implementation JHLabel

/* 不管控件是通过xib stroyboard 还是纯代码  提供两种初始化的操作都调用同一个方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupTap];
    }
    return self;
}

/* 不管控件是通过xib stroyboard 还是纯代码  提供两种初始化的操作都调用同一个方法 */
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupTap];
}

/* 设置敲击手势 */
- (void)setupTap {
    // 已经在stroyboard设置了与用户交互,也可以用纯代码设置
    self.userInteractionEnabled = YES;
    
    // 当前控件是label 所以是给label添加长按手势
    UILongPressGestureRecognizer *longPgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
    longPgr.minimumPressDuration = 0.5;
    [self addGestureRecognizer:longPgr];
}

/* 点击label触发的方法 */
- (void)labelClick:(UILongPressGestureRecognizer *)gestrue {
    // 防止重复触发 直接return掉，不在开始的状态里面添加任何操作，则长按手势就会被少调用一次了
    if (gestrue.state != UIGestureRecognizerStateBegan) {
        return;
    }
    // 让label成为第一响应者 一定要写这句话  因为这句话才是主动让label成为第一响应者
    [self becomeFirstResponder];
    self.backgroundColor = KHexToColor(@"dddddd");
    // 获得菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 添加menu消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillHide) name:UIMenuControllerWillHideMenuNotification object:nil];
    
    // 设置菜单内容 \
    因为menuItems是数组 官方没有给出需要传入什么对象,但是以经验可以判断出需要传入的是UIMenuItem对象 \
    而且显示是按顺序的
    menu.menuItems = @[[[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)],
                       [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)],
                       [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warn:)]
                       ];
    
    // 菜单最终显示的位置 \
    有两种方式: 一种是以自身的bounds  还有一种是以父控件的frame
    [menu setTargetRect:self.bounds inView:self];
    // [menu setTargetRect:self.frame inView:self.superview];

    // 显示菜单
    [menu setMenuVisible:YES animated:YES];
    
}

#pragma mark - UIMenuController相关
/*
 * 让Label具备成为第一响应者的资格
 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}

/*
 * UIMenuController隐藏回调
 */
- (void)menuControllerWillHide{
    [self resignFirstResponder];
    self.backgroundColor = [UIColor clearColor];
}

/*
 * 通过第一响应者的这个方法告诉UIMenuController可以显示什么内容
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ( (action == @selector(copy:) && self.text) // 需要有文字才能支持复制
        || (action == @selector(cut:) && self.text) // 需要有文字才能支持剪切
        || action == @selector(paste:)
        || action == @selector(ding:)
        || action == @selector(reply:)
        || action == @selector(warn:)) {
        return YES;
    }
    return NO;
}

#pragma mark - 监听MenuItem的点击事件
/* 剪切 */
- (void)cut:(UIMenuController *)menu {
    //UIPasteboard 是可以在应用程序与应用程序之间共享的 \
    (应用程序:你的app就是一个应用程序 比如你的QQ消息可以剪切到百度查找一样)
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
    // 清空文字
    self.text = nil;
}

/* 赋值 */
- (void)copy:(UIMenuController *)menu {
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
}

/* 粘贴 */
- (void)paste:(UIMenuController *)menu {
    // 将粘贴板的文字赋值给label
    self.text = [UIPasteboard generalPasteboard].string;
}

//如果方法不实现,是不会显示出来的
- (void)ding:(UIMenuController *)menu {
    self.backgroundColor = UIColor.clearColor;
    NSLog(@"%s %@", __func__, menu);
}

- (void)reply:(UIMenuController *)menu {
    NSLog(@"%s %@", __func__, menu);
}

- (void)warn:(UIMenuController *)menu {
    NSLog(@"%s %@", __func__, menu);
}


- (void)dealloc{
    [self resignFirstResponder];
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

@end
