//
//  IMichUtil.h
//  MeiQuan
//
//  Created by air on 15/4/22.
//  Copyright (c) 2015年 ilikeido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SECS_OF_ONE_DAY    (24 * 60 * 60)  // 一天
#define SECS_OF_ONE_HOUR   (60 * 60)       // 一小时
#define SECS_OF_ONE_MIN    60              // 一分钟
#define MSECS_OF_ONE_SEC   1000            // 一秒毫秒数

@class HXPhotoModel;
@class HXPhotoManager;

@interface IMichUtil : NSObject

+ (IMichUtil *)shareInstance;

//app资源路径 各种缓存
+ (NSString *)appResourcePath;

//app的视频资源缓存
+ (NSString *)getVideoFolderPath;


+ (NSString *)convertDomainNameToIPAddr:(const char *)domainName;

/**
 小于一小时 -> xx:xx
 大于一小时 -> xx:xx:xx
 */
+ (NSString *)timeStringHHMMSSFromSeconds:(NSUInteger)second;

// 获取当前时间戳
+ (unsigned long long)getCurTimeStamp;

+ (NSString *)longTimeToDate:(unsigned long long)longTime dateFormat:(NSString *)dateFormat;

// 计算文本高度
+ (CGFloat)calcLabelHeight:(NSString *)strText fontSize:(NSInteger)fontSize width:(CGFloat)width;

// 计算文本高度
+ (CGFloat)calcLabelHeight:(NSString *)strText font:(UIFont *)font width:(CGFloat)width;

// 计算文本宽度
+ (CGFloat)calcLabelWidth:(NSString *)strText fontSize:(NSInteger)fontSize height:(CGFloat)height;

/**
 *  计算文字尺寸
 *
 *  @param value    需要计算尺寸的文字
 *  @param fontSize    文字的字体
 *  @param width 文字的最大尺寸
 */
+ (CGSize)sizeWithText:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+ (NSInteger)lineWithText:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+ (NSInteger)lineWithText:(NSString *)value font:(UIFont *)font andWidth:(float)width;

///得到网页交互资源缓存路径
/// @param subdirectory 子目录  aaa/bbb
+ (NSString *)getWebCacheDir:(NSString *)subdirectory;

///得到视频缓存路径
/// @param subdirectory 子目录  aaa/bbb
+ (NSString *)getVideoDir:(NSString *)subdirectory;


/// ///得到音频缓存路径
/// @param subdirectory 子目录  aaa/bbb
+ (NSString *)getAudioDir:(NSString *)subdirectory;

/// ///压缩图片
/// @param source_image  UIImage
/// @param maxSize 最大的图片存储大小
/// @param maxMeasure 最大的图片尺寸   1080
+ (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize maxMeasure:(CGFloat)maxMeasure;

/**
 *  截取指定时间的视频缩略图
 *
 *  @param timeBySecond 时间点，单位：s
 */
+ (UIImage *)thumbnailImageRequestWithVideoUrl:(NSURL *)videoUrl andTime:(CGFloat)timeBySecond;

@end
