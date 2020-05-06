//
//  DYBaseViewController.h
//  A_Big_Demo
//
//  Created by 杜宇 on 16/2/26.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VCBackBlockAction)(void);

@interface DYBaseViewController : UIViewController

@property (nonatomic, copy) VCBackBlockAction backBlock;

#pragma mark - VC出栈时调用
- (void)vcBackBlock:(VCBackBlockAction)block;

@property (strong, nonatomic)AFHTTPSessionManager *manager;
@property (assign, nonatomic) CGFloat navAndStaHeight;
@property (assign, nonatomic) CGFloat tabbarHeight;
@property (nonatomic, assign) BOOL isFromHeadRefresh;

- (void)hiddenAllView;
- (void)showAllView;

@end
