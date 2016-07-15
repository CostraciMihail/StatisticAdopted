//
//  AppDelegate.m
//  StatisticAdopted
//
//  Created by winify on 7/8/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()
{
    UIWindow *window;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = (UINavigationController*)mainSB.instantiateInitialViewController;
    [window makeKeyAndVisible];
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    MainViewController visible
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
//    NSString *strClass = NSStringFromClass([MainViewController class]);
//    
//    id vc = [self getVisibleViewControllerForClass: strClass];
//    
//    MainViewController *visibleVC = (MainViewController*)vc;
//    
//    if (visibleVC) {
//        [visibleVC getStatisticInfo];
//    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (UIViewController*)getVisibleViewControllerForClass: (NSString *)className {
    
    NSLog(@"%@", window);
    
    UINavigationController *navC = (UINavigationController*)window.rootViewController;
    NSLog(@"%@", navC.visibleViewController);
    
    if ((UITabBarController*)navC.visibleViewController) {
        
        UITabBarController *tabBAr = (UITabBarController*)navC.visibleViewController;
        
        if ([tabBAr isKindOfClass:[MainViewController class]]) {
            
            UIViewController *activeVC = tabBAr.selectedViewController;
            
            if ( [NSStringFromClass([activeVC class]) isEqualToString:className]) {
                return activeVC;
            }
        }
        
      
    }

    return  nil;
        
        
        //
//        if let activeVC = tabBar.selectedViewController {
//            if activeVC.isMemberOfClass(classNameVC) {
//                return activeVC
//            }
//        }
//    }
//    
//    return nil
}

@end
