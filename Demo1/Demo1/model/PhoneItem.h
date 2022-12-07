//
//  PhoneItem.h
//  Demo1
//
//  Created by DeerClass on 2022/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhoneItem : NSObject

@property (copy, nonatomic) NSString *phone;

@property (assign, nonatomic) BOOL isAnswer;

@property (copy, nonatomic) NSString *site;

@property (copy, nonatomic) NSString *time;

@end

NS_ASSUME_NONNULL_END
