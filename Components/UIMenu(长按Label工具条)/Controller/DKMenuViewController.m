//
//  DKMenuViewController.m
//  Function2020
//
//  Created by Docker on 2020/4/28.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DKMenuViewController.h"
#import "JHLabel.h"
#import "UILabel+DK.h"

@interface DKMenuViewController ()
@property (weak, nonatomic) IBOutlet JHLabel *label;

@end

@implementation DKMenuViewController

// 需让UILabel继承JHLabel

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI {
    self.view.backgroundColor = UIColor.whiteColor;
    self.label.text = @"123\n234广东省fasdf发\n鬼地方个";
    CGFloat width = [UILabel getWidthWithTitle:self.label.text font:[UIFont systemFontOfSize:17]];
    CGFloat height = [UILabel getHeightByWidth:width title:self.label.text font:[UIFont systemFontOfSize:17]];
    if (width > KScreenWidth - 20) {
        width = KScreenWidth - 20;
    }
    self.label.sd_layout
    .leftSpaceToView(self.view, 10)
    .centerYEqualToView(self.view)
    .widthIs(width)
    .heightIs(height);
}

@end
