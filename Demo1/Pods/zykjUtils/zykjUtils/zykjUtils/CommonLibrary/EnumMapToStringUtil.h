//
//  EnumMapToStringUtil.h
//
//  枚举映射到 字符串
//  Created by lyman on 2020/11/6.
//  Copyright © 2020 Lyman. All rights reserved.
//

/*
 示例:
    #define A_Name(XX) \
        XX(FirstValue,@"第一个值") \
        XX(SecondValue,@"第二个值") \
        XX(ThirdValue,@"第三个值",=6) \
        ...
    DECLARE_ENUM(EnumTypeName,A_Name)
    DEFINE_ENUM(EnumTypeName,A_Name)
 
    现在,我们可以用枚举   EnumTypeName  它有3个值 FirstValue = 0,  SecondValue = 1, ThirdValue = 6;
    调用 NSString* GetEnumTypeNameString(EnumTypeName name)  可以获得 枚举值对应的字符串     不存在返回 空字符串.
    调用 EnumTypeName GetEnumTypeNameValue(NSString *str) 可以获得 字符串对应的枚举值    不存在返回 NSUInteger的最大值
    we now have an enum EnumTypeName,
    we can get the string value by calling function                             NSString* GetEnumTypeNameString(EnumTypeName name)
    we can also get the EnumTypeName value from NSString type by calling        EnumTypeName GetEnumTypeNameValue(NSString *str)
 */

#ifndef EnumFactory_h
#define EnumFactory_h

// expansion macro for enum value definition
#define ENUM_VALUE(name, ...) name metamacro_at1(__VA_ARGS__),

// expansion macro for enum to string conversion
#define ENUM_CASE(name,...) case name: return (metamacro_at0(__VA_ARGS__));

// expansion macro for string to enum conversion
#define ENUM_STRCMP(name,...) if ([metamacro_at0(__VA_ARGS__) isEqualToString:str]) return name;

/// declare the access function and define enum values
#define DECLARE_ENUM(EnumType,ENUM_DEF) \
    typedef enum  { \
        ENUM_DEF(ENUM_VALUE) \
    } EnumType; \
    CG_INLINE NSString* Get##EnumType##String(EnumType dummy); \
    CG_INLINE EnumType Get##EnumType##Value(NSString *string); \

/// define the access function names
#define DEFINE_ENUM(EnumType,ENUM_DEF) \
    CG_INLINE NSString* Get##EnumType##String(EnumType value) \
  { \
    switch(value) \
    { \
      ENUM_DEF(ENUM_CASE) \
      default: return @""; /* handle input error */ \
    } \
  } \
    CG_INLINE EnumType Get##EnumType##Value(NSString *str) \
  { \
    ENUM_DEF(ENUM_STRCMP) \
    return (EnumType)-1; /* handle input error */ \
  } \


#endif /* EnumFactory_h */
