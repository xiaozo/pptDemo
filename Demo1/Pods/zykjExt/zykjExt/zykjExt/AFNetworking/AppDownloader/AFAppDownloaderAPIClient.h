//
//  AFAppDownloaderAPIClient.h
//  ZykjAppWork
//
//  Created by jsl on 2019/8/23.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFAppDownloaderAPIModel.h"

@interface AFAppDownloaderAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (AFAppDownloaderAPIModel *)downloaderAPIModelWithKey:(NSString *)key;


/**
 添加下载任务

 @param key key
 @param downloaderAPIModel 如果传空 则表示清空下载任务
 */
- (void)setDownloaderAPIModelWithKey:(NSString *)key downloaderAPIModel:(AFAppDownloaderAPIModel *)downloaderAPIModel;
@end

