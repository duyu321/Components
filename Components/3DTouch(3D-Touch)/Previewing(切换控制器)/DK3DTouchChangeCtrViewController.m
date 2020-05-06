//
//  DK3DTouchChangeCtrViewController.m
//  Function2020
//
//  Created by Docker on 2020/4/29.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DK3DTouchChangeCtrViewController.h"

@interface DK3DTouchChangeCtrViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DK3DTouchChangeCtrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI {
    // 详见DK3DTouchViewController.m
    self.title = @"3D-Touch切换控制器";
}

@end
