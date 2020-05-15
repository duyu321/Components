//
//  DK3DTouchWidgetViewController.m
//  Function2020
//
//  Created by Docker on 2020/4/29.
//  Copyright © 2020 Docker. All rights reserved.
//

/* ✨
 * ✨ widget创建方法详见简书：https://www.jianshu.com/p/012319813522
 * ✨
 */
 
#import "DK3DTouchWidgetViewController.h"

@interface DK3DTouchWidgetViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation DK3DTouchWidgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI {
    self.title = @"Widget小组件";
    
    // 读取
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.widget.components"];
    self.textField.text = [userDefaults objectForKey:@"widget"];
}

- (IBAction)clearButtonPressed:(id)sender {
    [self.view endEditing:YES];
    
    self.textField.text = @"";
    
    // 存储
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.widget.components"];
    [userDefaults setObject:@"" forKey:@"widget"];
    [userDefaults synchronize];
    
    MESSAGEBOX(@"数据已清除！")
}

- (IBAction)ensureButtonPressed:(id)sender {
    [self.view endEditing:YES];
    if (self.textField.text.length == 0) {
        MESSAGEBOX(@"拜托，稍微写两个字好不好")
        
        return;
    }
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.widget.components"];
    [userDefaults setObject:self.textField.text forKey:@"widget"];
    [userDefaults synchronize];

    MESSAGEBOX(@"数据已更新！")
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
