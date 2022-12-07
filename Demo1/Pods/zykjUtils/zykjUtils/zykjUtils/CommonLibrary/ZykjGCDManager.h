//
//  ZykjGCDManager.h
//  ZykjFoundation
//
//  Created by DeerClass on 2021/1/26.
//  Copyright © 2021 zoulixiang. All rights reserved.
//

#import "NSObject+CommonBlock.h"

@interface ZykjGCDManager : NSObject

+ (instancetype)sharedInstance;

- (void)enter;
- (void)leave;
- (void)notifyMainQueue: (CommonVoidBlock) block;

@end

