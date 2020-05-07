//
//  DKAutoLayoutCell.m
//  Function2020
//
//  Created by Docker on 2020/4/26.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DKAutoLayoutCell.h"
#import "PhotosContainerView.h"

@interface DKAutoLayoutCell ()
{
    PhotosContainerView *_photosContainer;
}

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation DKAutoLayoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PhotosContainerView *photosContainer = [[PhotosContainerView alloc] initWithMaxItemsCount:6];
    _photosContainer = photosContainer;
    [self.contentView addSubview:photosContainer];
    
    self.title.sd_layout
    .leftSpaceToView(self.contentView, 12)
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 12)
    .autoHeightRatio(0);
    
    self.detail.sd_layout
    .leftEqualToView(self.title)
    .topSpaceToView(self.title, 5)
    .rightSpaceToView(self.contentView, 12)
    .autoHeightRatio(0);
    
    self.time.sd_layout
    .rightSpaceToView(self.contentView, 12)
    .bottomSpaceToView(self.contentView, 10)
    .widthIs(70)
    .autoHeightRatio(0);
    
    self.line.sd_layout
    .leftSpaceToView(self.contentView, 12)
    .bottomSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    _photosContainer.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .topSpaceToView(self.detail, 10); // 高度自适应了，不需要再设置约束
}

- (void)setAutoLayout:(DKAutoLayout *)autoLayout {
    _autoLayout = autoLayout;
    
    self.title.text = autoLayout.name;
    self.detail.text = autoLayout.detail;
    self.time.text = autoLayout.time;
    
    UIView *detail = self.detail;
    _photosContainer.photoNamesArray = autoLayout.KPreviewImages;
    _photosContainer.photoOrgNamesArray = autoLayout.KOriginalImages;
    if (autoLayout.images.count > 0) {
        _photosContainer.hidden = NO;
        detail = _photosContainer;
    } else {
        _photosContainer.hidden = YES;
    }
    
    [self setupAutoHeightWithBottomView:detail bottomMargin:40];
}

@end
