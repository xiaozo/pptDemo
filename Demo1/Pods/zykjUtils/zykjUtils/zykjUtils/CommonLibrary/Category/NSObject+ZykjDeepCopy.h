//
//  NSObject+ZykjDeepCopy.h
//  ZykjFoundation
//
//  Created by lyman on 2022/1/7.
//  Copyright © 2022 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZykjDeepCopy)

///深拷贝
- (instancetype)zykjDeepCopy;

@end

@interface NSArray (ZykjDeepCopy)

///深拷贝
- (instancetype)zykjDeepCopy;

@end

@interface NSDictionary (ZykjDeepCopy)

///深拷贝
- (instancetype)zykjDeepCopy;

@end
NS_ASSUME_NONNULL_END
