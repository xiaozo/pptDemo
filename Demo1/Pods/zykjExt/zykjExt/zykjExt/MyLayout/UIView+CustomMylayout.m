//
//  UIView+CustomMylayout.m
//  ZykjFoundation
//
//  Created by DeerClass on 2021/9/1.
//  Copyright © 2021 zoulixiang. All rights reserved.
//

#import "UIView+CustomMylayout.h"
#import "MyLinearLayout.h"

@implementation UIView (CustomMylayout)

//是否已经包住外层MyLinearLayout
- (BOOL)isWrapSuperView {
    return ([self isKindOfClass:MyLinearLayout.class] && self.tag == kWrapSuperViewTag);
}

@end
