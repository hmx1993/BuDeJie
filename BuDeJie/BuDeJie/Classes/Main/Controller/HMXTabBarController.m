//
//  HMXTabBarController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTabBarController.h"
#import "HMXEssenceViewController.h"
#import "HMXNewViewController.h"
#import "HMXPublishViewController.h"
#import "HMXFriendTrendViewController.h"
#import "HMXMeViewController.h"
#import "HMXTabBar.h"
@interface HMXTabBarController ()

@end

@implementation HMXTabBarController

+(void)load{
    
    //获取当前类下面所有的TabBarItem
    UITabBarItem *item = [UITabBarItem appearance];
    
    //设置选中状态下的字体颜色
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    [item setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    
    //设置字体大小(字体大小由正常状态下的字体大小决定)
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    
    dict1[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    [item setTitleTextAttributes:dict1 forState:UIControlStateNormal];
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.0 添加所有自控制器
    [self addAllChildController];
    
    //2.0 设置所有按钮的内容
    [self setAllButton];
    
    HMXTabBar *tabBar = [[HMXTabBar alloc] init];
    
    [self setValue:tabBar forKey:@"tabBar"];
 
}


//添加所有自控制器
-(void)addAllChildController{
    
    //1.0 创建子控制器
    //精华
    HMXEssenceViewController *essence = [[HMXEssenceViewController alloc] init];
    essence.view.backgroundColor = [UIColor purpleColor];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:essence];
    
    //新帖
    HMXNewViewController *new = [[HMXNewViewController alloc] init];
    new.view.backgroundColor = [UIColor cyanColor];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:new];
    
//    //发布
//    HMXPublishViewController *publish = [[HMXPublishViewController alloc] init];
//    publish.view.backgroundColor = [UIColor yellowColor];
    
    //关注
    HMXFriendTrendViewController *friendTrend = [[HMXFriendTrendViewController alloc] init];
    friendTrend.view.backgroundColor = [UIColor orangeColor];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:friendTrend];
    
    //我
    HMXMeViewController *me = [[HMXMeViewController alloc] init];
    me.view.backgroundColor = [UIColor redColor];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:me];
    
    //2.0 添加子控制器
    [self addChildViewController:nav1];
    [self addChildViewController:nav2];
//    [self addChildViewController:publish];
    [self addChildViewController:nav3];
    [self addChildViewController:nav4];
}

//设置所有按钮的内容
-(void)setAllButton
{
    
    //精华
    UINavigationController *nva1 = self.childViewControllers[0];
    nva1.tabBarItem.title = @"精华";
    nva1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nva1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    //新帖
    UINavigationController *nva2 = self.childViewControllers[1];
    nva2.tabBarItem.title = @"新帖";
    nva2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nva2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    
    //发布
//    UIViewController *VC = self.childViewControllers[2];
//    VC.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    VC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_publish_click_icon"];
    
    //关注
    UINavigationController *nva3 = self.childViewControllers[2];
    nva3.tabBarItem.title = @"关注";
    nva3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nva3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    
    //我的
    UINavigationController *nva4 = self.childViewControllers[3];
    nva4.tabBarItem.title = @"我的";
    nva4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nva4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    
}

@end
