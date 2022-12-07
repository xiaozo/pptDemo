//
//  ZykjScreenUtil.m
//  zykjUtils
//
//  Created by DeerClass on 2021/9/17.
//

#import "ZykjScreenUtil.h"

#define kSUScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define kSUScreenHeight                        [[UIScreen mainScreen] bounds].size.height

@interface ZykjScreenUtil ()

@property (assign, nonatomic) CGSize designSize;

@end

@implementation ZykjScreenUtil

+ (instancetype)sharedInstance {
    static ZykjScreenUtil *_zykjScreenUtil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _zykjScreenUtil = [[ZykjScreenUtil alloc] init];
    });
    return _zykjScreenUtil;
}

- (CGFloat)w:(CGFloat)w {
    return w * (kSUScreenWidth / _designSize.width);
}
- (CGFloat)h:(CGFloat)h {
    return h * (kSUScreenHeight / _designSize.height);
}

- (CGFloat)autoValue:(CGFloat)value {
    CGFloat designValue = MIN(_designSize.width, _designSize.height);
    CGFloat screenValue = MIN(kSUScreenWidth, kSUScreenHeight);
    return value * (screenValue / designValue);
}

@end
