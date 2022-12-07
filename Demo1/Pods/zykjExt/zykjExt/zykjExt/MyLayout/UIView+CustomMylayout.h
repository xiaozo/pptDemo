//
//  UIView+CustomMylayout.h
//  ZykjFoundation
//
//  Created by DeerClass on 2021/9/1.
//  Copyright © 2021 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSInteger kWrapSuperViewTag = 1004;

@interface UIView (CustomMylayout)

//是否外层MyLinearLayout
- (BOOL)isWrapSuperView;

@end

NS_ASSUME_NONNULL_END
