//
//  DYMainViewController.m
//  Function2020
//
//  Created by Docker on 2020/4/22.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DYMainViewController.h"
#import "DKStatusBarViewController.h"
#import "DKKeyboardViewController.h"
#import "DKPickerPhotoViewController.h"
#import "DKAutoLayoutViewController.h"
#import "DKScrollImageViewController.h"
#import "DKMenuViewController.h"
#import "DKMainViewCell.h"
#import "DK3DTouchViewController.h"

@interface DYMainViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<NSString *> *dataArray;

@end

@implementation DYMainViewController

static NSString *const DKMainViewCellId = @"DKMainViewCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DKMainViewCell class]) bundle:nil] forCellReuseIdentifier:DKMainViewCellId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DKMainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DKMainViewCellId];
    cell.name.text = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.dataArray[indexPath.row] isEqualToString:@"状态栏颜色"]) {
        [self.navigationController pushViewController:[[DKStatusBarViewController alloc] init] animated:YES];
    }
    if ([self.dataArray[indexPath.row] isEqualToString:@"键盘"]) {
        [self.navigationController pushViewController:[[DKKeyboardViewController alloc] init] animated:YES];
    }
    if ([self.dataArray[indexPath.row] isEqualToString:@"照片选择"]) {
        [self.navigationController pushViewController:[[DKPickerPhotoViewController alloc] init] animated:YES];
    }
    if ([self.dataArray[indexPath.row] isEqualToString:@"Cell图片自适应"]) {
        [self.navigationController pushViewController:[[DKAutoLayoutViewController alloc] init] animated:YES];
    }
    if ([self.dataArray[indexPath.row] isEqualToString:@"轮播图"]) {
        [self.navigationController pushViewController:[[DKScrollImageViewController alloc] init] animated:YES];
    }
    if ([self.dataArray[indexPath.row] isEqualToString:@"长按Label工具条"]) {
        [self.navigationController pushViewController:[[DKMenuViewController alloc] init] animated:YES];
    }
    if ([self.dataArray[indexPath.row] isEqualToString:@"3D-Touch"]) {
        [self.navigationController pushViewController:[[DK3DTouchViewController alloc] init] animated:YES];
    }
}

- (NSArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"状态栏颜色",@"键盘",@"照片选择",@"Cell图片自适应",@"轮播图",@"长按Label工具条",@"3D-Touch"];
    }
    return _dataArray;
}

@end
