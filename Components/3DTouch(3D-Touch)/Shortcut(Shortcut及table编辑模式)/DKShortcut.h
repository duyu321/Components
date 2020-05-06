//
//  DKShortcut.h
//  Function2020
//
//  Created by Docker on 2020/4/30.
//  Copyright © 2020 Docker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKShortcut : NSObject

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (copy, nonatomic) NSString *methods;

@end

NS_ASSUME_NONNULL_END
