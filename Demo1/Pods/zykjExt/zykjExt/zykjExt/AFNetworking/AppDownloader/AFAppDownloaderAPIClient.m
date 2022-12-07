//
//  AFAppDownloaderAPIClient.m
//  ZykjAppWork
//
//  Created by jsl on 2019/8/23.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import "AFAppDownloaderAPIClient.h"

@interface AFAppDownloaderAPIClient()

@property (strong, nonatomic) NSMutableDictionary *downloaderAPIModelDict;

@end

@implementation AFAppDownloaderAPIClient

+ (instancetype)sharedClient {
    static AFAppDownloaderAPIClient *_sharedClientAFAppDownloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClientAFAppDownloader = [AFAppDownloaderAPIClient manager];
        _sharedClientAFAppDownloader.requestSerializer.timeoutInterval = 40;
        _sharedClientAFAppDownloader.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
        
        //https
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        // 如果是需要验证自建证书，需要设置为YES
        securityPolicy.allowInvalidCertificates = YES;
        [securityPolicy setValidatesDomainName:NO];
        _sharedClientAFAppDownloader.securityPolicy = securityPolicy;
        
        _sharedClientAFAppDownloader.downloaderAPIModelDict = @{}.mutableCopy;
    });
    
    return _sharedClientAFAppDownloader;
}

#pragma mark -
- (AFAppDownloaderAPIModel *)downloaderAPIModelWithKey:(NSString *)key {
    @synchronized (self) {
        AFAppDownloaderAPIModel *model = self.downloaderAPIModelDict[key];
        if (model.downloadTask.error) {
            [self setDownloaderAPIModelWithKey:key downloaderAPIModel:nil];
        }
        return self.downloaderAPIModelDict[key];
    }
   
}

- (void)setDownloaderAPIModelWithKey:(NSString *)key downloaderAPIModel:(AFAppDownloaderAPIModel *)downloaderAPIModel {
    @synchronized (self) {
        if (self.downloaderAPIModelDict[key] && downloaderAPIModel == nil) {
            //清空 说明下载好要清空
            [self.downloaderAPIModelDict removeObjectForKey:key];
        }
        
        if (self.downloaderAPIModelDict[key]) {
            //如果有值return
            return;
        }
        
        self.downloaderAPIModelDict[key] = downloaderAPIModel;
    }
    
}
@end
