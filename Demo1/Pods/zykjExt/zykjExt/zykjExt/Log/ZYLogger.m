//
//  ZYLogger.m
//
//  MIT License
//  Copyright (c) [2017] [Tushar Mohan]
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "ZYLogger.h"

@implementation ZYLogger

+ (void)log:(Class)theClass level:(LogLevelV1)logLevel func:(NSString *)func line:(int)line str:(NSString*)str {
    
    //生产环境不要log
#if POD_CONFIGURATION_RELEASE
    return;
#else
#endif
    
    LogStream streamMode = LOG_STREAM;
    
    if((streamMode == LogStreamNone) || (LOG_LEVEL < logLevel))
        return;
    
    NSString* logIdentifierString;
    
    switch (logLevel)
    {
        case LogLevelInfo:
        {
            logIdentifierString = @"[I]";
            break;
        }
        case LogLevelWarning:
        {
            logIdentifierString = @"[W]";
            break;
        }
        case LogLevelError:
        {
            logIdentifierString = @"[E]";
            break;
        }
        default:
        {
            logIdentifierString = @"[W]";
            break;
        }
    }
    
    NSString* log = [NSString stringWithFormat:@"%@ CLASS-%@ METHOD-%@ Line-%i %@",logIdentifierString, NSStringFromClass(theClass),func, line,str];
    
    switch (streamMode)
    {
        case LogStreamConsole:
            NSLog(@"%@",log);
            break;
            
        case LogStreamFile:
            [self logToFile:log];
            break;
            
        default:
        {
            NSLog(@"%@",log);
            [self logToFile:log];
            
            break;
        }
    }
}

+ (void)getLogFile:(LogFileAccessBlock)handler {
    
    if(!handler)
        return;
    
    NSString* filePath = [self getLogFilePath];
    
    BOOL isOperationComplete = handler(filePath);
    
    if(isOperationComplete && filePath)
    {
        NSFileManager* fileMgr = [NSFileManager defaultManager];
        [fileMgr removeItemAtPath:filePath error:nil];
    }
}

#pragma mark - Private

+ (void)logToFile:(NSString*)log {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"[dd-MM-yyyy HH:mm:ss]";
    
    NSString* timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    
    log = [NSString stringWithFormat:@"%@:%@\n",timeStamp,log];
    
    NSString* logFilePath = [self getLogFilePath];
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
    
    if (fileHandle) {
        
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[log dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
    }
    else {
        
        [log writeToFile:logFilePath atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
    }
}

+ (NSString*)getLogFilePath {
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if (paths.count <= 0)
        return nil;
    
    NSString* dirPath = paths[0];
    
    NSString* filePath = dirPath;
    
    return [filePath stringByAppendingPathComponent:@"log.txt"];
}

@end
