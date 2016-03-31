//
//  HMXMeViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXMeViewController.h"

@interface HMXMeViewController ()

@end

@implementation HMXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    self.navigationItem.title = @"我的";
    
    //添加设置按钮
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:@"mine-setting-icon" heighLightImage:@"mine-setting-icon-click" target:self action:@selector(settingBtnClick:)];
    //添加夜间模式设置按钮
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:@"mine-moon-icon" heighLightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeBtnClick:)];
    
    //添加Items
    NSArray *itemArray = @[item1,item2];
    self.navigationItem.rightBarButtonItems = itemArray;
    
    self.view.backgroundColor = globleBg;
}

-(void)settingBtnClick:(UIButton *)btn
{
    HMXLog(@"设置按钮被点击了");
}
-(void)nightModeBtnClick:(UIButton *)btn
{
    HMXLog(@"夜间模式按钮被点击了");
}

@end
