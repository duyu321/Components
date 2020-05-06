//
//  DKAutoLayout.m
//  Function2020
//
//  Created by Docker on 2020/4/26.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DKAutoLayout.h"

@implementation DKAutoLayout

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"images": [DKAutoLayoutImage class]};
}

- (NSArray *)KPreviewImages {
    if (!_KPreviewImages) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (DKAutoLayoutImage *image in self.images) {
            [tempArray addObject:image.preImage];
        }
        _KPreviewImages = tempArray.copy;
    }
    return _KPreviewImages;
}

- (NSArray *)KOriginalImages {
    if (!_KOriginalImages) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (DKAutoLayoutImage *image in self.images) {
            [tempArray addObject:image.orgImage];
        }
        _KOriginalImages = tempArray.copy;
    }
    return _KOriginalImages;
}

@end
