//
//  PhotosContainerView.h
//  SDAutoLayoutDemo
//
//  Created by gsd on 16/5/13.
//  Copyright © 2016年 gsd. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class PhotosContainerView;
//
//@protocol PhotosContainerViewDelegate <NSObject>
//@optional
//- (void)photosContainerView:(PhotosContainerView *)photosContainerView didSelectedImage:(NSArray *)imagesArray andIndex:(NSInteger)index;
//@end

@interface PhotosContainerView : UIView

- (instancetype)initWithMaxItemsCount:(NSInteger)count;

@property (nonatomic, strong) NSArray *photoNamesArray;

@property (nonatomic, strong) NSArray *photoOrgNamesArray;

@property (nonatomic, assign) NSInteger maxItemsCount;

@property (nonatomic, weak) UIViewController *currentVC;

//@property (assign, nonatomic) id<PhotosContainerViewDelegate> delegate;

@end
