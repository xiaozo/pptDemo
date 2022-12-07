//
//  ZYLogger.h
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

#import <Foundation/Foundation.h>

#define LOG_STREAM LogStreamBoth
#define LOG_LEVEL LogLevelAll

typedef BOOL (^LogFileAccessBlock)(NSString* filePath);

typedef NS_ENUM(NSInteger, LogStream)
{
    LogStreamNone = 0,
    LogStreamConsole,
    LogStreamFile,
    LogStreamBoth
};

typedef NS_ENUM(NSInteger, LogLevelV1)
{
    LogLevelNone = 0,
    LogLevelInfo,
    LogLevelWarning,
    LogLevelError,
    LogLevelAll
};

#define ZYFileLogInfo(arg, ... ) [ZYLogger log: [self class] level: LogLevelInfo func: NSStringFromSelector(_cmd) line: __LINE__ str: [NSString stringWithFormat:(arg), ##__VA_ARGS__]]
#define ZYFileLogWarning( arg, ... ) [ZYLogger log: [self class] level: LogLevelWarning func: NSStringFromSelector(_cmd) line: __LINE__ str: [NSString stringWithFormat:(arg), ##__VA_ARGS__]]
#define ZYFileLogError( arg, ... ) [ZYLogger log: [self class] level: LogLevelError func: NSStringFromSelector(_cmd) line: __LINE__ str: [NSString stringWithFormat:(arg), ##__VA_ARGS__]]

@interface ZYLogger : NSObject

+ (void)getLogFile:(LogFileAccessBlock)handler;
+ (void)log:(Class)theClass level:(LogLevelV1)logLevel func:(NSString *)func line:(int)line str:(NSString*)str;

@end
