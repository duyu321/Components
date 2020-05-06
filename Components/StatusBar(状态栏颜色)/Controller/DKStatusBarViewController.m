//
//  DKStatusBarViewController.m
//  Function2020
//
//  Created by Docker on 2020/4/26.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DKStatusBarViewController.h"
#import "DKTestViewController.h"

@interface DKStatusBarViewController ()

@end

@implementation DKStatusBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // info.plist 中 "View controller-based status bar appearance" : NO
    // info.plist 中 "Status bar is initially hidden" : NO
    // 单个控制器在 viewWillAppear 和 viewWillDisappear 中实现方法
    
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.navigationController.navigationBar.barTintColor = KHexToColor(@"0e88eb");
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)setUI {
    self.title = @"状态栏颜色";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // [button setTitle:@"" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    button.dk_size = CGSizeMake(70, 30);
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // [button sizeToFit];
    // 让按钮的内容往左边偏移10
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[[DKTestViewController alloc] init] animated:YES];
}

@end

