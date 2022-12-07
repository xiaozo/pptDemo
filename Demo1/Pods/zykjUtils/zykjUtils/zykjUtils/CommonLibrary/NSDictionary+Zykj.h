//
//  NSDictionary+Zykj.h
//  zykjApp
//
//  Created by lyman on 2020/1/16.
//  Copyright © 2020 zoulixiang. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Zykj)

/**
 
 NSDictionary *dict = [self converKeysDict:@[
     @{
         @"class_student_id" : @"ClassStudentId",
         @"class_id" : @"ClassId"
     },
     @{
         @"student_id" : @"StudentId"
     },
     @{
         @"name" : @""
         
     },
     @{
         @"age" : @""
     },
 @{
         @"model" : @"-m"
     },
 ]
                                models:@[
                                    model1,
                                    model2,
                                    @"消化",
                                    @(23),
                                    model1
                                ]];
 字典数组 + model数组 映射到 新的字典
 @param keysDict dic数组 @[@{models属性名: 目标字典key}....]  1.目标字典key==@"-m" 是直接赋值模型
 @param models 模型数组
 @return  新的字典，@{keysDict的value: models.keiDict.key.....}
*/
+ (NSDictionary*) modelPropertiesFromDicts: (NSArray<NSDictionary *> *)keysDict andModels:(NSArray<NSObject *> *)models;

@end

NS_ASSUME_NONNULL_END
