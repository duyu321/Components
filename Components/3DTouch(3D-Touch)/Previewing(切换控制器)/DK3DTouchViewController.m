//
//  DK3DTouchViewController.m
//  Function2020
//
//  Created by Docker on 2020/4/29.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DK3DTouchViewController.h"
#import "DK3DTouchChangeCtrViewController.h"
#import "DK3DTouchAppIconViewController.h"
#import "DK3DTouchWidgetViewController.h"

@interface DK3DTouchViewController () <UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<NSString *> *dataArray;

@end

@implementation DK3DTouchViewController

#define KCellHeight 50

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI {
    self.title = @"3D-Touch";
    self.dataArray = @[@"3D-Touch切换控制器",@"App Icon 3D-Touch",@"Widget小组件"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"3dtouchcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"3dtouchcell"];
        cell.textLabel.text = self.dataArray[indexPath.row];
        if (iOS9&&self.traitCollection.forceTouchCapability==UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.dataArray[indexPath.row] isEqualToString:@"3D-Touch切换控制器"]) {
        [self.navigationController pushViewController:[[DK3DTouchChangeCtrViewController alloc] init] animated:YES];
    }
    if ([self.dataArray[indexPath.row] isEqualToString:@"App Icon 3D-Touch"]) {
        [self.navigationController pushViewController:[[DK3DTouchAppIconViewController alloc] init] animated:YES];
    }
    if ([self.dataArray[indexPath.row] isEqualToString:@"Widget小组件"]) {
        [self.navigationController pushViewController:[[DK3DTouchWidgetViewController alloc] init] animated:YES];
    }
}

#pragma mark - UIViewControllerPreviewingDelegate

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {

    UITableViewCell *cell = (UITableViewCell *)previewingContext.sourceView;
    if ([cell.textLabel.text isEqualToString:@"3D-Touch切换控制器"]) {
        DK3DTouchChangeCtrViewController *vc = [[DK3DTouchChangeCtrViewController alloc] init];
        // 预览区域大小(可不设置), 0为默认尺寸
        vc.preferredContentSize = CGSizeMake(KScreenWidth, KScreenHeight);
        //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
        //设置触发操作的视图的不被虚化的区域
        previewingContext.sourceRect = CGRectMake(0, 0, KScreenWidth, KCellHeight);
        return vc;
    }
    if ([cell.textLabel.text isEqualToString:@"App Icon 3D-Touch"]) {
        DK3DTouchAppIconViewController *vc = [[DK3DTouchAppIconViewController alloc] init];
        vc.preferredContentSize = CGSizeMake(KScreenWidth, KScreenHeight);
        previewingContext.sourceRect = CGRectMake(0, 0, KScreenWidth, KCellHeight);
        return vc;
    }
    if ([cell.textLabel.text isEqualToString:@"Widget小组件"]) {
        DK3DTouchWidgetViewController *vc = [[DK3DTouchWidgetViewController alloc] init];
        vc.preferredContentSize = CGSizeMake(KScreenWidth, KScreenHeight);
        previewingContext.sourceRect = CGRectMake(0, 0, KScreenWidth, KCellHeight);
        return vc;
    }

    return nil;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    viewControllerToCommit.hidesBottomBarWhenPushed = YES;
    [self showViewController:viewControllerToCommit sender:self];
}

@end
