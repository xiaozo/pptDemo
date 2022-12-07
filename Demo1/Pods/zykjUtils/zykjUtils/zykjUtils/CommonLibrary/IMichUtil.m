//
//  IMichUtil.m
//  MeiQuan
//
//  Created by air on 15/4/22.
//  Copyright (c) 2015年 ilikeido. All rights reserved.
//

#import "IMichUtil.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <netdb.h>
#include <arpa/inet.h>
#import <objc/runtime.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVFoundation.h>
#import "PathUtility.h"

#define DotNumbers       @"0123456789.\n"
#define Numbers          @"0123456789\n"


@interface IMichUtil()

@end

@implementation IMichUtil

//app资源路径 各种缓存
+ (NSString *)appResourcePath {
    NSString *path = [NSString stringWithFormat:@"%@/ZYKJResource",[PathUtility getCachePath]];
    NSFileManager *fm  = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path
      withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)getVideoFolderPath {
    //  在Documents目录下创建一个名为FileData的文件夹
    NSString *path = [NSString stringWithFormat:@"%@/ZYKJVideo",[self appResourcePath]];
    
    NSFileManager *fm  = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path
      withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

+ (IMichUtil *)shareInstance
{
    static IMichUtil *shareIMichUtil = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareIMichUtil = [[self alloc] init];
    });

    return shareIMichUtil;
}

+ (NSString *)convertDomainNameToIPAddr:(const char *)domainName
{
    NSString *ipStr = nil;

    @try {
        Boolean result,bResolved;
        CFHostRef hostRef;
        CFArrayRef addresses = NULL;
        
        CFStringRef hostNameRef = CFStringCreateWithCString(kCFAllocatorDefault, domainName, kCFStringEncodingASCII);
        
        hostRef = CFHostCreateWithName(kCFAllocatorDefault, hostNameRef);
        if (hostRef) {
            result = CFHostStartInfoResolution(hostRef, kCFHostAddresses, NULL);
            if (result == TRUE) {
                addresses = CFHostGetAddressing(hostRef, &result);
            }
        }
        bResolved = result == TRUE ? true : false;
        
        if(bResolved)
        {
            struct sockaddr_in* remoteAddr;
            for(int i = 0; i < CFArrayGetCount(addresses); i++)
            {
                CFDataRef saData = (CFDataRef)CFArrayGetValueAtIndex(addresses, i);
                remoteAddr = (struct sockaddr_in*)CFDataGetBytePtr(saData);
                
                if(remoteAddr != NULL)
                {
                    //获取IP地址
                    char ip[16];
                    strcpy(ip, inet_ntoa(remoteAddr->sin_addr));
                    ipStr = [NSString stringWithUTF8String:ip];
                }
            }
        }
        CFRelease(hostNameRef);
        CFRelease(hostRef);
    }
    @catch (NSException *exception) {
        NSLog(@"exception = %@", exception.description);
    }

    return ipStr;
    
}

/**
 小于一小时 -> xx:xx
 大于一小时 -> xx:xx:xx
 */
+ (NSString *)timeStringHHMMSSFromSeconds:(NSUInteger)second {
    NSUInteger totalMinite = second / 60;
    NSUInteger leftSecond = second % 60;
    NSUInteger totalHours = totalMinite / 60;
    NSUInteger leftMinite = totalMinite % 60;
    if(totalHours > 0) {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",totalHours,leftMinite,leftSecond];
    } else if (totalMinite > 0) {
        return [NSString stringWithFormat:@"%02ld:%02ld",totalMinite, leftSecond];
    } else {
        return [NSString stringWithFormat:@"00:%02ld",second];
    }
}

// 获取当前时间戳
+ (unsigned long long)getCurTimeStamp
{
    unsigned long long retTime = [[NSDate date] timeIntervalSince1970];
    
    return retTime;
}

+ (NSString *)longTimeToDate:(unsigned long long)longTime dateFormat:(NSString *)dateFormat {
    if (longTime < 0) {
        return nil;
    }
    unsigned long long lDateTime = longTime;             // 时间
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:lDateTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
  
    NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];
    
    return dateStr;
}

