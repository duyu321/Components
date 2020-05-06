//
//  PhotosContainerView.m
//  SDAutoLayoutDemo
//
//  Created by gsd on 16/5/13.
//  Copyright © 2016年 gsd. All rights reserved.
//

#import "PhotosContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "MSSBrowseDefine.h"

@interface PhotosContainerView () <UIViewControllerPreviewingDelegate>

@end

@implementation PhotosContainerView
{
    NSMutableArray *_imageViewsArray;
}

- (instancetype)initWithMaxItemsCount:(NSInteger)count
{
    if (self = [super init]) {
        self.maxItemsCount = count;
    }
    return self;
}

- (void)setPhotoNamesArray:(NSArray *)photoNamesArray
{
    _photoNamesArray = photoNamesArray;
    
    if (!_imageViewsArray) {
        _imageViewsArray = [NSMutableArray new];
    }
    
    int needsToAddItemsCount = (int)(_photoNamesArray.count - _imageViewsArray.count);
    
    if (needsToAddItemsCount > 0) {
        for (int i = 0; i < needsToAddItemsCount; i++) {
            UIImageView *imageView = [UIImageView new];
            imageView.tag = i;
            [self addSubview:imageView];
            [_imageViewsArray addObject:imageView];
        }
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    
    [_imageViewsArray enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        if (idx < _photoNamesArray.count) {
            imageView.hidden = NO;
            imageView.sd_layout.autoHeightRatio(1);
//            imageView.image = [UIImage imageNamed:_photoNamesArray[idx]];
            [imageView sd_setImageWithURL:_photoNamesArray[idx] placeholderImage:[UIImage imageNamed:@"imagePlaceholder"]];
//            imageView.image = [UIImage imageNamed:@"icon"];
            [temp addObject:imageView];
            imageView.tag = idx+100;
            //创建点按手势
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImage:)];
            imageView.userInteractionEnabled=YES;
            [imageView addGestureRecognizer:tapGes];
            // 添加3Dtouch
            if (iOS9&&self.traitCollection.forceTouchCapability==UIForceTouchCapabilityAvailable) {
                UIViewController *vc = [self getCurrentVC];
                [vc registerForPreviewingWithDelegate:self sourceView:imageView];
                 // 代理
            }
        } else {
            [imageView sd_clearAutoLayoutSettings];
            imageView.hidden = YES;
        }
    }];
    
    [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:3 verticalMargin:10 horizontalMargin:10 verticalEdgeInset:0 horizontalEdgeInset:0];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {

    NSMutableArray *browseItemArray = [NSMutableArray array];
    for(int i = 0;i < self.photoNamesArray.count;i++) {
        UIImageView *imageView = [self viewWithTag:i+100];
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = self.photoOrgNamesArray[i];// 加载网络图片大图地址
        browseItem.smallImageView = imageView;// 小图
        [browseItemArray addObject:browseItem];
    }
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc] initWithBrowseItemArray:browseItemArray currentIndex:previewingContext.sourceView.tag - 100];
    bvc.isEqualRatio = NO;
    return bvc;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    MSSBrowseNetworkViewController *bvc = (MSSBrowseNetworkViewController *)viewControllerToCommit;
    if (_currentVC) {
        [bvc showBrowseViewControllerWithPresent:_currentVC];
    } else {
        [bvc showBrowseViewController];
    }
}

- (void)bigImage:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
//    UIImageView *clickedImageView = (UIImageView *)tap.view;
//    [DYTools scanBigImageWithImageView:clickedImageView];
    NSMutableArray *browseItemArray = [NSMutableArray array];
    for(int i = 0;i < self.photoNamesArray.count;i++) {
        UIImageView *imageView = [self viewWithTag:i+100];
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = self.photoOrgNamesArray[i];// 加载网络图片大图地址
        browseItem.smallImageView = imageView;// 小图
        [browseItemArray addObject:browseItem];
    }
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:tap.view.tag - 100];
    //    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    
    if (_currentVC) {
        [bvc showBrowseViewControllerWithPresent:_currentVC];
    } else {
        [bvc showBrowseViewController];
    }
}

-(UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

-(UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
      
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {

        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
     
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
       
     
        currentVC = rootVC;
    }
    
    return currentVC;
}

@end
