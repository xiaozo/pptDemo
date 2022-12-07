//
//  AFAppDownloaderAPIModel.h
//  ZykjAppWork
//
//  Created by jsl on 2019/8/23.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFAppDownloaderAPIModel;

@protocol AFAppDownloaderAPIModelDelegate <NSObject>

//下载进度回调
- (void)aFAppDownloaderAPIModel:(AFAppDownloaderAPIModel *)downloaderAPIModel progress:(CGFloat)progress;

- (void)completeAFAppDownloaderAPIModel:(AFAppDownloaderAPIModel *)downloaderAPIModel saveFilePath:(NSString *)saveFilePath;

- (void)errorAFAppDownloaderAPIModel:(AFAppDownloaderAPIModel *)downloaderAPIModel error:(NSError *)error;

@end

@interface AFAppDownloaderAPIModel : NSObject

@property (copy, nonatomic) NSURL *url;

@property (assign, nonatomic) CGFloat progress;

@property (weak, nonatomic) id <AFAppDownloaderAPIModelDelegate> delegate;

// 下载操作
@property (strong, nonatomic) NSURLSessionDownloadTask *downloadTask;

/**
 实例

 @param url 下载url
 @param saveFilePath 储存路径
 @return 实例
 */
+ (instancetype)AFAppDownloaderAPIModelWithUrl:(NSURL *)url saveFilePath:(NSString *)saveFilePath;

//开始下载
- (void)resume;

//暂停下载
- (void)suspend;

//根据url获得key
+ (NSString *)pathKey:(NSURL *)url;

@end

