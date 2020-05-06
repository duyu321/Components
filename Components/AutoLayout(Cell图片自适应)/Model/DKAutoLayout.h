//
//  DKAutoLayout.h
//  Function2020
//
//  Created by Docker on 2020/4/26.
//  Copyright © 2020 Docker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKAutoLayoutImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKAutoLayout : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *detail;
@property (copy, nonatomic) NSString *time;
@property (strong, nonatomic) NSArray<DKAutoLayoutImage *> *images;

@property (strong, nonatomic) NSArray *KPreviewImages;
@property (strong, nonatomic) NSArray *KOriginalImages;

@end

NS_ASSUME_NONNULL_END
