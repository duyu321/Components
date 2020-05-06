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
}

- (IBAction)clearButtonPressed:(id)sender {
    [self.textField resignFirstResponder];
    
    self.textField.text = @"";
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.widget.components"];
    [userDefaults setObject:@"" forKey:@"widget"];
    [userDefaults synchronize];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"数据已清除！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)ensureButtonPressed:(id)sender {
    if (self.textField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"拜托，稍微写两个字好不好" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.widget.components"];
    [userDefaults setObject:self.textField.text forKey:@"widget"];
    [userDefaults synchronize];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"数据已更新！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
