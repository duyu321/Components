//
//  DKKeyboardViewController.m
//  Function2020
//
//  Created by Docker on 2020/4/24.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DKKeyboardViewController.h"

@interface DKKeyboardViewController ()

@end

@implementation DKKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不同view上的TF需父 view 继承 IQPreviousNextView 类
    
    [self setupUI];
}

- (void)setupUI {
    self.title = @"键盘";
}

@end