+ (CGFloat)calcLabelHeight:(NSString *)strText fontSize:(NSInteger)fontSize width:(CGFloat)width
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSLineBreakByWordWrapping;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraph};
    CGSize size = [strText boundingRectWithSize:CGSizeMake(width, 0.0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size.height;
}

// 计算文本高度
+ (CGFloat)calcLabelHeight:(NSString *)strText font:(UIFont *)font width:(CGFloat)width {
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSLineBreakByWordWrapping;
    NSDictionary *attribute = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraph};
    CGSize size = [strText boundingRectWithSize:CGSizeMake(width, 0.0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size.height;
}

+ (CGFloat)calcLabelWidth:(NSString *)strText fontSize:(NSInteger)fontSize height:(CGFloat)height
{
    CGFloat width = [strText boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.width;
    
    return width + 1.0;
}

/**
 *  计算文字尺寸
 *
 */
+ (CGSize)sizeWithText:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return sizeToFit;
}

+ (NSInteger)lineWithText:(NSString *)value fontSize:(float)fontSize andWidth:(float)width {
    CGFloat lineH = [self sizeWithText:@"计算文字尺寸" fontSize:fontSize andWidth:width].height;
    CGFloat contentH = [self sizeWithText:value fontSize:fontSize andWidth:width].height;
    
    return ceilf(contentH / lineH);
}

+ (NSInteger)lineWithText:(NSString *)value font:(UIFont *)font andWidth:(float)width {
  
    CGFloat  textH = [value  boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;

    CGFloat lineHeight = font.lineHeight;

    NSInteger  lineCount = textH / lineHeight;
    return lineCount;
}


+ (NSString *)getWebCacheDir:(NSString *)subdirectory {
    //  在Documents目录下创建一个名为FileData的文件夹
    NSString *path = [NSString stringWithFormat:@"%@/ZYKJWebCache",[PathUtility getCachePath]];
    path = subdirectory.length ? [path stringByAppendingPathComponent:subdirectory] : path;
    
    NSFileManager *fm  = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path
      withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    return path;
}

///得到视频缓存路径
+ (NSString *)getVideoDir:(NSString *)subdirectory {
   //  在Documents目录下创建一个名为FileData的文件夹
    NSString *path = [NSString stringWithFormat:@"%@/ZYKJAudio",[PathUtility getCachePath]];
    path = subdirectory.length ? [path stringByAppendingPathComponent:subdirectory] : path;
    
    NSFileManager *fm  = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path
      withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    return path;
}

///得到音频缓存路径
+ (NSString *)getAudioDir:(NSString *)subdirectory {
   //  在Documents目录下创建一个名为FileData的文件夹
    NSString *path = [NSString stringWithFormat:@"%@/ZYKJVideo",[PathUtility getCachePath]];
    path = subdirectory.length ? [path stringByAppendingPathComponent:subdirectory] : path;
    
    NSFileManager *fm  = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path
      withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    return path;
}

/// ///压缩图片
/// @param source_image  UIImage
/// @param maxSize 最大的图片存储大小
/// @param maxMeasure 最大的图片尺寸   1080
+ (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize maxMeasure:(CGFloat)maxMeasure {
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    CGFloat scaleHeight = newSize.height / maxMeasure;
    CGFloat scaleWidth = newSize.width / maxMeasure;
    UIImage *newImage = source_image;
    ///是否需要重新裁剪渲染
    BOOL isNeedAgainDraw = NO;
    
    if (scaleWidth > 1.0 && scaleWidth > scaleHeight) {
        newSize = CGSizeMake(source_image.size.width / scaleWidth, source_image.size.height / scaleWidth);
        isNeedAgainDraw = YES;
    } else if (scaleHeight > 1.0 && scaleWidth < scaleHeight){
        newSize = CGSizeMake(source_image.size.width / scaleHeight, source_image.size.height / scaleHeight);
        isNeedAgainDraw = YES;
    }
    if (isNeedAgainDraw) {
        UIGraphicsBeginImageContext(newSize);
        [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    //调整大小
    CGFloat compression = 1.0f;
    NSData *imageData = UIImageJPEGRepresentation(newImage,compression);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    while (sizeOriginKB > maxSize && compression > 0.1f) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(newImage, compression);
        sizeOrigin = [imageData length];
        sizeOriginKB = sizeOrigin / 1024;
    }
    
    return imageData;
}

/**
 *  截取指定时间的视频缩略图
 *
 *  @param timeBySecond 时间点，单位：s
 */
+ (UIImage *)thumbnailImageRequestWithVideoUrl:(NSURL *)videoUrl andTime:(CGFloat)timeBySecond {
    if (videoUrl == nil) {
        return nil;
    }
    
    AVURLAsset *urlAsset = [AVURLAsset assetWithURL:videoUrl];
    
    //根据AVURLAsset创建AVAssetImageGenerator
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    /*截图
     * requestTime:缩略图创建时间
     * actualTime:缩略图实际生成的时间
     */
    NSError *error = nil;
    CMTime requestTime = CMTimeMakeWithSeconds(timeBySecond, 10); //CMTime是表示电影时间信息的结构体，第一个参数表示是视频第几秒，第二个参数表示每秒帧数.(如果要活的某一秒的第几帧可以使用CMTimeMake方法)
    CMTime actualTime;
    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:requestTime actualTime:&actualTime error:&error];
    if(error) {
        NSLog(@"截取视频缩略图时发生错误，错误信息：%@", error.localizedDescription);
        return nil;
    }
    
    CMTimeShow(actualTime);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    UIImage *finalImage = nil;
    UIDeviceOrientation shootingOrientation = [self degressFromVideoFileWithAsset:urlAsset];
    if (shootingOrientation == UIDeviceOrientationLandscapeRight) {
        finalImage = [self rotateImage:image withOrientation:UIImageOrientationDown];
    }
    else if (shootingOrientation == UIDeviceOrientationLandscapeLeft) {
        finalImage = [self rotateImage:image withOrientation:UIImageOrientationUp];
    }
    else if (shootingOrientation == UIDeviceOrientationPortraitUpsideDown) {
        finalImage = [self rotateImage:image withOrientation:UIImageOrientationLeft];
    }
    else
    {
        finalImage = [self rotateImage:image withOrientation:UIImageOrientationRight];
    }
    
    return finalImage;
}

#pragma mark - private

+ (UIDeviceOrientation)degressFromVideoFileWithAsset:(AVAsset *)asset {
    int degress = 0;
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if([tracks count] > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGAffineTransform t = videoTrack.preferredTransform;
        if(t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0){
            // Portrait
            degress = UIDeviceOrientationPortrait;
        } else if(t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0){
            // PortraitUpsideDown
            degress = UIDeviceOrientationPortraitUpsideDown;
        } else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0){
            // LandscapeRight
            degress = UIDeviceOrientationLandscapeRight;
        } else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
            // LandscapeLeft
            degress = UIDeviceOrientationLandscapeLeft;
        }
    }
    return degress;
}

/**
 *  图片旋转
 */
+ (UIImage *)rotateImage:(UIImage *)image withOrientation:(UIImageOrientation)orientation {
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

@end
