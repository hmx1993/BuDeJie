//
//  AppDelegate.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建窗口
    self.window = [[UIWindow alloc] init];
    
    //2.设置窗口的根控制器
    UITabBarController *tabBarVc = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBarVc;
    
    //添加所有自控制器
    [self addAllChildController];
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}
//添加所有自控制器
-(void)addAllChildController{
    //精华
    UIViewController *essence = [[UIViewController alloc] init];
    essence.view.backgroundColor = [UIColor purpleColor];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:essence];
    //新帖
    UIViewController *new = [[UIViewController alloc] init];
    new.view.backgroundColor = [UIColor cyanColor];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:new];
    //发布
    UIViewController *publish = [[UIViewController alloc] init];
    publish.view.backgroundColor = [UIColor yellowColor];
    
    //关注
    UIViewController *friendTrend = [[UIViewController alloc] init];
    friendTrend.view.backgroundColor = [UIColor orangeColor];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:friendTrend];
    
    //我
    UITableViewController *me = [[UITableViewController alloc] init];
    me.view.backgroundColor = [UIColor redColor];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:me];
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
