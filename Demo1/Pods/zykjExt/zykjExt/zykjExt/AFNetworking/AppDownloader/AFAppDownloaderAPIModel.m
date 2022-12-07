//
//  AFAppDownloaderAPIModel.m
//  ZykjAppWork
//
//  Created by jsl on 2019/8/23.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import "AFAppDownloaderAPIModel.h"
#import "AFAppDownloaderAPIClient.h"
#import <AVFoundation/AVFoundation.h>

@interface AFAppDownloaderAPIModel () {
   
}

@property (copy, nonatomic) NSURL *_Nonnull saveFileUrl;

@end

@implementation AFAppDownloaderAPIModel

-(void)dealloc {
    
}

+ (NSString *)pathKey:(NSURL *)url {
    return url.lastPathComponent;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (_delegate && [_delegate respondsToSelector:@selector(aFAppDownloaderAPIModel:progress:)]) {
        [_delegate aFAppDownloaderAPIModel:self progress:progress];
    }
}
- (NSURLSessionDownloadTask *)downloadTask {
    if (_downloadTask == nil) {
        if (self.url && self.saveFileUrl) {
            __weak __typeof(self)ws = self;
            AFAppDownloaderAPIClient *client = [AFAppDownloaderAPIClient sharedClient];
            //请求
            NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
            //下载Task操作
            _downloadTask = [client downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                
                // @property int64_t totalUnitCount;  需要下载文件的总大小
                // @property int64_t completedUnitCount; 当前已经下载的大小
                
                // 给Progress添加监听 KVO
                NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                // 回到主队列刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    ws.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
                });
                
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                
//                - block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径、
                 //- 直接在里面copy到目标路径
                if (ws.saveFileUrl.path) {
                    [[NSFileManager defaultManager] removeItemAtPath:ws.saveFileUrl.path error:nil];
                    [[NSFileManager defaultManager] copyItemAtPath:targetPath.path toPath:ws.saveFileUrl.path error:nil];
                    [[NSFileManager defaultManager] removeItemAtPath:targetPath.path error:nil];
                }
                 return nil;
                
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                
                if (!error) {
                    //判断文件是否存在
                    NSString *savePath = ws.saveFileUrl.path;
                    if (savePath.length) {
                        
                        if (![[NSFileManager defaultManager] fileExistsAtPath:savePath]) {
                            error = [NSError errorWithDomain:AVFoundationErrorDomain code:AVErrorExportFailed userInfo:@
                                     {
                            NSLocalizedDescriptionKey: @"file not exit"
                            }];
                        }
                    }
                }
                
                // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
                if (!error) {
                    ws.progress = 1.0;
                    
                    if (ws.delegate && [ws.delegate respondsToSelector:@selector(completeAFAppDownloaderAPIModel:saveFilePath:)]) {
                        [ws.delegate completeAFAppDownloaderAPIModel:ws saveFilePath:ws.saveFileUrl.path];
                    }
                    [ws clean];
                } else {
                   
                    if (ws.delegate && [ws.delegate respondsToSelector:@selector(errorAFAppDownloaderAPIModel:error:)]) {
                        [ws.delegate errorAFAppDownloaderAPIModel:ws error:error];
                    }
                    
                    [ws clean];
                   
                }
               
                
                
            }];
            
        }
        
    }
    return _downloadTask;
}
+ (instancetype)AFAppDownloaderAPIModelWithUrl:(NSURL *)url saveFilePath:(NSString *)saveFilePath {
   
    if (!url || saveFilePath.length == 0) {
        return nil;
    }
    NSURL *saveFileUrl = [NSURL URLWithString:saveFilePath];
    
    NSString *pathKey = [AFAppDownloaderAPIModel pathKey:saveFileUrl];
    AFAppDownloaderAPIClient *client = [AFAppDownloaderAPIClient sharedClient];
    
    AFAppDownloaderAPIModel *model = [client downloaderAPIModelWithKey:pathKey];
    
   
    if (model) {
        //如果有创建就不要在创建了
        return [client downloaderAPIModelWithKey:pathKey];
    } else {
        //没有重新创建
        model = [[AFAppDownloaderAPIModel alloc] init];
        model.url = url;
        model.progress = 0;
        model.saveFileUrl = saveFileUrl;
        
        //全局储存
        [client setDownloaderAPIModelWithKey:pathKey downloaderAPIModel:model];
    }
    
    return model;
}

- (void)resume {
    [self action:1];
}

- (void)suspend {
    [self action:2];
}

- (void)clean {
   [self action:3];
}



/**
 执行行为

 @param type 1:resume 继续或者开始下载   2：suspend //暂停下载  3:清空
 */
- (void)action:(NSInteger)type {
    @synchronized (self) {
        @try {
            NSString *pathKey = [AFAppDownloaderAPIModel pathKey:self.saveFileUrl];
            AFAppDownloaderAPIClient *client = [AFAppDownloaderAPIClient sharedClient];
            if (type == 1) {
                //继续或者开始下载
                 [self.downloadTask resume];
            } else if (type == 2) {
                //暂停下载
                [self.downloadTask suspend];
            } else if (type == 3) {
                //清空
                _downloadTask = nil;
                [client setDownloaderAPIModelWithKey:pathKey downloaderAPIModel:nil];
            }
        } @catch (NSException *exception) {
            
        }
        
    }
}
@end
