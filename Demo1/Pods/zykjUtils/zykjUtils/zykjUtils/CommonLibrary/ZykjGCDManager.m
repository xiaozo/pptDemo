//
//  ZykjGCDManager.m
//  ZykjFoundation
//
//  Created by DeerClass on 2021/1/26.
//  Copyright © 2021 zoulixiang. All rights reserved.
//

#import "ZykjGCDManager.h"

@interface ZykjGCDManager ()

//维护一个可以重复利用的dispatch_group
@property(nonatomic) dispatch_group_t dispatchGroup;
//计数
@property (assign, nonatomic) long count;

@end

@implementation ZykjGCDManager

+ (instancetype)sharedInstance {
    static ZykjGCDManager *manager;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dispatchGroup = dispatch_group_create();
        self.count = 0;
    }
    return self;
}

// 任务计数+1
- (void)enter {
//    if (self.dispatchGroup == nil) {
//        dispatch_group_t group = dispatch_group_create();
//        self.dispatchGroup = group;
//    }
    self.count ++;
    NSLog(@"++ dispatch group tasks count: %ld", self.count);
    dispatch_group_enter(self.dispatchGroup);
}

//任务计数-1
- (void)leave{
    if (self.count <=0) {
        return;
    }
    self.count --;
    NSLog(@"-- dispatch group tasks count: %ld", self.count);
    dispatch_group_leave(self.dispatchGroup);
}

//通知主队列所有任务完成,执行 block
- (void)notifyMainQueue: (CommonVoidBlock) block {
    dispatch_group_notify(self.dispatchGroup, dispatch_get_main_queue(), ^{
        NSLog(@"notify");
        block();
    });
}
@end

