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
    
    //2.0系统的tabBar不能满足我们的要求,因此要自定义tabBar,将系统的tabBar换成自己定义TabBar,但是系统的tabBar是只读的,因此只能用KVC将其改掉,KVC可以直接访问类的成员变量
    [self setValue:[[HMXTabBar alloc] init] forKey:@"tabBar"];
    
}

//添加所有自控制器
-(void)addAllChildController{
    
    //1.0 创建子控制器
    //精华
    HMXEssenceViewController *essence = [[HMXEssenceViewController alloc] init];
    
    [self setUpChildVC:essence title:@"精华" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    
    //新帖
    HMXNewViewController *new = [[HMXNewViewController alloc] init];
    [self setUpChildVC:new title:@"新帖" imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon"];
    
    //关注
    HMXFriendTrendViewController *friendTrend = [[HMXFriendTrendViewController alloc] init];
    [self setUpChildVC:friendTrend title:@"关注" imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon"];
    
    //我
    HMXMeViewController *me = [[HMXMeViewController alloc] init];
    [self setUpChildVC:me title:@"我的" imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon"];
}

//创建一个子控制器
-(void)setUpChildVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    vc.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    [self addChildViewController:nav];
}





@end
