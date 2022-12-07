//
//  ZykjScreenUtil.h
//  zykjUtils
//
//  Created by DeerClass on 2021/9/17.
//

#import <Foundation/Foundation.h>

#define kSCFont(value)      kSCAV(value)
#define kSCW(value)         [ZykjScreenUtil.sharedInstance w:value]
#define kSCH(value)         [ZykjScreenUtil.sharedInstance h:value]
#define kSCAV(value)         [ZykjScreenUtil.sharedInstance autoValue:value]

@interface ZykjScreenUtil : NSObject

+ (instancetype)sharedInstance;

-(void)setDesignSize:(CGSize)designSize;

- (CGFloat)w:(CGFloat)w;
- (CGFloat)h:(CGFloat)h;


/// 根据屏幕的最小值获取比例值
/// @param value value
- (CGFloat)autoValue:(CGFloat)value;

@end


