//
//  DKUPushViewController.m
//  Components
//
//  Created by Docker on 2020/5/11.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DKUPushViewController.h"

@interface DKUPushViewController ()

@end

@implementation DKUPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    self.title = @"友盟推送";
    
    // 推送使用第三方工具《友盟+推送》
    
    // Cocoapods 使用 pod 'UMCCommon','2.1.1' # 必须为2.1.1之后版本，否则APP打开后会闪退
    //               pod 'UMCSecurityPlugins', '1.0.6'
    //               pod 'UMCPush', '3.2.4'
    
    // 网址为：https://passport.umeng.com/login
    // 用户名：dockercoder@163.com
    
    // UMCCommon 集成文档：https://developer.umeng.com/docs/66632/detail/66885
    // UMCPush 集成文档：https://developer.umeng.com/docs/66632/detail/66734
    // 推送测试后台：https://message.umeng.com/app/5eb3a719978eea082619cd1e/testmode （需将测试设备deviceToken添加）
    
    // 注意如果测试正式环境推送，需在developer.apple.com中建Ad-Hoc证书，并在打包的时候选择相对应的描述文件
}

@end
