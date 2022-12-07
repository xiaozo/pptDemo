//
//  NSObject+ZykjDeepCopy.m
//  ZykjFoundation
//
//  Created by lyman on 2022/1/7.
//  Copyright © 2022 zoulixiang. All rights reserved.
//

#import "NSObject+ZykjDeepCopy.h"
#import "objc/runtime.h"

@implementation NSObject (ZykjDeepCopy)

- (instancetype)zykjDeepCopy{
    id deepCopiedObj = [self.class new];
    NSArray* properties = [self zykjPropertyNamesForClass:self.class];
    for (NSString* propertyName in properties) {
        id value = [self valueForKey:propertyName];
        // todo 是否有其他类型
        if ([value isKindOfClass:NSString.class] || [value isKindOfClass:NSNumber.class]) {
            value = [value copy];
        } else if ([value isKindOfClass:NSObject.class] && [((NSObject*)value) respondsToSelector:@selector(zykjDeepCopy)] ) {
            value = [((NSObject*)value) zykjDeepCopy];
        }
        [deepCopiedObj setValue:value forKey:propertyName];
    }
    return deepCopiedObj;
}

/// 获取本类及所有父类的所有属性名字列表
- (NSArray<NSString*>*)zykjPropertyNamesForClass:(Class)class{
    NSMutableArray  *propertyNames = [[NSMutableArray alloc] init];
    if (class_getSuperclass(class) != NSObject.class) {
        [propertyNames addObjectsFromArray:[self zykjPropertyNamesForClass:class_getSuperclass(class)]];
    }
    if (class == NSNumber.class) {
        return @[];
    }
    unsigned int     propertyCount = 0;
    objc_property_t *properties    = class_copyPropertyList(class, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t  property = properties[i];
        const char      *name     = property_getName(property);
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNames;
}
@end


@implementation NSArray (ZykjDeepCopy)

- (instancetype)zykjDeepCopy {
    return [[NSArray alloc] initWithArray:self copyItems:YES];
}

@end

@implementation NSDictionary (ZykjDeepCopy)

- (instancetype)zykjDeepCopy {
    return [[NSDictionary alloc] initWithDictionary:self copyItems:YES];
}

@end
