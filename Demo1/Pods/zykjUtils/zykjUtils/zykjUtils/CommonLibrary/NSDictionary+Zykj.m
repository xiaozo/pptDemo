//
//  NSDictionary+Zykj.m
//  zykjApp
//
//  Created by lyman on 2020/1/16.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "NSDictionary+Zykj.h"


@implementation NSDictionary (Zykj)


+ (NSDictionary*) modelPropertiesFromDicts: (NSArray<NSDictionary *> *)keysDict andModels:(NSArray<NSObject *> *)models {
    if (keysDict.count != models.count) {
        return nil;
    }
    NSMutableDictionary *paramdict = @{}.mutableCopy;
    for (int i = 0; i< keysDict.count; i++) {
        NSObject *model =  models[i];
        NSDictionary *dict = keysDict[i];
        
        NSArray<NSString *> *subkeys = dict.allKeys;
        for (int j = 0; j < subkeys.count; j++) {
            NSString *keyStr = subkeys[j];
            NSString *vcProName = dict[keyStr];
            vcProName = vcProName.length == 0 ? keyStr : vcProName;
             SEL sel = NSSelectorFromString(keyStr);
            if (j == 0) {
                if ([vcProName isEqualToString:@"-m"]) {
                    ///直接赋值模型
                    ///重新复制属性名
                    vcProName = keyStr;
                     paramdict[vcProName] = model;
                    break;
                } else if (![model respondsToSelector:sel]){
                    NSBundle *bundle1 = [NSBundle bundleForClass:[model class]];
                    if (bundle1 != [NSBundle mainBundle]) {
                        ///系统类直接赋值
                        paramdict[vcProName] = model;
                        break;
                    }
                }
            }
            
            if ([model respondsToSelector:sel]) {
                NSObject *subValue = [model valueForKey:keyStr];
                
                if (subValue) {
                    paramdict[vcProName] = subValue;
                }
            }
           
           
        }
    }
    return paramdict;
}

@end
