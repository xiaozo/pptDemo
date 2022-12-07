//
//  BaseUtilsMacro.h
//  ZykjFoundation
//
//  Created by DeerClass on 2021/7/30.
//  Copyright © 2021 zoulixiang. All rights reserved.
//

#ifndef BaseUtilsMacro_h
#define BaseUtilsMacro_h


static __inline__ CGFloat MainScreenWidth()
{
    return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
}

static __inline__ CGFloat MainScreenHeight()
{
        return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;
}

/**
 Synthsize a weak or strong reference.
 
 Example:
    @weakify(self)
    [self doSomething^{
        @strongify(self)
        if (!self) return;
        ...
    }];

 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

// 判断是否是12.9英寸的ipad
#define DEVICES_IS_PRO_12_9 ([UIScreen mainScreen].bounds.size.width == 1366)
#define SCALE_TO_PRO (DEVICES_IS_PRO_12_9? (1366.0/1024.0): 1)
// 判断是否高清屏
#define isRetina ([UIScreen instancesRespondToSelector:@selector(scale)] ? (2 == [[UIScreen mainScreen] scale]) : NO)

#define PROGRAMNAME @""

#define XCODE_COLORS_ESCAPE_IOS                    @"\033["

#define XCODE_COLORS_ESCAPE                        XCODE_COLORS_ESCAPE_IOS

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;"                 // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;"                 // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"                   // Clear any foreground or background color

#define LogPink(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg209,57,168;" XCODE_COLORS_ESCAPE @"bg255,255,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogBlue(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,150,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogRed(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg250,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogGreen(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,235,30;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

//! 1、XCode中设置控制
// Target > Get Info > Build > GCC_PREPROCESSOR_DEFINITIONS
// Configuration = Release: <empty>
//               = Debug:   DEBUG_MODE=1
//！2、人为控制
//#define DEBUG
#ifdef DEBUG
#define DELOG(...) NSLog(__VA_ARGS__)
#define DELOGPINK(...) LogPink(__VA_ARGS__)
#define DELOGBLUE(...) LogBlue(__VA_ARGS__)
#define DELOGRED(...) LogRed(__VA_ARGS__)
#else
#define DELOG(...) do { } while (0);
#define DELOGPINK(...) do { } while (0);
#define DELOGBLUE(...) do { } while (0);
#define DELOGRED(...) do { } while (0);
#endif

/*
 #define DELOG( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
 #else
 #define DELOG( s, ... )
 #endif
*/

#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]

#define MainScreen                          [UIScreen mainScreen]
#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)

#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y

#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height

#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))

#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)

#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsIOS7Later                         !(IOSVersion < 7.0)
#define IsIOS9Later                          !(IOSVersion < 9.0)
#define IsIOS10Later                          !(IOSVersion < 10.0)
#define IsIOS11Later                          !(IOSVersion < 11.0)
#define IsIOS13Later                          !(IOSVersion < 13.0)
///是否pad
#define kISiPad ([[UIDevice currentDevice].model isEqualToString:@"iPad"])
///是否是手机
#define kISiPone ([[UIDevice currentDevice].model isEqualToString:@"iPhone"])

#define StatusbarSize ((IOSVersion >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define ViewCtrlTopBarHeight                (IsiOS7Later ? (NaviBarHeight + StatusBarHeight) : NaviBarHeight)
#define IsUseIOS7SystemSwipeGoBack          (IsiOS7Later ? YES : NO)

#define YOURSYSTEM_OR_LATER(yoursystem) [[[UIDevice currentDevice] systemVersion] compare:(yoursystem)] != NSOrderedAscending

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#define UIIMAGE_RESIZE(image)  [image stretchableImageWithLeftCapWidth:floorf(image.size.width / 2) topCapHeight:floorf(image.size.height / 2)]

#define IMAGE_RESIZE(image, top, left, bottom, right)    [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch]


//主窗口的宽、高
#define kMainScreenWidth  MainScreenWidth()
#define kMainScreenHeight MainScreenHeight()

#define Localized(Str) NSLocalizedString(Str, Str)

//iphonex适配
#define HT_iPhoneX ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window  = [[UIApplication sharedApplication].windows firstObject]; \
    if (window == nil) { \
        window =  [[UIApplication sharedApplication] delegate].window; \
    } \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})
// UIScreen width.
#define  HT_ScreenWidth   [UIScreen mainScreen].bounds.size.width

// UIScreen height.
#define  HT_ScreenHeight  [UIScreen mainScreen].bounds.size.height
// iPhone X
//#define  HT_iPhoneX (((HT_ScreenWidth == 375.f && HT_ScreenHeight == 812.f) || (HT_ScreenWidth == 414.f && HT_ScreenHeight == 896.f)) ? YES : NO)

// Status bar height.
#define  HT_StatusBarHeight      (HT_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define  HT_NavigationBarHeight  44.f

// Tabbar height.
#define  HT_TabbarHeight         (HT_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar height.
#define  HT_TabbarHeight_normal         49.f

// Tabbar safe bottom margin.
#define  HT_TabbarSafeBottomMargin         (HT_iPhoneX ? 34.f : 0.f)

// Tabbar safe top margin.
#define  HT_NavSafeTopMargin         (HT_iPhoneX ? 24.f : 0.f)

// Status bar & navigation bar height.
#define  HT_StatusBarAndNavigationBarHeight  (HT_iPhoneX ? 88.f : 64.f)

#define HT_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#define WS(weakSelf)   __weak __typeof(self)weakSelf = self;

#define WVAR(variable,instancetype)   __weak __typeof(instancetype)variable = instancetype;

#define KIsKindOfClass(instancetype,classes)  ([instancetype isKindOfClass:classes])

#define degreeToRadians(x) (M_PI *(x)/180.0)

#define empty_array         [NSArray array]

static const NSInteger NSDefaultValue = NSIntegerMax;

#endif /* BaseUtilsMacro_h */
