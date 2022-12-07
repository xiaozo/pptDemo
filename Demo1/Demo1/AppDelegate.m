//
//  AppDelegate.m
//  Demo1
//
//  Created by DeerClass on 2022/9/8.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"项目初始化");
    
//    /创建window
//        UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//        window.backgroundColor = [UIColor whiteColor];
//    
//        ViewController *vc = [[ViewController alloc] init];
//        window.rootViewController = vc;
//    
//        ///是该window成为主key且显示出来
//        [window makeKeyAndVisible];
//    
//        self.window = window;
    
    
    
//    ///创建window
//    UIWindow *window = [[UIWindow alloc] initWithFrame:ScreenRect];
//    window.backgroundColor = kWhiteColor;
//
//    ///创建个人收藏的控制器
//    UIViewController *dst = [[UIViewController alloc] init];
//    if (@available(iOS 13.0, *)) {
//        dst.tabBarItem.image = [UIImage systemImageNamed:@"star.fill"];
//    } else {
//        // Fallback on earlier versions
//    }
//    dst.tabBarItem.title = @"个人收藏";
//
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//
//    //由storyboard根据viewid的storyBoardID来获取我们视图
//    UIViewController *dst1 = [story instantiateViewControllerWithIdentifier:@"viewid"];
//    if (@available(iOS 13.0, *)) {
//        dst1.tabBarItem.image = [UIImage systemImageNamed:@"clock.fill"];
//    } else {
//        // Fallback on earlier versions
//    }
//    dst1.tabBarItem.title = @"最近通话";
//
//    UIViewController *dst2 = [[UIViewController alloc] init];
//    if (@available(iOS 13.0, *)) {
//        dst2.tabBarItem.image = [UIImage systemImageNamed:@"person.crop.circle.fill"];
//    } else {
//        // Fallback on earlier versions
//    }
//    dst2.tabBarItem.title = @"通讯录";
//
//    UIViewController *dst3 = [[UIViewController alloc] init];
//    if (@available(iOS 13.0, *)) {
//        dst3.tabBarItem.image = [UIImage systemImageNamed:@"circle.grid.3x3.fill"];
//    } else {
//        // Fallback on earlier versions
//    }
//    dst3.tabBarItem.title = @"拨号键盘";
//
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//    [tabBarController setViewControllers:@[dst,dst1,dst2,dst3]];
//
//    window.rootViewController = tabBarController;
//
//    ///是该window成为主key且显示出来
//    [window makeKeyAndVisible];
//
//    self.window = window;
    
    return YES;
    
}

- (void)applicationDidEnterBackground:(UIApplication  *)application {
    NSLog(@"程序从前台进入后台的调用");
}
-  (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"程序从后台将要重新回到前台时候调用");
}

-  (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"程序将要销毁的时候调用,可以做一些保存的数据");
}

@end
